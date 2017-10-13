require_relative '../../../../test_helper'
require 'smartsheet/api/faraday_adapter/faraday_response'
require 'ostruct'

module Smartsheet
  module API
    describe FaradayResponse do
      it 'provides an error response when handed a result that looks like an error' do
        result_body = {
            :errorCode => 1000,
            :message => 'Error',
            :refId => '123abc'
        }
        result = { body: result_body, status: 404, reason_phrase: 'Not Found', headers: {} }
        response = FaradayResponse.from_response_env(result)

        response.must_be_kind_of FaradayErrorResponse
      end

      it 'provides a success response when handed a result that does not look like an error' do
        result = { body: 'Result', status: 200, reason_phrase: 'OK', headers: {} }
        response = FaradayResponse.from_response_env(result)
        response.must_be_kind_of FaradaySuccessResponse
      end
    end

    describe FaradayErrorResponse do
      RETRYABLE_ERROR_CODE = 4002
      NON_RETRYABLE_ERROR_CODE = 4000
      ERROR_MESSAGE = 'Error'.freeze
      REF_ID = '123abc'.freeze
      DETAIL = [{a: 123}, {b: 234}].freeze

      STATUS = 404
      REASON_PHRASE = 'Not Found'.freeze
      RESPONSE_HEADERS = {
          'date' => 'Tue, 03 Oct 2017 15:46:24 GMT',
          'content-type' => 'application/json;charset=UTF-8',
          'content-length' => '1621',
          'connection' => 'close'
      }.freeze
      RETRYABLE_ERROR_RESULT = {
        :errorCode => RETRYABLE_ERROR_CODE,
        :message => ERROR_MESSAGE,
        :refId => REF_ID,
        :detail => DETAIL
      }
      NON_RETRYABLE_ERROR_RESULT = {
        :errorCode => NON_RETRYABLE_ERROR_CODE,
        :message => ERROR_MESSAGE,
        :refId => REF_ID,
        :detail => DETAIL
      }
      FARADAY_RESPONSE = {
          status: STATUS,
          reason_phrase: REASON_PHRASE,
          response_headers: RESPONSE_HEADERS
      }.freeze

      it 'provides the result error code' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .error_code.must_equal RETRYABLE_ERROR_CODE
      end

      it 'provides the result message' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .message.must_equal ERROR_MESSAGE
      end

      it 'provides the result RefID' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .ref_id.must_equal REF_ID
      end

      it 'provides the result detail' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .detail.must_equal DETAIL
      end

      it 'provides the response status' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .status_code.must_equal STATUS
      end

      it 'provides the response reason phrase' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .reason_phrase.must_equal REASON_PHRASE
      end

      it 'provides the response headers' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .headers.must_equal RESPONSE_HEADERS
      end

      it 'is not a success' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .success?.must_equal false
      end

      it 'should be retryable if the result\'s error code qualifies' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .should_retry?.must_equal true
      end

      it 'should not be retryable if the result\'s error code does not qualify' do
        FaradayErrorResponse
            .new(NON_RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .should_retry?.must_equal false
      end
    end

    describe FaradaySuccessResponse do
      STATUS = 404
      REASON_PHRASE = 'Not Found'.freeze
      RESPONSE_HEADERS = {
          'date' => 'Tue, 03 Oct 2017 15:46:24 GMT',
          'content-type' => 'application/json;charset=UTF-8',
          'content-length' => '1621',
          'connection' => 'close'
      }.freeze
      FARADAY_RESPONSE = {
          status: STATUS,
          reason_phrase: REASON_PHRASE,
          response_headers: RESPONSE_HEADERS
      }.freeze
      RESULT = 'Result'.freeze
      SUCCESS_RESPONSE = FaradaySuccessResponse.new(RESULT, FARADAY_RESPONSE)

      it 'should provide the result' do
        SUCCESS_RESPONSE.result.must_equal RESULT
      end

      it 'provides the response status' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .status_code.must_equal STATUS
      end

      it 'provides the response reason phrase' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .reason_phrase.must_equal REASON_PHRASE
      end

      it 'provides the response headers' do
        FaradayErrorResponse
            .new(RETRYABLE_ERROR_RESULT, FARADAY_RESPONSE)
            .headers.must_equal RESPONSE_HEADERS
      end

      it 'should not be retryable' do
        SUCCESS_RESPONSE.should_retry?.must_equal false
      end

      it 'should be a success' do
        SUCCESS_RESPONSE.success?.must_equal true
      end
    end
  end
end