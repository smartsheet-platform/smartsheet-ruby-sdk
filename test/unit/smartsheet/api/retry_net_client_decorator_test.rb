require_relative '../../../test_helper'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/retry_net_client_decorator'
require 'timecop'

describe Smartsheet::API::RetryNetClientDecorator do
  include Smartsheet::Test

  REQUEST = Smartsheet::API::Request.new(
      'token',
      Smartsheet::API::EndpointSpec.new(:get, ['sheets']),
      Smartsheet::API::RequestSpec.new,
      @base_url
  )

  before do
    @response = mock
    @response.stubs(:'success?').returns false
    @response.stubs(:message).returns 'message'
    @response.stubs(:ref_id).returns 'RefID'
    @response.stubs(:status_code).returns 404
    @response.stubs(:reason_phrase).returns 'Not Found'
    @response.stubs(:headers).returns({})
    @client = mock

    @base_url = 'base'

    Timecop.freeze
  end

  after do
    Timecop.return
  end

  def given_response(retryable)
    @response.stubs(:'should_retry?').returns retryable
    @response.stubs(:error_code).returns(retryable ? 4001 : 3999)
  end

  def given_retryable_response
    given_response true
  end

  def given_non_retryable_response
    given_response false
  end

  def given_stubbed_inner_client
    @client.stubs(:make_request).with(REQUEST).returns @response
  end

  it 'does not retry when a non-retryable failure occurs' do
    given_non_retryable_response
    @client.expects(:make_request).with(REQUEST).returns @response

    Smartsheet::API::RetryNetClientDecorator
      .new(@client, Smartsheet::API::RetryLogic.new)
      .make_request(REQUEST)
  end

  it 'retries when a retryable failure occurs' do
    given_retryable_response
    @client.expects(:make_request).with(REQUEST).at_least(2).returns @response

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    Smartsheet::API::RetryNetClientDecorator
      .new(@client, retrier)
      .make_request(REQUEST)
  end

  it 'logs retry failure count after retrying more than once' do
    given_retryable_response
    given_stubbed_inner_client

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    logger = mock
    logger.expects(:log_retry_failure).with { |x| x >= 2 }
    logger.stubs(:log_retry_attempt)

    Smartsheet::API::RetryNetClientDecorator
        .new(@client, retrier, logger: logger)
        .make_request(REQUEST)
  end

  it 'logs retry attempts when a retryable failure occurs' do
    given_retryable_response
    given_stubbed_inner_client

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    logger = mock
    logger.stubs(:log_retry_failure)

    curr_attempt = 0
    logger.expects(:log_retry_attempt)
        .at_least_once
        .with do |log_request, log_response, attempt_num|
          curr_attempt = curr_attempt + 1
          log_request == REQUEST && log_response == @response && attempt_num == curr_attempt
        end

    Smartsheet::API::RetryNetClientDecorator
        .new(@client, retrier, logger: logger)
        .make_request(REQUEST)
  end

  it 'does not log retry attempts when a non-retryable failure occurs' do
    given_non_retryable_response
    given_stubbed_inner_client

    logger = mock
    logger.stubs(:log_retry_failure)
    logger.expects(:log_retry_attempt).never

    Smartsheet::API::RetryNetClientDecorator
        .new(@client, Smartsheet::API::RetryLogic.new)
        .make_request(REQUEST)
  end

  it 'logs retry failure count after retrying more than once' do
    given_retryable_response
    given_stubbed_inner_client

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    logger = mock
    logger.expects(:log_retry_failure).with { |x| x >= 2 }
    logger.stubs(:log_retry_attempt)

    Smartsheet::API::RetryNetClientDecorator
        .new(@client, retrier, logger: logger)
        .make_request(REQUEST)
  end

  it 'does not log retry failure count after retrying only once' do
    given_non_retryable_response
    given_stubbed_inner_client

    logger = mock
    logger.expects(:log_retry_failure).never
    logger.stubs(:log_retry_attempt)

    Smartsheet::API::RetryNetClientDecorator
        .new(@client, Smartsheet::API::RetryLogic.new, logger: logger)
        .make_request(REQUEST)
  end
end
