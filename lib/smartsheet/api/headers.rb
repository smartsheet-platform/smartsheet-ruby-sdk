module Smartsheet
  module API
    # Tools for building Smartsheet API request headers
    # Mixin expects:
    # - token(): the API token to attach to requests
    # Mixin provides:
    # - build_headers(): generates a default HeaderBuilder
    module Headers
      def build_headers(overrides = {})
        HeaderBuilder.new(token, overrides)
      end

      # Constructs standard headers for accessing the Smartsheet API
      class HeaderBuilder
        attr_accessor :endpoint_specific, :overrides
        attr_reader :token
        private :token

        def initialize(token, overrides = {})
          @token = token
          @endpoint_specific = {}
          @overrides = overrides
        end

        def sending_json
          endpoint_specific[:'Content-Type'] = 'application/json'
          self
        end

        def with_overrides(overrides)
          self.overrides = overrides
          self
        end

        def apply(req)
          req.headers =
            base_headers
            .merge(endpoint_specific)
            .merge(overrides)
          req
        end

        private

        def base_headers
          {
            :Accept => 'application/json',
            :Authorization => "Bearer #{token}",
            :'User-Agent' => 'smartsheet-ruby-sdk'
          }
        end
      end
    end
  end
end