require_relative '../../test_helper'
require 'faraday'
require 'smartsheet/api/body_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'
require 'smartsheet/api/file_spec'

describe Smartsheet::API::BodyBuilder do
  def given_json_body
    @some_body = {b: ''}
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body.clone)
  end

  def given_nil_json_body
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: nil)
  end

  def given_non_json_body
    @some_body = {b: ''}
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :not_json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body.clone)
  end

  def given_string_json_body
    @some_body = '{"b": ""}'
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body.clone)
  end

  def given_path_file_body
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :file)
    @request_spec = Smartsheet::API::RequestSpec.new(
        file_spec: Smartsheet::API::PathFileSpec.new('some/path', nil, '')
    )
  end

  def given_obj_file_body
    file_obj = mock
    file_obj.stubs(:read)
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :file)
    @request_spec = Smartsheet::API::RequestSpec.new(
        file_spec: Smartsheet::API::ObjectFileSpec.new(file_obj, 'file', 123, ''))
  end

  def given_snake_case_body
    @some_body = {snake_case: 123, camelCase: '234'}
    @some_body['string_snake_case'] = '345'
    @some_body['stringCamelCase'] = 456
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'], body_type: :json)
    @request_spec = Smartsheet::API::RequestSpec.new(body: @some_body.clone)
    @expected_body = {snakeCase: 123, camelCase: '234'}
    @expected_body['stringSnakeCase'] = '345'
    @expected_body['stringCamelCase'] = 456
  end

  def when_body_is_built
    Smartsheet::API::BodyBuilder.new(@endpoint_spec, @request_spec)
        .build
  end

  it 'formats JSON body as JSON string' do
    given_json_body
    body = when_body_is_built

    body.wont_be_nil
    body.must_equal @some_body.to_json
  end

  it 'returns request body if not JSON' do
    given_non_json_body
    body = when_body_is_built

    body.wont_be_nil
    body.must_equal @some_body
  end

  it 'does not format JSON strings as JSON strings' do
    given_string_json_body
    body = when_body_is_built

    body.wont_be_nil
    body.must_equal @some_body
  end

  it 'does not format nil JSON bodies' do
    given_nil_json_body
    body = when_body_is_built

    body.must_be_nil
  end

  it 'converts snake case to camel case' do
    given_snake_case_body
    body = when_body_is_built

    body.must_equal @expected_body.to_json
  end

  it 'returns valid file object via path' do
    File.stubs(:read)
    File.stubs(:open)
    File.stubs(:size).returns(10)

    given_path_file_body
    body = when_body_is_built

    body.must_be_kind_of Faraday::UploadIO
  end

  it 'returns valid file object via obj' do
    given_obj_file_body
    body = when_body_is_built

    body.must_be_kind_of Faraday::UploadIO
  end
end
