require_relative '../../../test_helper'
require 'smartsheet/api/header_builder'
require 'faraday'

describe Smartsheet::API::Request do
  before do
    @endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['a'])

    @some_url = 'some/url'
    @some_header = { h: '' }
    @some_body = { b: '' }
    @some_params = { p: '' }

    @base_url = 'base'
  end

  def given_mock_url_builder
    mock_url_builder = mock
    mock_url_builder.stubs(:build).returns(@some_url.clone)
    Smartsheet::API::UrlBuilder.stubs(:new).returns(mock_url_builder)
  end

  def given_mock_header_builder
    mock_header_builder = mock
    mock_header_builder.stubs(:build).returns(@some_header.clone)
    Smartsheet::API::HeaderBuilder.stubs(:new).returns(mock_header_builder)
  end
  
  def given_mock_body_builder
    mock_body_builder = mock
    mock_body_builder.stubs(:build).returns(@some_body.clone)
    Smartsheet::API::BodyBuilder.stubs(:new).returns(mock_body_builder)
  end

  def given_custom_request_builders
    given_mock_url_builder
    given_mock_header_builder
    given_mock_body_builder
  end

  it 'provides method' do
    given_custom_request_builders
    request_spec = Smartsheet::API::RequestSpec.new

    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url)
      .method.must_equal :get
  end

  it 'provides url' do
    given_custom_request_builders
    request_spec = Smartsheet::API::RequestSpec.new

    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url)
      .url.must_equal @some_url
  end

  it 'provides headers' do
    given_custom_request_builders
    request_spec = Smartsheet::API::RequestSpec.new

    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url)
      .headers.must_equal(@some_header)
  end

  it 'provides params' do
    given_custom_request_builders
    request_spec = Smartsheet::API::RequestSpec.new(params: @some_params)

    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url)
      .params.must_equal @some_params
  end

  it 'provides body' do
    given_custom_request_builders
    request_spec = Smartsheet::API::RequestSpec.new(body: @some_body)

    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url)
      .body.must_equal @some_body
  end

  it "includes the 'app user agent' header when provided" do
    given_mock_url_builder
    given_mock_body_builder

    mock_app_user_agent = 'app-user-agent'
    mock_header_builder = mock
    mock_header_builder.stubs(:build).returns(@some_header.clone)
    Smartsheet::API::HeaderBuilder
      .expects(:new)
      .with do |_token, _endpoind_spec, _request_spec, app_user_agent:, assume_user:|
        app_user_agent == mock_app_user_agent
      end
      .returns(mock_header_builder)

    request_spec = Smartsheet::API::RequestSpec.new
    
    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url, app_user_agent: mock_app_user_agent)
  end

  it "includes the 'assume user' header when provided" do
    given_mock_url_builder
    given_mock_body_builder

    mock_assume_user = 'assume-user'
    mock_header_builder = mock
    mock_header_builder.stubs(:build).returns(@some_header.clone)
    Smartsheet::API::HeaderBuilder
      .expects(:new)
      .with do |_token, _endpoind_spec, _request_spec, app_user_agent:, assume_user:|
        assume_user == mock_assume_user
      end
      .returns(mock_header_builder)

    request_spec = Smartsheet::API::RequestSpec.new
    
    Smartsheet::API::Request
      .new(TOKEN, @endpoint_spec, request_spec, @base_url, assume_user: mock_assume_user)
  end

  it 'should not be equal to other classes' do
    request_spec = Smartsheet::API::RequestSpec.new
    Smartsheet::API::Request.new(TOKEN, @endpoint_spec, request_spec, @base_url).wont_equal 1
  end

  it 'should be equal to an identical instance' do
    request_spec = Smartsheet::API::RequestSpec.new
    request_a = Smartsheet::API::Request.new(TOKEN, @endpoint_spec, request_spec, @base_url)
    request_b = Smartsheet::API::Request.new(TOKEN, @endpoint_spec, request_spec, @base_url)
    request_a.must_equal request_b
  end

  it 'should not be equal to an instance with a differing token' do
    endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['x'])
    request_spec = Smartsheet::API::RequestSpec.new
    request_a = Smartsheet::API::Request.new(TOKEN, endpoint_spec, request_spec, @base_url)
    request_b = Smartsheet::API::Request.new(TOKEN + 'a', endpoint_spec, request_spec, @base_url)
    request_a.wont_equal request_b
  end

  it 'should not be equal to an instance with a differing endpoint spec' do
    endpoint_spec_a = Smartsheet::API::EndpointSpec.new(:get, ['x'])
    endpoint_spec_b = Smartsheet::API::EndpointSpec.new(:post, ['x'])
    request_spec = Smartsheet::API::RequestSpec.new
    request_a = Smartsheet::API::Request.new(TOKEN, endpoint_spec_a, request_spec, @base_url)
    request_b = Smartsheet::API::Request.new(TOKEN, endpoint_spec_b, request_spec, @base_url)
    request_a.wont_equal request_b
  end

  it 'should not be equal to an instance with a differing request spec' do
    endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['x'])
    request_spec_a = Smartsheet::API::RequestSpec.new
    request_spec_b = Smartsheet::API::RequestSpec.new(params: { a: 1 })
    request_a = Smartsheet::API::Request.new(TOKEN, endpoint_spec, request_spec_a, @base_url)
    request_b = Smartsheet::API::Request.new(TOKEN, endpoint_spec, request_spec_b, @base_url)
    request_a.wont_equal request_b
  end
end
