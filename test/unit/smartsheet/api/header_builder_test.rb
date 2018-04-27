require_relative '../../../test_helper'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'
require 'smartsheet/api/file_spec'
require 'smartsheet/constants'

describe Smartsheet::API::HeaderBuilder do
  def given_path_file_request_spec(path: 'path/to/file', filename: nil, file_length: 10, content_type: '')
    File.stubs(:size).returns(file_length)
    File.stubs(:open).returns({})
    @request_spec = Smartsheet::API::RequestSpec.new(
        file_spec: Smartsheet::API::PathFileSpec.new(path, filename, content_type)
    )
  end

  def given_object_file_request_spec(filename: 'file', file_length: 10, content_type: '')
    File.stubs(:size).returns(file_length)
    file_obj = mock
    file_obj.stubs(:read)

    @request_spec = Smartsheet::API::RequestSpec.new(
        file_spec: Smartsheet::API::ObjectFileSpec.new(file_obj, filename, file_length, content_type)
    )
  end

  def given_import_path_file_request_spec(path: 'path/to/file', file_length: 10, content_type: '')
    File.stubs(:size).returns(file_length)
    File.stubs(:open).returns({})
    @request_spec = Smartsheet::API::RequestSpec.new(
      file_spec: Smartsheet::API::ImportPathFileSpec.new(path, content_type)
    )
  end

  def given_import_object_file_request_spec(file_length: 10, content_type: '')
    File.stubs(:size).returns(file_length)
    file_obj = mock
    file_obj.stubs(:read)

    @request_spec = Smartsheet::API::RequestSpec.new(
      file_spec: Smartsheet::API::ImportObjectFileSpec.new(file_obj, file_length, content_type)
    )
  end

  def given_request_spec(body: nil, header_overrides: {})
    @request_spec = Smartsheet::API::RequestSpec.new(body: body, header_overrides: header_overrides)
  end

  def given_file_endpoint_spec
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, [], body_type: :file)
  end

  def given_endpoint_spec(**spec)
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, [], **spec)
  end

  def when_headers_are_built(assume_user: nil, app_user_agent: nil)
    @headers = Smartsheet::API::HeaderBuilder.new(
      TOKEN,
      @endpoint_spec,
      @request_spec,
      assume_user: assume_user,
      app_user_agent: app_user_agent
    )
    .build
  end

  it 'applies defaults' do
    given_endpoint_spec
    given_request_spec

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:Accept].must_equal Smartsheet::Constants::JSON_TYPE
    @headers[:Authorization].must_equal 'Bearer ' + TOKEN
    @headers[:'User-Agent'].must_equal "#{Smartsheet::Constants::USER_AGENT}/#{Smartsheet::Constants::VERSION}"
  end

  it 'applies body_type json' do
    given_endpoint_spec(body_type: :json)
    given_request_spec(body: {})

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Type'].must_equal Smartsheet::Constants::JSON_TYPE
  end

  it 'applies overrides' do
    given_endpoint_spec
    given_request_spec(header_overrides: {SomeOverride: 'someValue', Authorization: 'someAuth'})

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:SomeOverride].must_equal 'someValue'
    @headers[:Authorization].must_equal 'someAuth'
    @headers[:Accept].must_equal Smartsheet::Constants::JSON_TYPE
  end

  it 'applies user defined content_type for uploads via path' do
    given_file_endpoint_spec
    given_path_file_request_spec(content_type: 'someContentType')

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Type'].must_equal 'someContentType'
  end

  it 'applies user defined content_type for uploads via file obj' do
    given_file_endpoint_spec
    given_object_file_request_spec(content_type: 'someContentType')

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Type'].must_equal 'someContentType'
  end

  it 'applies content length correctly for upload via path' do
    given_file_endpoint_spec
    given_path_file_request_spec(file_length: 100)

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Length'].must_equal '100'
  end

  it 'applies content length correctly for upload via file obj' do
    given_file_endpoint_spec
    given_object_file_request_spec(file_length: 1123)

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Length'].must_equal '1123'
  end

  it 'applies content disposition correctly for uploads via path' do
    given_file_endpoint_spec
    given_path_file_request_spec(path: 'path/to/someFile!@#$%^&*()')

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Disposition'].must_equal 'attachment; filename="someFile%21%40%23%24%25%5E%26%2A%28%29"'
  end

  it 'applies content disposition correctly for uploads via path w/ name' do
    given_file_endpoint_spec
    given_path_file_request_spec(filename: 'fn')

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Disposition'].must_equal 'attachment; filename="fn"'
  end

  it 'applies content disposition correctly for uploads via path without a filename' do
    given_file_endpoint_spec
    given_import_path_file_request_spec

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Disposition'].must_equal 'attachment'
  end

  it 'applies content disposition correctly for uploads via obj' do
    given_file_endpoint_spec
    given_object_file_request_spec(filename: 'some_file')

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Disposition'].must_equal 'attachment; filename="some_file"'
  end

  it 'applies content disposition correctly for uploads via object without a filename' do
    given_file_endpoint_spec
    given_import_object_file_request_spec

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'Content-Disposition'].must_equal 'attachment'
  end

  it 'applies assume user correctly when set' do
    given_endpoint_spec
    given_request_spec

    when_headers_are_built(assume_user: 'john.doe@smartsheet.com')

    @headers.must_be_kind_of Hash
    @headers[:'Assume-User'].must_equal 'john.doe%40smartsheet.com'
  end

  it 'applies assume user correctly when not set' do
    given_endpoint_spec
    given_request_spec

    when_headers_are_built

    @headers.must_be_kind_of Hash
    (@headers.key? :'Assume-User').must_equal false
  end

  it 'allows assume user to be overriden on a per-request basis' do
    given_endpoint_spec
    given_request_spec(header_overrides: {:'Assume-User' => CGI::escape('john.doe@smartsheet.com')})

    when_headers_are_built(assume_user: 'jane.doe@smartsheet.com')

    @headers[:'Assume-User'].must_equal 'john.doe%40smartsheet.com'
  end

  it 'appends app user agent correctly when set' do
    given_endpoint_spec
    given_request_spec

    when_headers_are_built(app_user_agent: 'my-app')

    @headers.must_be_kind_of Hash
    @headers[:'User-Agent'].must_equal "smartsheet-ruby-sdk/#{Smartsheet::VERSION}/my-app"
  end

  it 'does not append app user agent when not set' do
    given_endpoint_spec
    given_request_spec

    when_headers_are_built

    @headers.must_be_kind_of Hash
    @headers[:'User-Agent'].must_equal "smartsheet-ruby-sdk/#{Smartsheet::VERSION}"
  end
end
