require_relative '../../test_helper'
require 'smartsheet/api/retry_logic'
require 'timecop'

describe Smartsheet::API::RetryLogic do
  before do
    Timecop.freeze
  end

  after do
    Timecop.return
  end

  it 'does not retry on success' do
    retry_logic = Smartsheet::API::RetryLogic.new do
      true
    end

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run do
      run_count += 1
    end

    run_count.must_equal 1
  end

  it 'result is returned on success' do
    retry_logic = Smartsheet::API::RetryLogic.new do
      true
    end

    stub_sleep(retry_logic)

    expected_result = {success: true}
    result = retry_logic.run do
      expected_result
    end

    result.must_equal expected_result
  end

  it 'does not exceed time limit' do
    retry_logic = Smartsheet::API::RetryLogic.new do
      false
    end

    stub_sleep(retry_logic)

    start_time = Time.now.to_i

    retry_logic.run do

    end

    Time.now.to_i.must_be :<=, start_time + 15
  end

  it 'retries the correct number of times' do
    srand 1234
    retry_logic = Smartsheet::API::RetryLogic.new do
      false
    end

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run do
      run_count += 1
    end

    run_count.must_equal 4
  end

  it 'uses user defined backoff' do
    srand 1234

    backoff_called = false
    backoff = Proc.new do |i|
      backoff_called = true
      1
    end

    retry_logic = Smartsheet::API::RetryLogic.new(backoff_method: backoff) do
      false
    end

    stub_sleep(retry_logic)

    run_count = 0
    retry_logic.run do
      run_count += 1
    end

    run_count.must_equal 15
    backoff_called.must_equal true
  end

  it 'does not exceed user defined time limit' do
    max_retry_time = 10
    retry_logic = Smartsheet::API::RetryLogic.new(max_retry_time: max_retry_time) do
      false
    end

    stub_sleep(retry_logic)

    start_time = Time.now.to_i

    retry_logic.run do

    end

    Time.now.to_i.must_be :<=, start_time + max_retry_time
  end

  it 'returns if successful after retry' do
    retry_logic = Smartsheet::API::RetryLogic.new do |attempt_count|
      # fails until second attempt
      attempt_count >= 2
    end

    stub_sleep(retry_logic)

    attempt_count = 0
    retry_logic.run do
      attempt_count += 1
      attempt_count
    end

    attempt_count.must_equal 2
  end

  def stub_sleep(obj)
    obj.stubs(:sleep).with do |time|
      Timecop.travel(Time.now + time)
    end
  end

end

