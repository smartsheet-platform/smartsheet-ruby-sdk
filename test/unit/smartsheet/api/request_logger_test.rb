require_relative '../../../test_helper'
require 'logger'

module Smartsheet
  module Test
    class MockLogger
      attr_reader :warn_msgs, :error_msgs, :info_msgs, :debug_msgs

      def initialize
        @warn_msgs = []
        @error_msgs = []
        @info_msgs = []
        @debug_msgs = []
      end

      def warn(message = nil)
        warn_msgs << (message.nil? ? yield : message)
      end

      def info(message = nil)
        info_msgs << (message.nil? ? yield : message)
      end

      def error(message = nil)
        error_msgs << (message.nil? ? yield : message)
      end

      def debug(message = nil)
        debug_msgs << (message.nil? ? yield : message)
      end

      def log(level, message = nil)
        message = message.nil? ? yield : message
        case level
        when Logger::WARN
          warn(message)
        when Logger::ERROR
          error(message)
        when Logger::INFO
          info(message)
        end
      end
    end
  end
end


describe Smartsheet::API::RequestLogger do
  before do
    @mock_logger = Smartsheet::Test::MockLogger.new
    @request_logger = Smartsheet::API::RequestLogger.new(@mock_logger, log_full_body: false)
  end

  def given_mock_request(body: {}, params: {}, headers: {})
    @mock_request = mock
    @mock_request.stubs(:method).returns(:get)
    @mock_request.stubs(:params).returns(params)
    @mock_request.stubs(:url).returns('some/url')
    @mock_request.stubs(:headers).returns(headers)
    @mock_request.stubs(:body).returns(body)
  end

  def init_mock_response(headers: {})
    response = mock
    response.stubs(:reason_phrase).returns('')
    response.stubs(:status_code).returns('')
    response.stubs(:headers).returns(headers)

    response
  end

  def given_mock_error_response(headers: {})
    @mock_response = init_mock_response(headers: headers)
    @mock_response.stubs(:error_code).returns('')
    @mock_response.stubs(:message).returns('')
    @mock_response.stubs(:ref_id).returns('')
  end

  def given_mock_success_response(result: {}, headers: {})
    @mock_response = init_mock_response(headers: headers)
    @mock_response.stubs(:result).returns(result)
  end

  def given_full_body_flag
    @request_logger = Smartsheet::API::RequestLogger.new(@mock_logger, log_full_body: true)
  end

  describe 'log_request' do
    TRUNCATION_LIMIT = 1024
    OVER_TRUNCATION_LIMIT = 1025

    it 'censors params' do
      given_mock_request(
          params: {code: 'censorme', client_id: 'censorme', hash: 'censorme', refresh_token: 'censorme'}
      )

      @request_logger.log_request(@mock_request)

      request_log =
          'Request: GET some/url?code=****orme&client_id=****orme&hash=****orme&refresh_token=****orme'
      @mock_logger.info_msgs.must_include request_log
    end

    it 'censors hash body' do
      given_mock_request(body: {access_token: 'censorme', refresh_token: 'metoo'})

      @request_logger.log_request(@mock_request)

      @mock_logger.debug_msgs.must_include 'Request Body: {:access_token=>"****orme", :refresh_token=>"*etoo"}'
    end

    it 'logs string body' do
      given_mock_request(body: 'string body')

      @request_logger.log_request(@mock_request)

      @mock_logger.debug_msgs.must_include 'Request Body: string body'
    end

    it 'logs binary body for other types' do
      given_mock_request(body: Object.new)

      @request_logger.log_request(@mock_request)

      @mock_logger.debug_msgs.must_include 'Request Body: <Binary body>'
    end

    it 'censors headers' do
      given_mock_request(headers: {authorization: 'censorme'})

      @request_logger.log_request(@mock_request)

      @mock_logger.debug_msgs.must_include 'Request Headers: {:authorization=>"****orme"}'
    end

    it 'censors capitalized headers' do
      given_mock_request(headers: {Authorization: 'censorme'})

      @request_logger.log_request(@mock_request)

      @mock_logger.debug_msgs.must_include 'Request Headers: {:Authorization=>"****orme"}'
    end

    it 'truncates long bodies when the `log full body` flag is false' do
      given_mock_request(body: 'x' * OVER_TRUNCATION_LIMIT)
      @request_logger.log_request(@mock_request)
      @mock_logger.debug_msgs.must_include "Request Body: #{'x' * TRUNCATION_LIMIT}..."
    end

    it 'does not truncate bodies under the truncation limit' do
      given_mock_request(body: 'x' * TRUNCATION_LIMIT)
      @request_logger.log_request(@mock_request)
      @mock_logger.debug_msgs.must_include "Request Body: #{'x' * TRUNCATION_LIMIT}"
    end

    it 'does not truncate bodies when the `log full body` flag is true' do
      given_full_body_flag
      given_mock_request(body: 'x' * OVER_TRUNCATION_LIMIT)
      @request_logger.log_request(@mock_request)
      @mock_logger.debug_msgs.must_include "Request Body: #{'x' * OVER_TRUNCATION_LIMIT}"
    end

    it 'truncates long bodies when generated from a hash' do
      given_mock_request(body: {x: 'y' * 1024})
      @request_logger.log_request(@mock_request)
      @mock_logger
          .debug_msgs
          .any? { |x| x.length == TRUNCATION_LIMIT + ('Request Body: ...'.length) }
          .must_equal true
    end
  end

  describe 'log_retry_attempt' do
    it 'censors params' do
      given_mock_request(
          params: {code: 'censorme', client_id: 'censorme', hash: 'censorme', refresh_token: 'censorme'}
      )
      given_mock_error_response

      @request_logger.log_retry_attempt(@mock_request, @mock_response, 1)

      request_log =
          'Request: GET some/url?code=****orme&client_id=****orme&hash=****orme&refresh_token=****orme'
      @mock_logger.warn_msgs.must_include request_log
    end

    it 'censors response headers' do
      given_mock_request
      given_mock_error_response(headers: {authorization: 'censorme'})

      @request_logger.log_retry_attempt(@mock_request, @mock_response, 1)

      @mock_logger.debug_msgs.must_include 'Response Headers: {:authorization=>"****orme"}'
    end
  end

  describe 'log_retry_failure' do
    it 'does not throw exception' do
      @request_logger.log_retry_failure(1)
    end
  end

  describe 'log_successful_response' do
    it 'censors hash body' do
      given_mock_success_response(result: {access_token: 'censorme', refresh_token: 'metoo'})

      @request_logger.log_successful_response(@mock_response)

      @mock_logger.debug_msgs.must_include 'Response Body: {:access_token=>"****orme", :refresh_token=>"*etoo"}'
    end

    it 'logs string body' do
      given_mock_success_response(result: 'string body')

      @request_logger.log_successful_response(@mock_response)

      @mock_logger.debug_msgs.must_include 'Response Body: string body'
    end

    it 'logs binary body for other types' do
      given_mock_success_response(result: Object.new)

      @request_logger.log_successful_response(@mock_response)

      @mock_logger.debug_msgs.must_include 'Response Body: <Binary body>'
    end

    it 'censors headers' do
      given_mock_success_response(headers: {authorization: 'censorme'})

      @request_logger.log_successful_response(@mock_response)

      @mock_logger.debug_msgs.must_include 'Response Headers: {:authorization=>"****orme"}'
    end
  end

  describe 'log_api_error_response' do
    it 'censors params' do
      given_mock_request(
          params: {code: 'censorme', client_id: 'censorme', hash: 'censorme', refresh_token: 'censorme'}
      )
      given_mock_error_response

      @request_logger.log_api_error_response(@mock_request, @mock_response)

      request_log =
          'Request: GET some/url?code=****orme&client_id=****orme&hash=****orme&refresh_token=****orme'
      @mock_logger.error_msgs.must_include request_log
    end

    it 'censors response headers' do
      given_mock_request
      given_mock_error_response(headers: {authorization: 'censorme'})

      @request_logger.log_api_error_response(@mock_request, @mock_response)

      @mock_logger.debug_msgs.must_include 'Response Headers: {:authorization=>"****orme"}'
    end
  end

  describe 'log_http_error_response' do
    it 'censors params' do
      given_mock_request(
          params: {code: 'censorme', client_id: 'censorme', hash: 'censorme', refresh_token: 'censorme'}
      )
      given_mock_error_response

      @request_logger.log_http_error_response(@mock_request, @mock_response)

      request_log =
          'Request: GET some/url?code=****orme&client_id=****orme&hash=****orme&refresh_token=****orme'
      @mock_logger.error_msgs.must_include request_log
    end

    it 'censors response headers' do
      given_mock_request
      given_mock_error_response(headers: {authorization: 'censorme'})

      @request_logger.log_http_error_response(@mock_request, @mock_response)

      @mock_logger.debug_msgs.must_include 'Response Headers: {:authorization=>"****orme"}'
    end
  end
