require_relative '../../../../../test_helper'
require 'smartsheet/api/faraday_adapter/middleware/response_parser'
require 'mocha'

describe Smartsheet::API::Middleware::ResponseParser do
  def build_response_parser(env)
    pending_call = mock
    pending_call.stubs(:on_complete).yields(env).returns(env)
    app = mock
    app.stubs(:call).returns(pending_call)
    Smartsheet::API::Middleware::ResponseParser.new(app)
  end

  it 'parses and wraps successful JSON responses' do
    env = { response_headers: { 'content-type' => 'application/json' }, body: '{"key":"value"}' }
    response_parser = build_response_parser(env)
    response_parser.call(env)

    env[:body].success?.must_equal true
    env[:body].result[:key].must_equal 'value'
  end

  it 'wraps successful non-JSON responses' do
    env = { response_headers: {}, body: 'Result' }
    response_parser = build_response_parser(env)
    response_parser.call(env)

    env[:body].success?.must_equal true
    env[:body].result.must_equal 'Result'
  end

  it 'wraps failed responses' do
    body = '{"errorCode":1001,"message":"Failure","refId":"123abc"}'
    env = { response_headers: { 'content-type' => 'application/json' }, body: body }
    response_parser = build_response_parser(env)
    response_parser.call(env)

    env[:body].success?.must_equal false
    env[:body].error_code.must_equal 1001
  end
end