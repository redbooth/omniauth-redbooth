require 'sinatra/base'
require 'omniauth-redbooth'
require 'multi_json'

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
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie, :secret => 'secret identity'

use OmniAuth::Builder do
  provider :redbooth, ENV['CONSUMER_KEY'], ENV['CONSUMER_KEY'],
    client_options: {
      site: 'http://localhost:3000/api/3/',
      token_url: 'http://localhost:3000/oauth2/token',
      authorize_url: 'http://localhost:3000/oauth2/authorize'
    }
end

run OmniauthRedbooth.new
