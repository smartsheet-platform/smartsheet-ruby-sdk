module Smartsheet
  module API
    # Constructs headers for accessing the Smartsheet API
    class HeaderBuilder
      def initialize(token)
        @token = token
        @endpoint_spec = nil
        @request_spec = nil
      end

      def for_endpoint(endpoint_spec)
        self.endpoint_spec = endpoint_spec
        self
      end

      def for_request(request_spec)
        self.request_spec = request_spec
        self
      end

      def apply(req)
        req.headers =
          base_headers
            .merge(endpoint_headers)
            .merge(json_header)
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

      def json_header
        if endpoint_spec.sending_json? && request_spec.body
          { :'Content-Type' => 'application/json' }
        else
          {}
        end
      end

      def request_headers
        request_spec.header_overrides
      end
    end
  end
end