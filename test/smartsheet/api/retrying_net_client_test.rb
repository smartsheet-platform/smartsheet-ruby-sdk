require_relative '../../test_helper'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/retrying_net_client'
require 'timecop'

describe Smartsheet::API::RetryingNetClient do
  include Smartsheet::Test

  TOKEN = '0123456789'.freeze

  before do
    @response = mock
    @client = mock

    Timecop.freeze
  end

  after do
    Timecop.return
  end

  def given_response(retryable)
    @response.stubs(:'should_retry?').returns retryable
  end

  def given_retryable_response
    given_response true
  end

  def given_non_retryable_response
    given_response false
  end

  it 'does not retry when a non-retryable failure occurs' do
    given_non_retryable_response
    @client.expects(:make_request).returns @response
    Smartsheet::API::RetryingNetClient
      .new(@client)
      .make_request({}, {})
  end

  it 'retries when a retryable failure occurs' do
    given_retryable_response
    @client.expects(:make_request).at_least(2).returns @response

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    Smartsheet::API::RetryingNetClient
      .new(@client, retrier)
      .make_request({}, {})
  end
end
