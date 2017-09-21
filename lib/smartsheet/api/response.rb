module Smartsheet
  module API
    class Response
      def self.from_result(result)
        result.respond_to?(:errorCode) ? ErrorResponse.new(result) : SuccessResponse.new(result)
      end
    end

    class ErrorResponse
      RETRYABLE_ERRORS = 4001..4004

      attr_reader :error_code, :message, :ref_id

      def initialize(result)
        @error_code = result.errorCode
        @message = result.message
        @ref_id = result.refId
      end

      def should_retry?
        RETRYABLE_ERRORS.include? error_code
      end

      def success?
        false
      end
    end

    class SuccessResponse
      attr_reader :result

      def initialize(result)
        @result = result
      end

      def should_retry?
        false
      end

      def success?
        true
      end
    end
  end
end
