module Smartsheet
  module API
    class RetryingNetClient
      RETRY_CHECK = ->(response) { response.should_retry? }

      def initialize(client, retrier = nil)
        @client = client
        @retrier = retrier || RetryLogic.new
      end

      def make_request(endpoint_spec, request_spec)
        retrier.run(RETRY_CHECK) do
          client.make_request(endpoint_spec, request_spec)
        end
      end

      private

      attr_reader :client, :retrier
    end
  end
end