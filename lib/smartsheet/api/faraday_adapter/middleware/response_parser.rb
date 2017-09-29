require 'faraday'
require 'json'
require 'recursive-open-struct'
require 'smartsheet/api/faraday_adapter/faraday_response'

module Smartsheet
  module API
    module Middleware
      class ResponseParser < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          @app.call(env).on_complete do |response_env|
            if response_env[:response_headers]['content-type'] =~ /\bjson\b/
              hash_body = JSON.parse(response_env[:body])
              response_env[:body] = RecursiveOpenStruct.new(hash_body, recurse_over_arrays: true)
            end

            response_env[:body] = FaradayResponse.from_result response_env[:body]
          end
        end
      end
    end
  end
end