end

describe Smartsheet::API::Censor do
  before do
    @censor = Smartsheet::API::Censor.new 'key1', 'key2', 'Key3'
  end

  it 'censors keys from blacklist' do
    censored_hash = @censor.censor_hash({'key1' => 'censorme', 'key2' => 'censorme'})

    censored_hash.must_equal({'key1' => '****orme', 'key2' => '****orme'})
  end

  it 'censors string and symbol keys' do
    censored_hash = @censor.censor_hash({:key1 => 'censorme', 'key2' => 'censorme'})

    censored_hash.must_equal({:key1 => '****orme', 'key2' => '****orme'})
  end

  it 'doesnt censor all keys' do
    censored_hash = @censor.censor_hash({:uncensored_key => 'dontcensorme'})

    censored_hash.must_equal({:uncensored_key => 'dontcensorme'})
  end

  it 'only censors hash keys with case-sensitive match' do
    censored_hash = @censor.censor_hash(
        {
            'Key1' => 'dontcensorme',
            'key2' => 'censorme',
            'Key3' => 'censorme'
        }
    )

    censored_hash.must_equal({'Key1' => 'dontcensorme', 'key2' => '****orme', 'Key3' => '****orme'})
  end

  it 'censors hash keys with case-insensitive when specified' do
    censored_hash = @censor.censor_hash(
        {'Key1' => 'censorme', 'key2' => 'censorme', 'key3' => 'censorme'},
           case_insensitive: true)

    censored_hash.must_equal({'Key1' => '****orme', 'key2' => '****orme', 'key3' => '****orme'})
  end
end




