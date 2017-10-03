module Smartsheet
  module API
    class FaradayResponse
      def self.from_result(faraday_response)
        if faraday_response[:body].respond_to?(:errorCode)
          FaradayErrorResponse.new(faraday_response[:body], faraday_response)
        else
          FaradaySuccessResponse.new(faraday_response[:body], faraday_response)
        end
      end
    end

    class FaradayErrorResponse
      RETRYABLE_ERRORS = 4001..4004

      attr_reader :error_code, :message, :ref_id, :status_code, :reason_phrase, :headers

      def initialize(result, faraday_response)
        @error_code = result.errorCode
        @message = result.message
        @ref_id = result.refId
        @status_code = faraday_response[:status]
        @reason_phrase = faraday_response[:reason_phrase]
        @headers = faraday_response[:response_headers]
      end

      def should_retry?
        RETRYABLE_ERRORS.include? error_code
      end

      def success?
        false
      end
    end

    class FaradaySuccessResponse
      attr_reader :result, :status_code, :reason_phrase, :headers

      def initialize(result, faraday_response)
        @result = result
        @status_code = faraday_response[:status]
        @reason_phrase = faraday_response[:reason_phrase]
        @headers = faraday_response[:response_headers]
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
