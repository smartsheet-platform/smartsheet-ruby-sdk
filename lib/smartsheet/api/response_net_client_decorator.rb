require 'plissken'

require 'smartsheet/error'

module Smartsheet
  module API
    class ResponseNetClientDecorator
      def initialize(client, json_output: false, logger: MuteRequestLogger.new)
        @json_output = json_output
        @client = client
        @logger = logger
      end

      def make_request(request)
        response = begin
          client.make_request(request)
        rescue Smartsheet::HttpResponseError => e
          logger.log_http_error_response(request, e)
          raise e
        end

        parse(request, response)
      end

      private

      attr_reader :json_output, :client, :logger

      def parse(request, response)
         if response.success?
           logger.log_successful_response(response)
           parse_success(response)
         else
           logger.log_api_error_response(request, response)
           parse_failure(response)
         end
      end

      def parse_success(response)
        if json_output
          response.result.to_json
        elsif response.result.respond_to? :to_snake_keys
          response.result.to_snake_keys
        else
          response.result
        end
      end

      def parse_failure(response)
        raise Smartsheet::ApiError.new(response)
      end
    end
  end
end