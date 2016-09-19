require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # @see https://redbooth.com/api/api-docs/
    class Redbooth < OmniAuth::Strategies::OAuth2
      REDBOOTH_URL = 'https://redbooth.com'.freeze

      option :name, 'redbooth'
      option :provider_ignores_state, true
      option :client_options,
             site: "#{REDBOOTH_URL}/api/3",
             authorize_url: "#{REDBOOTH_URL}/oauth2/authorize",
             token_url: "#{REDBOOTH_URL}/oauth2/token"
      option :authorize_params, response_type: 'code'

      uid { raw_info['id'] }

      info do
        {
          name: "#{raw_info['first_name']} #{raw_info['last_name']}",
          email: raw_info['email']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||=
          access_token.get("#{options[:client_options][:site]}/me").parsed
      end
    end
  end
end
