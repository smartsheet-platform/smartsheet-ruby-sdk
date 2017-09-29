require 'smartsheet/api/error'
require 'faraday'

module Smartsheet
  module API
    module Middleware
      class FaradayErrorTranslator < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          @app.call(env)
        rescue Faraday::Error => e
          raise Smartsheet::API::RequestError, e
        end
      end
    end
  end
end