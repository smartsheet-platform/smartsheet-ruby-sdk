require_relative '../test_helper'

class IntegrationTestHelper < Minitest::Test
    def setup
        @client = Smartsheet::Client.new(base_url: 'http://localhost:8082')
    end
    
    def self.define_integration_test(scenario_name:, args:, method:, should_error:)
        args[:header_overrides] = {'Api-Scenario': scenario_name}
        define_method "test_#{scenario_name}" do
            begin
                response = method.call(client, args)
            rescue Smartsheet::HttpResponseError => e
                flunk(e.message) unless should_error
            end
        end
    end

    def self.define_tests
        tests.each do |test|
            define_integration_test(
                scenario_name: test[:scenario_name],
                method: test[:method],
                should_error: test.fetch(:should_error, false),
                args: test[:args]
            )
        end
    end

    protected

    attr_reader :client

end
