require_relative '../../test_helper'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'

describe Smartsheet::API::HeaderBuilder do
  it 'applies defaults' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new,
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:Accept].must_equal 'application/json'
    headers[:Authorization].must_equal 'Bearer ' + TOKEN
    headers[:'User-Agent'].must_equal 'smartsheet-ruby-sdk'
  end

  it 'applies body_type json' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}, body_type: :json),
        Smartsheet::API::RequestSpec.new(body: {}),
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:'Content-Type'].must_equal 'application/json'
  end

  it 'applies overrides' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new(header_overrides: {SomeOverride: 'someValue', Authorization: 'someAuth'}),
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:SomeOverride].must_equal 'someValue'
    headers[:Authorization].must_equal 'someAuth'
    headers[:Accept].must_equal 'application/json'
  end

  it 'applies user defined content_type for uploads' do
    File.stubs(:size).returns(10)
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}, body_type: :file),
        Smartsheet::API::RequestSpec.new(content_type: 'someContentType'),
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:'Content-Type'].must_equal 'someContentType'
  end

  it 'applies content length correctly for uploads' do
    File.stubs(:size).returns(10)
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}, body_type: :file),
        Smartsheet::API::RequestSpec.new,
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:'Content-Length'].must_equal '10'
  end

  it 'applies content disposition correctly for uploads' do
    File.stubs(:size).returns(10)
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}, body_type: :file),
        Smartsheet::API::RequestSpec.new(filename: 'someFile'),
        nil)
                  .build

    headers.must_be_kind_of Hash
    headers[:'Content-Disposition'].must_equal 'attachment; filename="someFile"'
  end

  it 'applies assume user correctly when set' do
    assume_user = 'john.doe@smartsheet.com'.freeze
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new,
        assume_user)
                  .build

    headers.must_be_kind_of Hash
    headers[:'Assume-User'].must_equal assume_user
  end

  it 'applies assume user correctly when not set' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new,
        nil)
                  .build

    headers.must_be_kind_of Hash
    (headers.key? :'Assume-User').must_equal false
  end
end
