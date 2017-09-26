module Smartsheet
  module API
    # Constructs headers for accessing the Smartsheet API
    class HeaderBuilder
      def initialize(token, endpoint_spec, request_spec)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def build
        base_headers
          .merge(endpoint_headers)
          .merge(content_type)
          .merge(request_headers)
      end

      private

      attr_accessor :endpoint_spec, :request_spec
      attr_reader :token

      def base_headers
        {
          :Accept => 'application/json',
          :Authorization => "Bearer #{token}",
          :'User-Agent' => 'smartsheet-ruby-sdk'
        }
      end

      def endpoint_headers
        endpoint_spec.headers
      end

      def content_type
        content_type = nil

        content_type = 'application/json' if endpoint_spec.sending_json? && request_spec.body

        if content_type.nil?
          {}
        else
          { :'Content-Type' => content_type }
        end
      end

      def request_headers
        request_spec.header_overrides
      end
    end
  end
end