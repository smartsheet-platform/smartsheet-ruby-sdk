require_relative '../../test_helper'
require 'smartsheet/api/faraday_net_client'
require 'smartsheet/api/response'
require 'faraday'
require 'ostruct'

describe Smartsheet::API::FaradayNetClient do
  before do
    @request = mock
    @request.stubs(:method).returns(:get)
    @request.stubs(:url).returns('url')
    @request.stubs(:headers).returns('headers')
    @request.stubs(:params).returns('params')
    @request.stubs(:body).returns('body')

    faraday_request = mock
    faraday_request.expects(:url).with('url')
    faraday_request.expects(:'headers=').with('headers')
    faraday_request.expects(:'params=').with('params')
    faraday_request.expects(:'body=').with('body')

    @response = mock
    @response.stubs(:body).returns Smartsheet::API::Response.from_result({})

    conn = mock
    conn.stubs(:get).yields(faraday_request).returns @response
    conn.expects(:use).with(Smartsheet::API::Middleware::ErrorTranslator)
    conn.expects(:use).with(Smartsheet::API::Middleware::ResponseParser)
    faraday_adapter = Faraday.default_adapter
    Faraday.stubs(:default_adapter).returns(faraday_adapter)
    conn.expects(:adapter).with(faraday_adapter)

    Faraday.stubs(:new).yields(conn).returns(conn)
    @client = Smartsheet::API::FaradayNetClient.new
  end

  it 'should make a call' do
    @client.make_request(@request)
  end
end
