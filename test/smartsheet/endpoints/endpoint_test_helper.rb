require_relative '../../test_helper'
require_relative 'url_validator'
require_relative 'endpoint_spec_validator'
require 'smartsheet/api/request_client'
require 'faraday'

module Smartsheet
  module Test
    module EndpointHelper
      def define_setup
        define_method :setup do
          @mock_client = mock
          Smartsheet::API::RequestClient.stubs(:new).returns(@mock_client)

          @smartsheet_client = Smartsheet::SmartsheetClient.new(token: TOKEN)
          File.stubs(:size).returns(10)
          File.stubs(:open).returns({})
          Faraday::UploadIO.stubs(:new).returns('upload')
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
        define_valid_file(endpoint)
        define_valid_headers(endpoint) unless endpoint[:headers].nil?
        define_valid_url(endpoint)
        define_accepts_params(endpoint)
        define_valid_expected_params(endpoint) unless endpoint[:expected_params].nil?
        define_valid_call(endpoint)
      end

      def define_valid_call(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_call" do
          Smartsheet::API::RequestClient.unstub(:new)
          mock_body = Object.new
          mock_body.stubs(:'should_retry?').returns(false)
          mock_body.stubs(:'success?').returns(true)
          mock_body.stubs(:result).returns({})

          mock_response = Object.new
          mock_response.stubs(:body).returns(mock_body)

          mock_conn = Object.new
          mock_conn.stubs(:get).returns(mock_response)
          mock_conn.stubs(:post).returns(mock_response)
          mock_conn.stubs(:put).returns(mock_response)
          mock_conn.stubs(:delete).returns(mock_response)
          Faraday.stubs(:new).returns(mock_conn)



          @smartsheet_client = Smartsheet::SmartsheetClient.new(token: 'token')

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_url(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_url" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            Smartsheet::Test::UrlValidator.new(endpoint_spec, request_spec).validate
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_expected_params(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_expected_params" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:expected_params], request_spec.params)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_headers(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_headers" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:headers], endpoint_spec.headers)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_body(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_body" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:args].key?(:body), endpoint_spec.requires_body? && !endpoint_spec.sending_file?)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_valid_file(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_file" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:args].key?(:file_options), endpoint_spec.sending_file?)
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_endpoint_spec_is_valid(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_valid_endpoint_spec" do
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(endpoint[:method], endpoint_spec.method)
            assert_equal(endpoint[:url], endpoint_spec.url_segments)
            Smartsheet::Test::EndpointSpecValidator.new(endpoint_spec).validate
          end

          category.send(endpoint[:symbol], **endpoint[:args])
        end
      end

      def define_accepts_params(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_accepts_params" do
          params = {p: ''}
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            expected_params = endpoint[:expected_params].nil? ?
                                  params :
                                  params.merge(endpoint[:expected_params])
            assert_equal(expected_params, request_spec.params)

          end

          category.send(endpoint[:symbol], **endpoint[:args], params: params.clone)
        end
      end

      def define_accepts_header_overrides(endpoint)
        define_method "test_#{self.name}_#{endpoint[:symbol]}_accepts_header_overrides" do
          header_overrides = {h: ''}
          @mock_client.expects(:make_request).with do |endpoint_spec, request_spec|
            assert_equal(header_overrides, request_spec.header_overrides)
          end
          category.send(endpoint[:symbol], **endpoint[:args], header_overrides: header_overrides.clone)
        end
      end
    end
  end
end
