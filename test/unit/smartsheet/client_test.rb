require_relative '../../test_helper'
require_relative 'endpoints/endpoint_test_helper'

require 'smartsheet/client'


describe Smartsheet::Client do
  def given_request_client_expects_token
    Smartsheet::API::RequestClient
        .expects(:new)
        .with { |token, _client| token == TOKEN}
  end

  def given_request_client_expects_app_user_agent(expected_app_user_agent)
    Smartsheet::API::RequestClient
        .expects(:new)
        .with do |_token, _client, _base_url, app_user_agent:, assume_user:, logger:|
          app_user_agent == expected_app_user_agent
        end
  end

  it 'uses token from user' do
    given_request_client_expects_token

    Smartsheet::Client.new(token: TOKEN)
  end

  it 'uses token from env var when passed empty string' do
    given_request_client_expects_token

    ENV['SMARTSHEET_ACCESS_TOKEN'] = TOKEN
    Smartsheet::Client.new(token: '')
  end

  it 'inspect returns valid string' do
    Smartsheet::Client.new.inspect.must_be_kind_of String
  end

  it 'uses token from env var' do
    given_request_client_expects_token

    ENV['SMARTSHEET_ACCESS_TOKEN'] = TOKEN
    Smartsheet::Client.new
  end

  it 'uses user agent when provided' do
    user_agent = 'john-doe-app'

    given_request_client_expects_app_user_agent(user_agent)

    Smartsheet::Client.new(user_agent: user_agent)
  end

  describe 'default user agent' do
    MOCK_PROGRAM_NAME = 'program-name'
    ACTUAL_PROGRAM_NAME = $PROGRAM_NAME

    before do
      $PROGRAM_NAME = MOCK_PROGRAM_NAME
    end

    it 'uses program name as user agent when none provided' do
      given_request_client_expects_app_user_agent(MOCK_PROGRAM_NAME)
  
      Smartsheet::Client.new
    end

    after do
      $PROGRAM_NAME = ACTUAL_PROGRAM_NAME
    end
  end

  it 'initializes when all parameters are provided' do
      Smartsheet::Client.new(
          token: 'TOKEN',
          user_agent: 'john-doe-app',
          assume_user: 'john.doe@smartsheet.com',
          json_output: true,
          max_retry_time: 10,
          backoff_method: ->{},
          logger: Logger.new(STDOUT),
          log_full_body: true,
          base_url: 'smartsheet-dev-net'
      )
  end
end


class ClientTest < Minitest::Test
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
            args: {method: :post, url_path: 'some/url', file: {}, filename: 'file', file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :request_with_file_from_path,
            method: :post,
            url: ['some/url'],
            args: {method: :post, url_path: 'some/url', path: 'some/path'},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end