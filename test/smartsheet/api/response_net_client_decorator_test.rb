require_relative '../../test_helper'

require 'smartsheet/api/response_net_client_decorator'
require 'smartsheet/api/error'

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

  def given_failure_response
    @response.stubs(:message).returns('')
    given_response false
  end

  it 'raises an ApiError on failure' do
    given_failure_response

    -> {
      Smartsheet::API::ResponseNetClientDecorator
        .new(@client, false)
        .make_request({})
    }.must_raise Smartsheet::API::ApiError
  end

  it 'converts camel case to snake case' do
    given_camelcase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client, false)
                 .make_request({})

    result.camel_case.must_equal '123'
  end

  it 'does not change snake case' do
    given_snakecase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client, false)
                 .make_request({})

    result.snake_case.must_equal '123'
  end

  it 'does not modify non-JSON results' do
    given_non_json_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client, false)
                 .make_request({})

    result.must_equal 'result'
  end

  it 'returns JSON when requested' do
    given_camelcase_result

    result = Smartsheet::API::ResponseNetClientDecorator
                 .new(@client, true)
                 .make_request({})

    result.must_equal '{"camelCase":"123"}'
  end
end
