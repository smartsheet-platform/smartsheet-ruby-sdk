require 'faraday'
require_relative '../error'

module Smartsheet
  module API
    module Middleware
      class ErrorTranslator < Faraday::Middleware
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