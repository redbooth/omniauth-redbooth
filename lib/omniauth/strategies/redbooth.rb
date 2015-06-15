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
        authorize_url: 'https://redbooth.com/oauth2/authorize',
        token_url: 'https://redbooth.com/oauth2/token'
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
        @raw_info ||= access_token.get("#{options[:client_options][:site]}/me").parsed
      end

      # Override OmniAuth's `request` method and make sure that
      # `request.url` is properly defined when `PATH_INFO` doesn't
      # start with a slash.
      #
      # This is needed because when mounting an engine on the root,
      # the `path_prefix` cannot start with a slash. Because of that
      # `request.url` becomes host:portpath (notice the lack of a slash).
      #
      # This code sets the `SCRIPT_NAME` environment variable to a slash
      # if it's empty (meaning that it's the root) and then calls
      # the parent code which instantiates a request.
      def request
        @env['SCRIPT_NAME'] = '/' if @env['SCRIPT_NAME'] == ''
        super
      end
    end
  end
end
