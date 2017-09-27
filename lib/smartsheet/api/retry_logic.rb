module Smartsheet
  module API
    class RetryLogic
      DEFAULT_MAX_RETRY_TIME = 15

      DEFAULT_BACKOFF_METHOD = proc { |iteration| 2**iteration + rand }

      def initialize(max_retry_time: DEFAULT_MAX_RETRY_TIME, backoff_method: DEFAULT_BACKOFF_METHOD)
        @max_retry_time = max_retry_time
        @backoff_method = backoff_method
      end

      def run(finish_pred, &method_to_run)
        end_time = Time.now.to_i + max_retry_time

        _run(method_to_run, finish_pred, end_time, 0)
      end

      private

      attr_reader :backoff_method, :max_retry_time

      def _run(method_to_run, finish_pred, end_time, iteration)
        result = method_to_run.call

        return result if finish_pred.call(result) || Time.now.to_i + backoff_method.call(iteration) >= end_time

        sleep backoff_method.call(iteration)

        iteration += 1
        _run(method_to_run, finish_pred, end_time, iteration)
      end
    end
  end
end
