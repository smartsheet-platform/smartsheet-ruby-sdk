require_relative '../../test_helper'
require 'smartsheet/api/net_client'

module Smartsheet
  module Test
    module EndpointHelper
      def define_setup
        define_method :setup do
          @mock_client = mock
          @mock_client.stubs(:token).returns('a_token')

          Smartsheet::API::RetryingNetClient.stubs(:new).returns(@mock_client)

          @smartsheet_client = Smartsheet::SmartsheetClient.new('a_token')
        end
      end

      def define_endpoints_tests
        self.endpoints.each do |endpoint|
          define_endpoint_tests(endpoint)
        end
      end

      def define_endpoint_tests(endpoint)
        define_endpoint_spec_is_valid(endpoint)
        define_accepts_header_overrides(endpoint)
        define_valid_body(endpoint)
        define_valid_headers(endpoint) unless endpoint[:headers].nil?
        define_valid_url(endpoint)

        if endpoint[:has_params]
          define_accepts_params(endpoint)
        else
          define_doesnt_accept_params(endpoint)
        end
      end

      def define_valid_url(endpoint)
        define_method "test_#{endpoint[:symbol]}_valid_url" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            # this validates the URL
            Smartsheet::API::UrlBuilder.new(endpoint_spec, request_spec)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_headers(endpoint)
        define_method "test_#{endpoint[:symbol]}_valid_headers" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:headers], endpoint_spec.headers)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_body(endpoint)
        define_method "test_#{endpoint[:symbol]}_valid_body" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:args].key?(:body), endpoint_spec.requires_body?)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_endpoint_spec_is_valid(endpoint)
        define_method "test_#{endpoint[:symbol]}_valid_endpoint_spec" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:method], endpoint_spec.method)
            assert_equal(endpoint[:url], endpoint_spec.url_segments)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_doesnt_accept_params(endpoint)
        define_method "test_#{endpoint[:symbol]}_doesnt_accept_params" do
          @mock_client.stubs(:make_request)

          assert_raises(ArgumentError) do
            category.send(endpoint[:symbol], **endpoint[:args], params: {p: ''})
          end
        end
      end

      def define_accepts_params(endpoint)
        define_method "test_#{endpoint[:symbol]}_accepts_params" do
          params = {p: ''}
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(params, request_spec.params)
          end

          category.send(endpoint[:symbol], **endpoint[:args], params: params)
        end
      end

      def define_accepts_header_overrides(endpoint)
        define_method "test_#{endpoint[:symbol]}_accepts_header_overrides" do
          header_overrides = {h: ''}
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(header_overrides, request_spec.header_overrides)
          end
          category.send(endpoint[:symbol], **endpoint[:args], header_overrides: header_overrides)
        end
      end
    end
  end
end
