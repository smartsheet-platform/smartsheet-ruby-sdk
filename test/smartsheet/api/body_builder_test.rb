require_relative '../../test_helper'
require 'smartsheet/api/body_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'

describe Smartsheet::API::BodyBuilder do
  def given_json_body
    @some_body = {b: ''}
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body)
  end

  def given_nil_json_body
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: nil)
  end

  def given_non_json_body
    @some_body = {b: ''}
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :not_json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body)
  end

  def given_string_json_body
    @some_body = '{"b": ""}'
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body)
  end


  it 'formats JSON body as JSON string' do
    given_json_body
    body = Smartsheet::API::BodyBuilder.new(@endpoint_spec, @request_spec)
                  .build

    body.wont_be_nil
    body.must_equal @some_body.to_json
  end

  it 'returns request body if not JSON' do
    given_non_json_body
    body = Smartsheet::API::BodyBuilder.new(@endpoint_spec, @request_spec)
               .build

    body.wont_be_nil
    body.must_equal @some_body
  end

  it 'does not format JSON strings as JSON strings' do
    given_string_json_body
    body = Smartsheet::API::BodyBuilder.new(@endpoint_spec, @request_spec)
               .build

    body.wont_be_nil
    body.must_equal @some_body
  end

  it 'does not format nil JSON bodies' do
    given_nil_json_body
    body = Smartsheet::API::BodyBuilder.new(@endpoint_spec, @request_spec)
               .build

    body.must_be_nil
  end
end
