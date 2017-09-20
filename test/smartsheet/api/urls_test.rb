require_relative '../../test_helper'
require 'smartsheet/api/urls'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'

describe Smartsheet::API::UrlBuilder do
  describe '#build_urls' do
    it 'returns slash separated url' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, %w[a b c]),
          Smartsheet::API::RequestSpec.new)
      url_builder.build.must_equal 'https://api.smartsheet.com/2.0/a/b/c'
    end

    it 'has correct base' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, []),
          Smartsheet::API::RequestSpec.new)
      url_builder.build.must_equal 'https://api.smartsheet.com/2.0'
    end

    it 'handles symbols' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id, 'b', :b_id]),
          Smartsheet::API::RequestSpec.new(a_id: 123, b_id: 234))
      url_builder.build.must_equal 'https://api.smartsheet.com/2.0/a/123/b/234'
    end

    it 'raises on missing symbol' do
      -> {
        Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id, 'b', :b_id]),
          Smartsheet::API::RequestSpec.new(a_id: 123))
      }.must_raise RuntimeError
    end

    it 'raises on extra symbol' do
      -> {
        Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id]),
          Smartsheet::API::RequestSpec.new(a_id: 123, b_id: 234))
      }.must_raise RuntimeError
    end
  end
end
