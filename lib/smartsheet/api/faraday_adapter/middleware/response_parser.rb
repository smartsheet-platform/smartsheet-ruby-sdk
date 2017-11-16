require 'faraday'
require 'json'
require 'smartsheet/api/faraday_adapter/faraday_response'

module Smartsheet
  module API
    module Middleware
      # Wraps responses into {FaradayResponse FaradayResponses}, parsing JSON bodies when applicable
      class ResponseParser < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          @app.call(env).on_complete do |response_env|
            if response_env[:response_headers]['content-type'] =~ /\bapplication\/json\b/
              response_env[:body] = JSON.parse(response_env[:body], symbolize_names: true)
            end

            response_env[:body] = FaradayResponse.from_response_env response_env
          end
        end
      end
    end
  end
end