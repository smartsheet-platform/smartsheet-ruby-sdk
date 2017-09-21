require_relative '../../test_helper'
require 'smartsheet/api/headers'
require 'faraday'

describe Smartsheet::API::NetClient do
  TOKEN = '0123456789'

  before do
    @request = OpenStruct.new
    @request.stubs(:url)
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])

    @some_url = 'some/url'
    @some_header = {h: ''}
    @some_body = {b: ''}
    @some_params = {p: ''}

    mock_url_builder = mock
    mock_url_builder.stubs(:build).returns(@some_url)
    Smartsheet::API::UrlBuilder.stubs(:new).returns(mock_url_builder)
    mock_header_builder = mock
    mock_header_builder.stubs(:build).returns(@some_header)
    Smartsheet::API::HeaderBuilder.stubs(:new).returns(mock_header_builder)
  end

  it 'sets url' do
    request_spec = Smartsheet::API::RequestSpec.new

    @request.expects(:url).with(@some_url)
    Smartsheet::API::RequestBuilder
        .new(TOKEN, @endpoint_spec, request_spec, @request)
        .apply
  end

  it 'sets header' do
    request_spec = Smartsheet::API::RequestSpec.new
    Smartsheet::API::RequestBuilder
        .new(TOKEN, @endpoint_spec, request_spec, @request)
        .apply

    @request.headers.must_equal @some_header
  end

  it 'sets params' do
    request_spec = Smartsheet::API::RequestSpec.new(params: @some_params)
    Smartsheet::API::RequestBuilder
        .new(TOKEN, @endpoint_spec, request_spec, @request)
        .apply

    @request.params.must_equal @some_params
  end

  it 'sets body' do
    request_spec = Smartsheet::API::RequestSpec.new(body: @some_body)
    Smartsheet::API::RequestBuilder
        .new(TOKEN, @endpoint_spec, request_spec, @request)
        .apply

    @request.body.must_equal @some_body
  end
end
