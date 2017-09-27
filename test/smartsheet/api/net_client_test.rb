require_relative '../../test_helper'
require 'smartsheet/api/net_client'
require 'smartsheet/api/response'
require 'faraday'
require 'ostruct'

describe Smartsheet::API::NetClient do
  before do
    @request = Faraday::Request.new
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])
    @request_spec = Smartsheet::API::RequestSpec.new

    @response = mock
    @response.stubs(:body).returns Smartsheet::API::Response.from_result({})

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

  it 'sets token' do
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |token, _endpoint_spec, _request_spec, _req|
      token.must_equal TOKEN
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets endpoint spec' do
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, endpoint_spec, _request_spec, _req|
      endpoint_spec.must_equal @endpoint_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request spec' do
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, _endpoint_spec, request_spec, _req|
      request_spec.must_equal @request_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request' do
    Smartsheet::API::RequestBuilder
      .expects(:new)
      .returns(@stub_request_builder)
      .with do |_token, _endpoint_spec, _request_spec, req|
      req.must_equal @request
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end
end
