require_relative '../test_helper'

class MockApiTestHelper < Minitest::Test
    def setup
        @client = Smartsheet::Client.new(base_url: 'http://localhost:8082')
    end

    def self.define_integration_test(scenario_name:, args:, method:, should_error:)
        args[:header_overrides] = args[:header_overrides].nil?() ? {} : args[:header_overrides]
        args[:header_overrides]['Api-Scenario'] = scenario_name

        define_method "test_#{scenario_name}" do
            begin
                method.call(client, args)
                flunk("Expected error, but did not fail.") if should_error
            rescue Smartsheet::ApiError => e
                flunk(e.message) unless should_error && !scenario_error?(e)
            end
        end
    end

    def self.define_skipped_integration_test(scenario_name:, reason:)
        define_method "test_#{scenario_name}" do
            skip("Skipping #{scenario_name}: #{reason}")
        end
    end

    def self.define_tests
        to_skip, to_run = tests.partition { |test| test.has_key? :skip }

        to_run.each do |test|
            define_integration_test(
                scenario_name: test[:scenario_name],
                method: test[:method],
                should_error: test.fetch(:should_error, false),
                args: test[:args]
            )
        end

        to_skip.each do |test|
            define_skipped_integration_test(
                scenario_name: test[:scenario_name],
                reason: test[:skip]
            )
        end
    end

    def scenario_error?(e)
        e.error_code == 9999
    end

    protected

    attr_reader :client

end
