require_relative '../../../test_helper'
require 'smartsheet/api/faraday_adapter/faraday_response'
require 'ostruct'

module Smartsheet
  module API
    describe FaradayResponse do
      it 'provides an error response when handed a result that looks like an error' do
        result = {}
        result['errorCode'] = 1000
        result['message'] = 'Error'
        result['refId'] = '123abc'

        response = FaradayResponse.from_result(result)
        response.must_be_kind_of FaradayErrorResponse
      end

      it 'provides a success response when handed a result that does not look like an error' do
        response = FaradayResponse.from_result('Result')
        response.must_be_kind_of FaradaySuccessResponse
      end
    end

    describe FaradayErrorResponse do
      RETRYABLE_ERROR_CODE = 4002
      NON_RETRYABLE_ERROR_CODE = 4000
      ERROR_MESSAGE = 'Error'.freeze
      REF_ID = '123abc'.freeze

      RETRYABLE_ERROR_RESULT = {}
      RETRYABLE_ERROR_RESULT['errorCode'] = RETRYABLE_ERROR_CODE
      RETRYABLE_ERROR_RESULT['message'] = ERROR_MESSAGE
      RETRYABLE_ERROR_RESULT['refId'] = REF_ID

      NON_RETRYABLE_ERROR_RESULT = {}
      NON_RETRYABLE_ERROR_RESULT['errorCode'] = NON_RETRYABLE_ERROR_CODE
      NON_RETRYABLE_ERROR_RESULT['message'] = ERROR_MESSAGE
      NON_RETRYABLE_ERROR_RESULT['refId'] = REF_ID

      it 'provides the result error code' do
        FaradayErrorResponse.new(RETRYABLE_ERROR_RESULT).error_code.must_equal RETRYABLE_ERROR_CODE
      end

      it 'provides the result message' do
        FaradayErrorResponse.new(RETRYABLE_ERROR_RESULT).message.must_equal ERROR_MESSAGE
      end

      it 'provides the result RefID' do
        FaradayErrorResponse.new(RETRYABLE_ERROR_RESULT).ref_id.must_equal REF_ID
      end

      it 'is not a success' do
        FaradayErrorResponse.new(RETRYABLE_ERROR_RESULT).success?.must_equal false
      end

      it 'should be retryable if the result\'s error code qualifies' do
        FaradayErrorResponse.new(RETRYABLE_ERROR_RESULT).should_retry?.must_equal true
      end

      it 'should not be retryable if the result\'s error code does not qualify' do
        FaradayErrorResponse.new(NON_RETRYABLE_ERROR_RESULT).should_retry?.must_equal false
      end
    end

    describe FaradaySuccessResponse do
      RESULT = 'Result'.freeze
      SUCCESS_RESPONSE = FaradaySuccessResponse.new(RESULT)

      it 'should provide the result' do
        SUCCESS_RESPONSE.result.must_equal RESULT
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