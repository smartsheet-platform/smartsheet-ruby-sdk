require 'minitest/autorun'
require 'ostruct'
require_relative '../../../lib/smartsheet/api/headers'

describe Smartsheet::API::HeaderBuilder do
  before do
    @header_builder = Smartsheet::API::HeaderBuilder.new('0123456789')
  end

  it 'applies defaults' do
    headers = @header_builder
                  .for_endpoint()
                  .build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:Accept].must_equal 'application/json'
    headers[:Authorization].must_equal 'Bearer 0123456789'
    headers[:'User-Agent'].must_equal 'smartsheet-ruby-sdk'
  end

  it 'applies sending json' do
    @header_builder.sending_json
    headers = @header_builder.build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:'Content-Type'].must_equal 'application/json'
  end

  it 'applies overrides' do
    @header_builder.with_overrides({SomeOverride: 'someValue', Authorization: 'someAuth'})
    headers = @header_builder.build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:SomeOverride].must_equal 'someValue'
    headers[:Authorization].must_equal 'someAuth'
    headers[:Accept].must_equal 'application/json'
  end
end
