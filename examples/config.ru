require 'sinatra/base'
require 'omniauth-redbooth'
require 'multi_json'
require 'pry'

class OmniauthRedbooth < Sinatra::Base

  before do
    content_type 'application/json'
  end

  get '/' do
    content_type 'text/html'
    <<-HTML
      <a href="/auth/redbooth">Sign in with Redbooth</a>
    HTML
  end

  get '/auth/:provider/callback' do
    request
    MultiJson.encode(request.env['omniauth.auth'])
  end

  get '/auth/failure' do
    request
    MultiJson.encode(request.env)
  end

  get '/refresh_token' do
    client_id = ENV['CONSUMER_KEY']
    client_secret = ENV['CONSUMER_SECRET']
    oauth2_urls = {
      site: 'http://localhost:3000/api/2',
      token_url: 'http://localhost:3000/oauth2/token',
      authorize_url: 'http://localhost:3000/oauth2/authorize'
    }

    @oauth2_client = OAuth2::Client.new(client_id, client_secret, oauth2_urls)
    @access_token = OAuth2::AccessToken.new(@oauth2_client, params[:access_token])
    refresh_access_token_obj = OAuth2::AccessToken.new(@oauth2_client, @access_token.token, {'refresh_token' => params[:refresh_token]})
    @access_token = refresh_access_token_obj.refresh!

    @access_token.inspect
  end
end

use Rack::Session::Cookie, :secret => 'secret identity'

use OmniAuth::Builder do
  provider :redbooth, 
    ENV['CONSUMER_KEY'] || '_your_consumer_key_', 
    ENV['CONSUMER_SECRET'] || '_your_consumer_secret_',
    client_options: {
      site: 'http://localhost:3000/api/3',
      token_url: 'http://localhost:3000/oauth2/token',
      authorize_url: 'http://localhost:3000/oauth2/authorize'
    },
    scope: 'all'
end

run OmniauthRedbooth.new
