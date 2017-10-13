require_relative '../../../test_helper'

require 'smartsheet/api/response_net_client_decorator'
require 'smartsheet/error'

describe Smartsheet::API::ResponseNetClientDecorator do
  before do
    @response = mock
    @client = mock
    @client.expects(:make_request).returns @response
  end

  def given_response(success)
    @response.stubs(:'success?').returns success
  end

  def given_success_response
    given_response true
  end

  def given_camelcase_result
    given_success_response
    @response.stubs(:result).returns({camelCase: '123'})
  end

  def given_snakecase_result
    given_success_response
    @response.stubs(:result).returns({snake_case: '123'})
  end

  def given_non_json_result
    given_success_response
    @response.stubs(:result).returns('result')
  end

  def given_http_error_response(status_code: 123, reason_phrase: 'because', headers: {h: 1})
    @error = Smartsheet::HttpResponseError.new(status_code: status_code, reason_phrase: reason_phrase, headers: headers)

    @client.unstub(:make_request)
    @client.stubs(:make_request).raises @error
  end

  def given_failure_response
    @response.stubs(:reason_phrase).returns('')
    @response.stubs(:status_code).returns(500)
    @response.stubs(:headers).returns({})

    given_response false
  end

  it 'raises an ApiError on api failure' do
    given_failure_response

    -> {
      Smartsheet::API::ResponseNetClientDecorator
        .new(@client)
        .make_request({})
    }.must_raise Smartsheet::ApiError
  end

  it 'raises a HttpResponseError on http failure' do
    given_http_error_response

    -> {
      Smartsheet::API::ResponseNetClientDecorator
          .new(@client)
          .make_request({})
    }.must_raise Smartsheet::HttpResponseError
  end

  it 'converts camel case to snake case' do
    given_camelcase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client)
                 .make_request({})

    result[:camel_case].must_equal '123'
  end

  it 'does not change snake case' do
    given_snakecase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client)
                 .make_request({})

    result[:snake_case].must_equal '123'
  end

  it 'does not modify non-JSON results' do
    given_non_json_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client)
                 .make_request({})

    result.must_equal 'result'
  end

  it 'returns JSON when requested' do
    given_camelcase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client, json_output: true)
                 .make_request({})

    result.must_equal '{"camelCase":"123"}'
  end

  it 'logs successful responses' do
    given_camelcase_result

    logger = mock
    logger.expects(:log_successful_response).with(@response)

    Smartsheet::API::ResponseNetClientDecorator
        .new(@client, logger: logger)
        .make_request({})
  end

  it 'logs api error responses' do
    given_failure_response

    request = {}
    logger = mock
    logger.expects(:log_api_error_response).with(request, @response)

    proc do
      Smartsheet::API::ResponseNetClientDecorator
          .new(@client, logger: logger)
          .make_request(request)
    end.must_raise Smartsheet::ApiError
  end

  it 'logs http error responses' do
    given_http_error_response

    request = {}
    logger = mock
    logger.expects(:log_http_error_response).with(request, @error)

    proc do
      Smartsheet::API::ResponseNetClientDecorator
          .new(@client, logger: logger)
          .make_request(request)
    end.must_raise Smartsheet::HttpResponseError
  end
end
