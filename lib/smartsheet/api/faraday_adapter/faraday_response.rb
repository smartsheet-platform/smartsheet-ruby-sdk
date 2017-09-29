module Smartsheet
  module API
    class FaradayResponse
      def self.from_result(result)
        if result.respond_to?(:errorCode)
          FaradayErrorResponse.new(result)
        else
          FaradaySuccessResponse.new(result)
        end
      end
    end

    class FaradayErrorResponse
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

    class FaradaySuccessResponse
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
