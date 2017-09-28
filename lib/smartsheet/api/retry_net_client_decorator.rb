module Smartsheet
  module API
    class RetryNetClientDecorator
      RETRY_CHECK = ->(response) { response.should_retry? }

      def initialize(client, retrier)
        @client = client
        @retrier = retrier
      end

      def make_request(request)
        retrier.run(RETRY_CHECK) do
          client.make_request(request)
        end
      end

      private

      attr_reader :client, :retrier
    end
  end
end