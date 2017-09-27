require_relative '../../test_helper'
require 'smartsheet/api/net_client'
require 'smartsheet/api/response'
require 'faraday'
require 'ostruct'

describe Smartsheet::API::NetClient do
  include Smartsheet::Test

  TOKEN = '0123456789'.freeze

  before do
    @request = Faraday::Request.new
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])
    @request_spec = Smartsheet::API::RequestSpec.new

    @response = mock

    conn = mock
    conn.stubs(:get).yields(@request).returns @response
    conn.expects(:use).with(Smartsheet::API::Middleware::ErrorTranslator)
    conn.expects(:use).with(Smartsheet::API::Middleware::ResponseParser)
    faraday_adapter = Faraday.default_adapter
    Faraday.stubs(:default_adapter).returns(faraday_adapter)
    conn.expects(:adapter).with(faraday_adapter)

    Faraday.stubs(:new).yields(conn).returns(conn)
    @client = Smartsheet::API::NetClient.new(TOKEN)
    @stub_request_builder = mock
    @stub_request_builder.stubs(:apply)
  end

  def given_response(result)
    @response.stubs(:body).returns Smartsheet::API::Response.from_result(result)
  end

  def given_successful_response
    given_response({})
  end

  def given_failed_response
    given_response OpenStruct.new(errorCode: 1001)
  end

  def given_retryable_response
    given_response OpenStruct.new(errorCode: 4002)
  end

  it 'sets token' do
    given_successful_response
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |token, _endpoint_spec, _request_spec, _req|
      token.must_equal TOKEN
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets endpoint spec' do
    given_successful_response
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, endpoint_spec, _request_spec, _req|
      endpoint_spec.must_equal @endpoint_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request spec' do
    given_successful_response
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, _endpoint_spec, request_spec, _req|
      request_spec.must_equal @request_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request' do
    given_successful_response
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, _endpoint_spec, _request_spec, req|
      req.must_equal @request
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end
end
