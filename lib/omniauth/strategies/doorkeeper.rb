module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper
      option :client_options, site: 'https://funplat.herokuapp.com', authorize_path: '/oauth/authorize'

      uid { raw_info['id'] }

      info do
        { email: raw_info['email'] }
      end

      def raw_info
        @raw_info ||= JSON.parse(access_token.get('api/v1/me').response.body)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end