module Smartsheet
  module API
    class FaradayResponse
      def self.from_response_env(faraday_env)
        if faraday_env[:body].kind_of?(Hash) && faraday_env[:body].key?(:errorCode)
          FaradayErrorResponse.new(faraday_env[:body], faraday_env)
        elsif faraday_env.success?
          FaradaySuccessResponse.new(faraday_env[:body], faraday_env)
        else
          raise HttpResponseError.new(
              status_code: faraday_env[:status],
              reason_phrase: faraday_env[:reason_phrase],
              headers: faraday_env[:response_headers]
          )
        end
      end

      attr_reader :status_code, :reason_phrase, :headers

      def initialize(faraday_env)
        @status_code = faraday_env[:status]
        @reason_phrase = faraday_env[:reason_phrase]
        @headers = faraday_env[:response_headers]
      end
    end

    class FaradayErrorResponse < FaradayResponse
      RETRYABLE_ERRORS = 4001..4004

      attr_reader :error_code, :message, :ref_id, :detail

      def initialize(result, faraday_env)
        super(faraday_env)
        @error_code = result[:errorCode]
        @message = result[:message]
        @ref_id = result[:refId]
        @detail = result[:detail]
      end

      def should_retry?
        RETRYABLE_ERRORS.include? error_code
      end

      def success?
        false
      end
    end

    class FaradaySuccessResponse < FaradayResponse
      attr_reader :result

      def initialize(result, faraday_env)
        super(faraday_env)
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
