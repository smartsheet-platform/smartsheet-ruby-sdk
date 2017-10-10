require_relative '../../test_helper'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/retry_net_client_decorator'
require 'timecop'

describe Smartsheet::API::RetryNetClientDecorator do
  include Smartsheet::Test

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

  it 'does not retry when a non-retryable failure occurs' do
    given_non_retryable_response
    @client.expects(:make_request).returns @response

    Smartsheet::API::RetryNetClientDecorator
      .new(@client, Smartsheet::API::RetryLogic.new)
      .make_request(
        Smartsheet::API::Request.new(
          'token',
          Smartsheet::API::EndpointSpec.new(:get, ['sheets']),
          Smartsheet::API::RequestSpec.new,
          @base_url
        )
      )
  end

  it 'retries when a retryable failure occurs' do
    given_retryable_response
    @client.expects(:make_request).at_least(2).returns @response

    retrier = Smartsheet::API::RetryLogic.new
    stub_sleep(retrier)

    Smartsheet::API::RetryNetClientDecorator
      .new(@client, retrier)
      .make_request(
        Smartsheet::API::Request.new(
          'token',
          Smartsheet::API::EndpointSpec.new(:get, ['sheets']),
          Smartsheet::API::RequestSpec.new,
          @base_url
        )
      )
  end
end
