require_relative '../../test_helper'
require_relative '../../../lib/smartsheet/api/headers'
require_relative '../../../lib/smartsheet/api/endpoint_spec'
require_relative '../../../lib/smartsheet/api/request_spec'

describe Smartsheet::API::HeaderBuilder do
  TOKEN = '0123456789'

  it 'applies defaults' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new(params: {}, header_overrides: {}, body: {}))
                  .build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:Accept].must_equal 'application/json'
    headers[:Authorization].must_equal 'Bearer ' + TOKEN
    headers[:'User-Agent'].must_equal 'smartsheet-ruby-sdk'
  end

  it 'applies body_type json' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}, body_type: :json),
        Smartsheet::API::RequestSpec.new(params: {}, header_overrides: {}, body: {}))
                  .build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:'Content-Type'].must_equal 'application/json'
  end

  it 'applies overrides' do
    headers = Smartsheet::API::HeaderBuilder.new(
        TOKEN,
        Smartsheet::API::EndpointSpec.new(:get, [], headers: {}),
        Smartsheet::API::RequestSpec.new(params: {}, header_overrides: {SomeOverride: 'someValue', Authorization: 'someAuth'}, body: {}))
                  .build()

    headers.wont_be_nil
    headers.must_be_kind_of Hash
    headers[:SomeOverride].must_equal 'someValue'
    headers[:Authorization].must_equal 'someAuth'
    headers[:Accept].must_equal 'application/json'
  end
end
