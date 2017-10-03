require_relative '../../../test_helper'
require 'smartsheet/api/faraday_adapter/faraday_net_client'
require 'smartsheet/api/faraday_adapter/faraday_response'
require 'faraday'
require 'ostruct'

describe Smartsheet::API::FaradayNetClient do
  def build_stub_request
    request = mock
    request.stubs(:method).returns(:get)
    request.stubs(:url).returns('url')
    request.stubs(:headers).returns('headers')
    request.stubs(:params).returns('params')
    request.stubs(:body).returns('body')
    request
  end

  def build_stub_response
    response = mock
    response.stubs(:body).returns Smartsheet::API::FaradayResponse.from_response_env({})
    response
  end

  def build_stub_faraday_request
    faraday_request = mock
    faraday_request.stubs(:url)
    faraday_request.stubs(:'headers=')
    faraday_request.stubs(:'params=')
    faraday_request.stubs(:'body=')
    faraday_request
  end

  def build_mock_faraday_request
    faraday_request = mock
    faraday_request.expects(:url).with('url')
    faraday_request.expects(:'headers=').with('headers')
    faraday_request.expects(:'params=').with('params')
    faraday_request.expects(:'body=').with('body')
    faraday_request
  end

  def with_stub_faraday_adapter
    faraday_adapter = Faraday.default_adapter
    Faraday.stubs(:default_adapter).returns(faraday_adapter)
    faraday_adapter
  end

  def with_stub_faraday_connection(faraday_request, response)
    conn = mock
    conn.stubs(:get).yields(faraday_request).returns response
    conn.stubs(:use)
    conn.stubs(:use)
    conn.stubs(:adapter)
    Faraday.stubs(:new).yields(conn).returns(conn)
  end

  def with_mock_faraday_connection(faraday_request, faraday_adapter, response)
    conn = mock
    conn.stubs(:get).yields(faraday_request).returns response
    conn.expects(:use).with(Smartsheet::API::Middleware::FaradayErrorTranslator)
    conn.expects(:use).with(Smartsheet::API::Middleware::ResponseParser)
    conn.expects(:adapter).with(faraday_adapter)
    Faraday.stubs(:new).yields(conn).returns(conn)
  end

  it 'should correctly build a Faraday request' do
    request = build_stub_request
    response = build_stub_response
    faraday_request = build_mock_faraday_request

    with_stub_faraday_adapter
    with_stub_faraday_connection(faraday_request, response)

    client = Smartsheet::API::FaradayNetClient.new
    client.make_request(request)
  end

  it 'should correctly configure expected middleware' do
    request = build_stub_request
    response = build_stub_response
    faraday_request = build_stub_faraday_request

    faraday_adapter = with_stub_faraday_adapter
    with_mock_faraday_connection(faraday_request, faraday_adapter, response)

    client = Smartsheet::API::FaradayNetClient.new
    client.make_request(request)
  end
end
