require_relative '../../test_helper'
require 'smartsheet/api/net_client'
require 'faraday'

describe Smartsheet::API::NetClient do
  TOKEN = '0123456789'

  before do
    @request = Faraday::Request.new
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])
    @request_spec = Smartsheet::API::RequestSpec.new

    Faraday.stubs(:get).yields @request
    @client = Smartsheet::API::NetClient.new(TOKEN)
    @stub_request_builder = mock
    @stub_request_builder.stubs(:apply)
  end

  it 'sets token' do
    Smartsheet::API::RequestBuilder
        .expects(:new)
        .returns(@stub_request_builder)
        .with do |token, endpoint_spec, request_spec, req|
      token.must_equal TOKEN
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets endpoint spec' do
    Smartsheet::API::RequestBuilder
        .expects(:new)
        .returns(@stub_request_builder)
        .with do |token, endpoint_spec, request_spec, req|
      endpoint_spec.must_equal @endpoint_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request spec' do
    Smartsheet::API::RequestBuilder
        .expects(:new)
        .returns(@stub_request_builder)
        .with do |token, endpoint_spec, request_spec, req|
      request_spec.must_equal @request_spec
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end

  it 'sets request' do
    Smartsheet::API::RequestBuilder
        .expects(:new)
        .returns(@stub_request_builder)
        .with do |token, endpoint_spec, request_spec, req|
      req.must_equal @request
    end

    @client.make_request(@endpoint_spec, @request_spec)
  end
end
