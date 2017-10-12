require_relative '../../../test_helper'
require 'smartsheet/api/url_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'
require 'smartsheet/constants'

describe Smartsheet::API::UrlBuilder do
  describe '#build_urls' do
    before do
      @base_url = 'base'
    end

    def when_url_is_built(url, **url_args)
      url_builder = Smartsheet::API::UrlBuilder.new(
          Smartsheet::API::EndpointSpec.new(:get, url),
          Smartsheet::API::RequestSpec.new(**url_args),
          @base_url)
      @url = url_builder.build
    end

    it 'returns slash separated url' do
      when_url_is_built(%w[a b c])

      @url.must_equal @base_url + '/a/b/c'
    end

    it 'has correct base' do
      when_url_is_built([])

      @url.must_equal @base_url
    end

    it 'handles symbols' do
      when_url_is_built(['a', :a_id, 'b', :b_id], a_id: 123, b_id: 234)

      @url.must_equal @base_url + '/a/123/b/234'
    end
  end
end
