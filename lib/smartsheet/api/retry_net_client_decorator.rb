module Smartsheet
  module API
    class RetryNetClientDecorator
      RETRY_CHECK = ->(response) { response.should_retry? }

      attr_reader :client, :retrier
      private :client, :retrier

      def initialize(client, retrier)
        @client = client
        @retrier = retrier
      end

      def make_request(request)
        retrier.run(RETRY_CHECK) do
          client.make_request(request)
        end
      end
    end
  end
end