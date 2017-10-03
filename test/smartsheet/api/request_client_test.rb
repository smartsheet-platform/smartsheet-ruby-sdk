require_relative '../../test_helper'
require 'smartsheet/api/request_client'
require 'smartsheet/api/error'

describe Smartsheet::API::RequestClient do
  include Smartsheet::Test

  endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['x'])
  request_spec = Smartsheet::API::RequestSpec.new(body: 'body')
  expected_request = Smartsheet::API::Request.new(TOKEN, endpoint_spec, request_spec)

  it 'delegates constructed requests to its client' do
    return_value = mock
    return_value.stubs(:'success?').returns(true)
    return_value.stubs(:result).returns(1)

    client = mock
    client
        .expects(:make_request)
        .with do |request|
          request.must_equal expected_request
        end
        .returns(return_value)

    Smartsheet::API::RequestClient.new(TOKEN, client).make_request(endpoint_spec, request_spec)
  end

  it 'returns the result of the client being called' do
    expected_value = 1

    return_value = expected_value

    client = mock
    client.stubs(:make_request).returns(return_value)

    Smartsheet::API::RequestClient
        .new(TOKEN, client)
        .make_request(endpoint_spec, request_spec)
        .must_equal expected_value
  end
end
