require 'logger'

module Smartsheet
  module API
    class Censor
      EXPOSED_CHARS = 4
      KEY_TO_STRING = ->(k){ k.to_s }
      KEY_TO_DOWNCASE_STRING = ->(k){ k.to_s.downcase }

      def initialize(*blacklist)
        @blacklist = Set.new(blacklist)
      end

      def censor_hash(h, case_insensitive: false)
        if case_insensitive
          _censor_hash(h, KEY_TO_DOWNCASE_STRING, downcased_blacklist)
        else
          _censor_hash(h, KEY_TO_STRING, blacklist)
        end

        key_transform =
            case_insensitive ?
                KEY_TO_DOWNCASE_STRING :
                KEY_TO_STRING

        cased_blacklist =
            case_insensitive ?
                blacklist.collect { |x| x.downcase } :
                blacklist

        _censor_hash(h, key_transform, cased_blacklist)
      end

      def censor(str)
        total_length = str.length
        censored_length = [total_length - EXPOSED_CHARS, 0].max
        ('*' * censored_length) + str[censored_length...total_length]
      end

      private

      def _censor_hash(h, key_transform, cased_blacklist)
        h.collect do |(k, v)|
          new_v =
              cased_blacklist.include?(key_transform.call(k)) ?
                  censor(v) :
                  v

          [k, new_v]
        end.to_h
      end

      def downcased_blacklist
        blacklist.collect { |x| x.downcase }
      end

      attr_reader :blacklist
    end

    class RequestLogger
      QUERY_PARAM_CENSOR = Censor.new 'code', 'client_id', 'hash', 'refresh_token'
      HEADER_CENSOR = Censor.new 'authorization'
      PAYLOAD_CENSOR = Censor.new 'access_token', 'refresh_token'

      TRUNCATED_BODY_LENGTH = 1024

      def initialize(logger, log_full_body:)
        @logger = logger
        @log_full_body = log_full_body
      end

      def log_request(request)
        log_request_basics(Logger::INFO, request)
        log_headers('Request', request)
        log_body('Request', request.body)
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
        log_headers('Response', response)
        log_body('Response', response.result)
      end

      def log_error_response(request, error)
        log_request_basics(Logger::ERROR, request)
        log_api_error(Logger::ERROR, error)
      end

      private

      attr_reader :logger, :log_full_body

      def log_request_basics(level, request)
        logger.log(level) { "Request: #{request.method.upcase} #{build_logging_url(request)}" }
      end

      def build_logging_url(request)
        query_params = QUERY_PARAM_CENSOR.censor_hash(request.params)
        query_param_str =
          if query_params.empty?
            ''
          else
            '?' + query_params.collect { |(k, v)| "#{k}=#{v}" }.join('&') # TODO: URI Encoding
          end
        request.url + query_param_str
      end

      def log_api_error(level, response)
        log_status(level, response)
        logger.log(level) do
          "#{response.error_code}: #{response.message} - Ref ID: #{response.ref_id}"
        end
        log_headers('Response', response)
      end

      def log_status(level, response)
        logger.log(level) { "Response: #{response.status_code} #{response.reason_phrase}" }
      end

      def log_headers(context, req_or_resp)
        censored_hash = HEADER_CENSOR.censor_hash(req_or_resp.headers, case_insensitive: true)
        logger.debug { "#{context} Headers: #{censored_hash}" }
      end

      def log_body(context, body)
        return unless body

        body_str =
            if body.is_a? String
              body
            elsif body.is_a? Hash
              PAYLOAD_CENSOR.censor_hash(body).to_s
            else
              '<Binary body>'
            end

        body_str = truncate_body(body_str) unless log_full_body

        logger.debug "#{context} Body: #{body_str}"
      end

      def truncate_body(body_str)
        if body_str.length > TRUNCATED_BODY_LENGTH
          body_str[0...TRUNCATED_BODY_LENGTH] + '...'
        else
          body_str
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