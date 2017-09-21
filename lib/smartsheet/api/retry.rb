module Smartsheet
  module API
    class Retry
      DEFAULT_MAX_RETRY_TIME = 15

      DEFAULT_BACKOFF_METHOD = Proc.new do |iteration|
        2 ** iteration + rand
      end

      def initialize(max_retry_time: DEFAULT_MAX_RETRY_TIME, backoff_method: DEFAULT_BACKOFF_METHOD, &check_success)
        @max_retry_time = max_retry_time
        @backoff_method = backoff_method
        @check_success = check_success
      end

      def run(&method_to_run)
        end_time = Time.now.to_i + @max_retry_time

        _run(method_to_run, end_time, 0)
      end

      private

      def _run(method_to_run, end_time, iteration)
        result = method_to_run.call

        return result if @check_success.call(result) || Time.now.to_i + @backoff_method.call(iteration) >= end_time

        sleep @backoff_method.call(iteration)

        iteration += 1
        _run(method_to_run, end_time, iteration)
      end
    end
  end
end