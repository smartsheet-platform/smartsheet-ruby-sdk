require 'minitest/autorun'
require_relative '../../../lib/smartsheet/api/urls'
require_relative '../../../lib/smartsheet/api/endpoint_spec'
require_relative '../../../lib/smartsheet/api/request_spec'

describe Smartsheet::API::UrlBuilder do
  before do

  end

  describe '#build_urls' do
    it 'returns slash separated url' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, %w[a b c]),
          Smartsheet::API::RequestSpec.new(params:{}, header_overrides: {}, body:{}))
      url_builder.build().must_equal 'https://api.smartsheet.com/2.0/a/b/c'
    end

    it 'has correct base' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, []),
          Smartsheet::API::RequestSpec.new(params:{}, header_overrides: {}, body:{}))
      url_builder.build().must_equal 'https://api.smartsheet.com/2.0'
    end

    it 'handles symbols' do
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id, 'b', :b_id]),
          Smartsheet::API::RequestSpec.new(params:{}, header_overrides: {}, body:{}, a_id: 123, b_id: 234))
      url_builder.build().must_equal 'https://api.smartsheet.com/2.0/a/123/b/234'
    end

    it 'raises on missing symbol' do
      -> {
        Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id, 'b', :b_id]),
          Smartsheet::API::RequestSpec.new(params:{}, header_overrides: {}, body:{}, a_id: 123))
      }.must_raise RuntimeError
    end

    it 'raises on extra symbol' do
      -> {
        Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, ['a', :a_id]),
          Smartsheet::API::RequestSpec.new(params:{}, header_overrides: {}, body:{}, a_id: 123, b_id: 234))
      }.must_raise RuntimeError
    end
  end
end
