module DynamicaAPI
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared

    protected

      def self.headers
        { content_type: :json, accept: :json, 'Authorization' => ActionController::HttpAuthentication::Token.encode_credentials(DynamicaAPI.config.api_token) }
      end

      def self.url_from(path)
        "#{DynamicaAPI.config.url}/api/v1/#{path}"
      end

      def self.get(path, options = {})
        RestClient.get(url_from(path), headers)
      end

      def self.post(path, options = {})
        RestClient.post(url_from(path), options.to_json, headers)
      end

      def self.patch(path, options = {})
        RestClient.patch(url_from(path), options.to_json, headers)
      end

      def self.delete(path, options = {})
        RestClient.delete(url_from(path), headers.merge({ params: options }))
      end

      def get(path, options = {})
        self.class.get(path, options)
      end

      def post(path, options = {})
        self.class.post(path, options)
      end

      def patch(path, options = {})
        self.class.patch(path, options)
      end

      def delete(path, options = {})
        self.class.delete(path, options)
      end

  end
end