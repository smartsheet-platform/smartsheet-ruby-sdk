require_relative '../../test_helper'
require 'smartsheet/api/faraday_net_client'
require 'smartsheet/api/response'
require 'faraday'
require 'ostruct'

describe Smartsheet::API::FaradayNetClient do
  before do
    @faraday_request = mock
    @faraday_request.expects(:url).with('url')
    @faraday_request.expects(:'headers=').with('headers')
    @faraday_request.expects(:'params=').with('params')
    @faraday_request.expects(:'body=').with('body')

    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])
    @request_spec = Smartsheet::API::RequestSpec.new

    @response = mock
    @response.stubs(:body).returns Smartsheet::API::Response.from_result({})

    conn = mock
    conn.stubs(:get).yields(@faraday_request).returns @response
    conn.expects(:use).with(Smartsheet::API::Middleware::ErrorTranslator)
    conn.expects(:use).with(Smartsheet::API::Middleware::ResponseParser)
    faraday_adapter = Faraday.default_adapter
    Faraday.stubs(:default_adapter).returns(faraday_adapter)
    conn.expects(:adapter).with(faraday_adapter)

    Faraday.stubs(:new).yields(conn).returns(conn)
    @client = Smartsheet::API::FaradayNetClient.new(TOKEN)

    @stub_request = mock
    @stub_request.stubs(:url).returns('url')
    @stub_request.stubs(:headers).returns('headers')
    @stub_request.stubs(:params).returns('params')
    @stub_request.stubs(:body).returns('body')
  end

  it 'sets token' do
    Smartsheet::API::Request
      .expects(:new)
      .returns(@stub_request)
      .with do |token, _endpoint_spec, _request_spec|
      token.must_equal TOKEN
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets endpoint spec' do
    Smartsheet::API::Request
      .expects(:new)
      .returns(@stub_request)
      .with do |_token, endpoint_spec, _request_spec|
      endpoint_spec.must_equal @endpoint_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request spec' do
    Smartsheet::API::Request
      .expects(:new)
      .returns(@stub_request)
      .with do |_token, _endpoint_spec, request_spec|
      request_spec.must_equal @request_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end
end
