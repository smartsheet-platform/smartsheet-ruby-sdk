require 'smartsheet/api/request_logger'

module Smartsheet
  module API
    class RetryNetClientDecorator
      SHOULD_RETRY = ->(response) { response.should_retry? }

      attr_reader :client, :retrier, :logger
      private :client, :retrier, :logger

      def initialize(client, retrier, logger: MuteRequestLogger.new)
        @client = client
        @retrier = retrier
        @logger = logger
      end

      def make_request(request)
        total_attempts = 0

        retried_response = retrier.run(SHOULD_RETRY) do |iteration|
          response = client.make_request(request)

          total_attempts = iteration + 1
          logger.log_retry_attempt(request, response, total_attempts) if SHOULD_RETRY.call(response)
          response
        end

        unless retried_response.success? || total_attempts < 2
          logger.log_retry_failure(total_attempts)
        end

        retried_response
      end
    end
  end
end