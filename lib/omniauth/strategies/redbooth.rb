require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Redbooth < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'redbooth'

      option :provider_ignores_state, true

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        site: 'https://redbooth.com/api/3',
        authorize_url: 'https://redbooth.com/oauth/authorize',
        token_url: 'https://redbooth.com/oauth/token'
      }

      option :authorize_params, {
        response_type: 'code'
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => [ raw_info['first_name'], raw_info['last_name'] ].join(' '),
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("#{options[:client_options][:site]}/account").parsed
      end
    end
  end
end
