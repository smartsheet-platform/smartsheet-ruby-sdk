require_relative '../../test_helper'
require 'smartsheet/api/response'
require 'ostruct'

module Smartsheet
  module API
    describe Response do
      it 'provides an error response when handed a result that looks like an error' do
        result = OpenStruct.new(errorCode: 1000, message: 'Error', refId: '123abc')
        response = Response.from_result(result)
        response.must_be_kind_of ErrorResponse
      end

      it 'provides a success response when handed a result that does not look like an error' do
        response = Response.from_result('Result')
        response.must_be_kind_of SuccessResponse
      end
    end

    describe ErrorResponse do
      RETRYABLE_ERROR_CODE = 4002
      NON_RETRYABLE_ERROR_CODE = 4000
      ERROR_MESSAGE = 'Error'.freeze
      REF_ID = '123abc'.freeze
      RETRYABLE_ERROR_RESULT = OpenStruct.new(
        errorCode: RETRYABLE_ERROR_CODE,
        message: ERROR_MESSAGE,
        refId: REF_ID
      )
      NON_RETRYABLE_ERROR_RESULT = OpenStruct.new(
        errorCode: NON_RETRYABLE_ERROR_CODE,
        message: ERROR_MESSAGE,
        refId: REF_ID
      )

      it 'provides the result error code' do
        ErrorResponse.new(RETRYABLE_ERROR_RESULT).error_code.must_equal RETRYABLE_ERROR_CODE
      end

      it 'provides the result message' do
        ErrorResponse.new(RETRYABLE_ERROR_RESULT).message.must_equal ERROR_MESSAGE
      end

      it 'provides the result RefID' do
        ErrorResponse.new(RETRYABLE_ERROR_RESULT).ref_id.must_equal REF_ID
      end

      it 'is not a success' do
        ErrorResponse.new(RETRYABLE_ERROR_RESULT).success?.must_equal false
      end

      it 'should be retryable if the result\'s error code qualifies' do
        ErrorResponse.new(RETRYABLE_ERROR_RESULT).should_retry?.must_equal true
      end

      it 'should not be retryable if the result\'s error code does not qualify' do
        ErrorResponse.new(NON_RETRYABLE_ERROR_RESULT).should_retry?.must_equal false
      end
    end

    describe SuccessResponse do
      RESULT = 'Result'.freeze
      SUCCESS_RESPONSE = SuccessResponse.new(RESULT)

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