require_relative '../../test_helper'
require 'smartsheet/api/request_client'

describe Smartsheet::API::RequestClient do
  include Smartsheet::Test

  endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['x'])
  request_spec = Smartsheet::API::RequestSpec.new(body: 'body')
  expected_request = Smartsheet::API::Request.new(TOKEN, endpoint_spec, request_spec, nil)

  it 'delegates constructed requests to its client' do
    client = mock
    client
        .expects(:make_request)
        .with do |request|
          request.must_equal expected_request
    end

    Smartsheet::API::RequestClient.new(TOKEN, client, nil).make_request(endpoint_spec, request_spec)
  end

  it 'returns the result of the client being called' do
    return_value = 1

    client = mock
    client.stubs(:make_request).returns(return_value)

    Smartsheet::API::RequestClient
        .new(TOKEN, client, nil)
        .make_request(endpoint_spec, request_spec)
        .must_equal return_value
  end
end
