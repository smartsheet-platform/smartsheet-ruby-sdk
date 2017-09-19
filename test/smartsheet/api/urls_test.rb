require 'minitest/autorun'
require_relative '../../../lib/smartsheet/api/urls'
require_relative '../../../lib/smartsheet/api/endpoint_spec'
require_relative '../../../lib/smartsheet/api/request_spec'

describe Smartsheet::API::UrlBuilder do
  before do
    @url_builder = Smartsheet::API::UrlBuilder.new
  end

  describe '#build_urls' do
    it 'returns slash separated url' do
      @url_builder
          .for_endpoint(Smartsheet::API::EndpointSpec.new({symbol: :asdf, method: :get, url: %w[a b c]}))
          .for_request(Smartsheet::API::RequestSpec.new(path_args: {}, params:{}, header_overrides: {}, body:{}))
      @url_builder.build().must_equal 'https://api.smartsheet.com/2.0/a/b/c'
    end

    it 'has correct base' do
      @url_builder
          .for_endpoint(Smartsheet::API::EndpointSpec.new({symbol: :asdf, method: :get, url: []}))
          .for_request(Smartsheet::API::RequestSpec.new(path_args: {}, params:{}, header_overrides: {}, body:{}))
      @url_builder.build().must_equal 'https://api.smartsheet.com/2.0'
    end

    it 'handles symbols' do
      @url_builder
          .for_endpoint(Smartsheet::API::EndpointSpec.new({symbol: :asdf, method: :get, url: ['a', :a_id, 'b', :b_id]}))
          .for_request(Smartsheet::API::RequestSpec.new(path_args: {a_id: 123, b_id: 234}, params:{}, header_overrides: {}, body:{}))
      @url_builder.build().must_equal 'https://api.smartsheet.com/2.0/a/123/b/234'
    end

    it 'raises on missing symbol' do
      @url_builder
          .for_endpoint(Smartsheet::API::EndpointSpec.new({symbol: :asdf, method: :get, url: ['a', :a_id, 'b', :b_id]}))
          .for_request(Smartsheet::API::RequestSpec.new(path_args: {a_id: 123}, params:{}, header_overrides: {}, body:{}))
      -> {@url_builder.build()}.must_raise RuntimeError
    end
  end
end
