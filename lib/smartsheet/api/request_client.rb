require 'smartsheet/error'

module Smartsheet
  module API
    class RequestClient
      def initialize(token, client, base_url, assume_user: nil, logger: MuteRequestLogger.new)
        @token = token
        @client = client
        @assume_user = assume_user
        @logger = logger
        @base_url = base_url
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec, base_url, assume_user: assume_user)

        logger.log_request(request)
        client.make_request(request)
      end

      private

      attr_reader :token, :client, :assume_user, :logger, :base_url
    end
  end
end