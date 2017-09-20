require 'faraday'
require_relative '../test_helper'
require_relative '../../lib/smartsheet/sheets'
require_relative '../../lib/smartsheet/api/net_client'

describe Smartsheet::Sheets do
  before do
    @mock_client = mock()
    @mock_client.stubs(:token).returns('0123456789')
    @sheets = Smartsheet::Sheets.new(@mock_client)
  end
  it 'stubbing works' do
    expected_endpoint_spec = Smartsheet::API::EndpointSpec.new :get, ['sheets']
    @mock_client
        .expects(:make_request)
        .with() {|endpoint_spec, request_spec| (endpoint_spec.method.must_equal :get) && (endpoint_spec.url_segments.must_equal ['sheets']) }

    @sheets.list
  end
end
