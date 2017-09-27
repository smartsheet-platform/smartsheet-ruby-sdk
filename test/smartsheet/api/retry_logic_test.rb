require_relative '../../test_helper'
require 'smartsheet/api/retry_logic'
require 'timecop'

describe Smartsheet::API::RetryLogic do
  include Smartsheet::Test

  ALWAYS_RETRY = proc { true }
  NEVER_RETRY = proc { false }

  before do
    Timecop.freeze
  end

  after do
    Timecop.return
  end

  it 'does not retry on success' do
    retry_logic = Smartsheet::API::RetryLogic.new

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run(NEVER_RETRY) do
      run_count += 1
    end

    run_count.must_equal 1
  end

  it 'result is returned on success' do
    retry_logic = Smartsheet::API::RetryLogic.new

    stub_sleep(retry_logic)

    expected_result = { success: true }
    result = retry_logic.run(NEVER_RETRY) do
      expected_result
    end

    result.must_equal expected_result
  end

  it 'does not exceed time limit' do
    retry_logic = Smartsheet::API::RetryLogic.new

    stub_sleep(retry_logic)

    start_time = Time.now.to_i

    retry_logic.run(ALWAYS_RETRY) do
    end

    Time.now.to_i.must_be :<=, start_time + 15
  end

  it 'retries the correct number of times' do
    srand 1234
    retry_logic = Smartsheet::API::RetryLogic.new

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run(ALWAYS_RETRY) do
      run_count += 1
    end

    run_count.must_equal 4
  end

  it 'uses user defined backoff' do
    backoff_called = false
    backoff = proc do
      backoff_called = true
      1
    end

    retry_logic = Smartsheet::API::RetryLogic.new(backoff_method: backoff)

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run(ALWAYS_RETRY) do
      run_count += 1
    end

    run_count.must_equal 15
    backoff_called.must_equal true
  end

  it 'does not exceed user defined time limit' do
    max_retry_time = 10
    retry_logic = Smartsheet::API::RetryLogic.new(max_retry_time: max_retry_time)

    stub_sleep(retry_logic)

    start_time = Time.now.to_i

    retry_logic.run(ALWAYS_RETRY) do
    end

    Time.now.to_i.must_be :<=, start_time + max_retry_time
  end

  it 'returns if successful after retry' do
    retry_logic = Smartsheet::API::RetryLogic.new

    stub_sleep(retry_logic)

    attempt_count = 0
    retry_logic.run(proc { |attempt| attempt < 2 }) do
      attempt_count += 1
      attempt_count
    end

    attempt_count.must_equal 2
  end
end
