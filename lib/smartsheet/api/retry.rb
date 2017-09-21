module Smartsheet
  module API
    class Retry
      DEFAULT_MAX_RETRY_TIME = 15

      DEFAULT_BACKOFF = Proc.new do |iteration|
        2 ** iteration + rand
      end

      def initialize(max_retry_time = DEFAULT_MAX_RETRY_TIME, backoff_method = DEFAULT_BACKOFF, &method_to_run)
        @max_retry_time = max_retry_time
        @backoff_method = backoff_method
        @method_to_run = method_to_run
      end

      def run(&check_success)
        end_time = Time.new.sec + @max_retry_time

        _run(check_success, end_time, 0)
      end

      private

      def _run(check_success, end_time, iteration)
        result = @method_to_run.call
        backoff = @backoff_method.call(iteration)

        return result if check_success.call(result) || Time.new.sec + backoff > end_time

        sleep backoff

        iteration += 1
        _run(check_success, end_time, iteration)
      end
    end
  end
end