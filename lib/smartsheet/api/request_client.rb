require 'smartsheet/api/error'

module Smartsheet
  module API
    class RequestClient
      def initialize(token, client, assume_user: nil, logger: MuteRequestLogger.new)
        @token = token
        @client = client
        @assume_user = assume_user
        @logger = logger
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec, assume_user: assume_user)

        logger.log_request(request)
        client.make_request(request)
      end

      private

      attr_reader :token, :client, :assume_user, :logger
    end
  end
end