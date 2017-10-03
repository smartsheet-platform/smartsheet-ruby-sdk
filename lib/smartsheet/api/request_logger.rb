require 'logger'

module Smartsheet
  module API
    class Censor
      EXPOSED_CHARS = 4

      def initialize(*blacklist)
        @blacklist = Set.new(blacklist)
      end

      def censor_hash(h)
        h.collect do |(k, v)|
          new_v = blacklist.include?(k) ? censor(v) : v
          [k, new_v]
        end.to_h
      end

      def censor(str)
        total_length = str.length
        censored_length = [total_length - EXPOSED_CHARS, 0].max
        ('*' * censored_length) + str[censored_length...total_length]
      end

      private

      attr_reader :blacklist
    end

    class RequestLogger
      QUERY_PARAM_CENSOR = Censor.new 'code', 'client_id', 'hash', 'refresh_token'
      HEADER_CENSOR = Censor.new 'authorization'
      PAYLOAD_CENSOR = Censor.new 'access_token', 'refresh_token'

      def initialize(logger)
        @logger = logger
      end

      def log_request(request)
        log_request_basics(Logger::INFO, request)
        log_headers(request)
        log_request_payload(request)
      end

      def log_retry_attempt(request, response, attempt_num)
        logger.warn { "Request attempt #{attempt_num} failed" }
        log_request_basics(Logger::WARN, request)
        log_api_error(Logger::WARN, response)
      end

      def log_retry_failure(num_tries)
        try_word = num_tries == 1 ? 'try' : 'tries'
        logger.error { "Request failed after #{num_tries} #{try_word}" }
      end

      def log_successful_response(response)
        log_status(Logger::INFO, response)
        log_headers(response)
        log_response_payload(response)
      end

      def log_error_response(request, error)
        log_request_basics(Logger::ERROR, request)
        log_api_error(Logger::ERROR, error)
      end

      private

      attr_reader :logger

      def log_request_basics(level, request)
        logger.log(level) { "Request: #{request.method} #{build_logging_url(request)}" }
      end

      def build_logging_url(request)
        query_params = QUERY_PARAM_CENSOR.censor_hash(request.params)
        query_param_str =
          if query_params.empty?
            ''
          else
            '?' + query_params.collect { |(k, v)| "#{k}=#{v}" }.join(',') # TODO: URI Encoding
          end
        request.url + query_param_str
      end

      def log_api_error(level, response)
        log_status(level, response)
        logger.log(level) do
          "#{response.error_code}: #{response.message} - Ref ID: #{response.ref_id}"
        end
        log_headers(response)
      end

      def log_status(level, response)
        logger.log(level) { "Response: #{response.status_code} #{response.reason_phrase}" }
      end

      def log_headers(req_or_resp)
        logger.debug { "Headers: #{req_or_resp.headers}" }
      end

      def log_request_payload(request)
        body = request.body
        return unless body

        if body.is_a?(String) || body.is_a?(Hash)
          logger.debug { "Body: #{body}" }
        else
          logger.debug 'Body: <Binary body>'
        end
      end

      def log_response_payload(response)
        body = response.result
        return unless body

        if body.is_a?(String) || body.is_a?(Hash) || body.is_a?(OpenStruct)
          logger.debug { "Body: #{body}" }
        else
          logger.debug 'Body: <Binary body>'
        end
      end
    end

    class MuteRequestLogger
      def log_request(request)
      end

      def log_retry_attempt(request, response, attempt_num)
      end

      def log_retry_failure(num_retries)
      end

      def log_successful_response(response)
      end

      def log_error_response(request, error)
      end
    end
  end
end