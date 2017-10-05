require 'plissken'

require 'smartsheet/api/error'

module Smartsheet
  module API
    class ResponseNetClientDecorator
      def initialize(client, json_output: false, logger: MuteRequestLogger.new)
        @json_output = json_output
        @client = client
        @logger = logger
      end

      def make_request(request)
        parse(request, client.make_request(request))
      end

      private

      attr_reader :json_output, :client, :logger

      def parse(request, response)
         if response.success?
           logger.log_successful_response(response)
           parse_success(response)
         else
           logger.log_error_response(request, response)
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
        raise ApiError.new(response)
      end
    end
  end
end