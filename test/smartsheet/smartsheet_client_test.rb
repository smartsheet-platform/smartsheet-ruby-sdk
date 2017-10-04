require_relative '../test_helper'
require_relative 'endpoints/endpoint_test_helper'

require 'smartsheet/smartsheet_client'


describe Smartsheet::SmartsheetClient do
  def given_request_client_expects_token
    Smartsheet::API::RequestClient
        .expects(:new)
        .with {|token, _client| token == TOKEN}
  end

  it 'uses token from user' do
    given_request_client_expects_token

    Smartsheet::SmartsheetClient.new(token: TOKEN)
  end

  it 'uses token from env var' do
    given_request_client_expects_token

    ENV['SMARTSHEET_ACCESS_TOKEN'] = TOKEN
    Smartsheet::SmartsheetClient.new
  end
end


class SmartsheetClientTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client
  end

  def self.endpoints
    [
        {
            symbol: :request,
            method: :post,
            url: ['some/url'],
            args: {method: :post, url_path: 'some/url'},
            has_params: true,
            headers: nil
        },
        {
            symbol: :request_with_file,
            method: :post,
            url: ['some/url'],
            args: {method: :post, url_path: 'some/url', file_options: {path: 'file'}},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end