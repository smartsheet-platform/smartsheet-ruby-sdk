require 'minitest/autorun'
require 'ostruct'
require_relative '../../../lib/smartsheet/api/headers'

describe Smartsheet::API::Headers do
  describe Smartsheet::API::Headers::HeaderBuilder do
    before do
      @header_builder = Smartsheet::API::Headers::HeaderBuilder.new('0123456789')
      @request = OpenStruct.new
    end

    it 'applies defaults' do
      @header_builder.apply(@request)

      @request.headers.wont_be_nil
      @request.headers.must_be_kind_of Hash
      @request.headers[:Accept].must_equal 'application/json'
      @request.headers[:Authorization].must_equal 'Bearer 0123456789'
      @request.headers[:'User-Agent'].must_equal 'smartsheet-ruby-sdk'
    end

    it 'applies sending json' do
      @header_builder.sending_json
      @header_builder.apply(@request)

      @request.headers.wont_be_nil
      @request.headers.must_be_kind_of Hash
      @request.headers[:'Content-Type'].must_equal 'application/json'
    end

    it 'applies overrides' do
      @header_builder.with_overrides({SomeOverride: 'someValue', Authorization: 'someAuth'})
      @header_builder.apply(@request)

      @request.headers.wont_be_nil
      @request.headers.must_be_kind_of Hash
      @request.headers[:SomeOverride].must_equal 'someValue'
      @request.headers[:Authorization].must_equal 'someAuth'
      @request.headers[:Accept].must_equal 'application/json'
    end
  end

  describe '#build_headers' do
    before do
      @object = OpenStruct.new
      @object.token = '0123456789'
      @object.extend(Smartsheet::API::Headers)
      @request = OpenStruct.new
    end

    it 'uses token' do
      headers = @object.build_headers
      headers.apply(@request)

      @request.headers.wont_be_nil
      @request.headers.must_be_kind_of Hash
      @request.headers[:Authorization].must_equal 'Bearer 0123456789'
    end

    it 'uses overrides' do
      headers = @object.build_headers({SomeOverride: 'someValue'})
      headers.apply(@request)

      @request.headers.wont_be_nil
      @request.headers.must_be_kind_of Hash
      @request.headers[:SomeOverride].must_equal 'someValue'
    end
  end
end
