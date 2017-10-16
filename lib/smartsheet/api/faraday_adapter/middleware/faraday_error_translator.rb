require 'faraday'
require 'smartsheet/error'

module Smartsheet
  module API
    module Middleware
      # Raises Faraday request errors as {Smartsheet::RequestError RequestErrors}
      class FaradayErrorTranslator < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          @app.call(env)
        rescue Faraday::Error => e
          raise Smartsheet::RequestError, e
        end
      end
    end
  end
end