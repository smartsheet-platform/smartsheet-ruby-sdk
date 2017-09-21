require 'faraday'
require 'json'
require 'recursive-open-struct'
require_relative '../response'

module Smartsheet
  module API
    module Middleware
      class ResponseParser < Faraday::Middleware
        def initialize(app)
          super(app)
        end

        def call(env)
          response = @app.call(env)

          if env[:response_headers]['content-type'] =~ /\bjson\b/
            hash_body = JSON.parse(env[:body])
            env[:body] = RecursiveOpenStruct.new(hash_body, recurse_over_arrays: true)
          end

          env[:body] = Response.from_result env[:body]

          response
        end
      end
    end
  end
end