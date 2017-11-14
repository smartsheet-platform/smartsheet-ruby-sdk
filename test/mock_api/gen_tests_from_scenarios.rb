# Usage: ruby gen_tests_from_scenarios.rb scenario_file output_file
# Summary:
# This script can be used to generate mock api tests from a scenario.json
# file. The output will be an array that can be copied into a test file and
# run. You will need to replace the 'client.TODO_METHOD' string for each
# test with an actual method call (such as client.sheets.list(**args)) before
# running the tests.

require 'cli'
require 'json'

def replace_pattern(string, pattern, replacement)
    string.gsub!(Regexp.new(pattern), replacement)
end

config = CLI.new do
    argument :scenario_file, description: 'Path of JSON mock api scenario file'
    argument :output_file, description: 'Path of file to output tests to'
end.parse!

# load scenarios
scenarios = JSON.parse(File.read(config.scenario_file))

# create tests
tests = []
scenarios.each do |scenario|
    test = {}
    test[:scenario_name] = scenario['scenario']
    test[:method] = '->(client, args) {client.TODO_METHOD(**args)}'
    test[:should_error] = (scenario['response'].key?('status') && scenario['response']['status'] != 200)
    test[:args] = {}
    test[:args][:body] = scenario['request']['body'] if scenario['request'].key?('body')

    tests << test
end

# generate hash-style output
json_output = JSON.pretty_generate(tests)
replace_pattern(json_output, '"scenario_name"', 'scenario_name')
replace_pattern(json_output, '"method"', 'method')
replace_pattern(json_output, '"should_error"', 'should_error')
replace_pattern(json_output, '"args"', 'args')
replace_pattern(json_output, '"body"', 'body')
replace_pattern(json_output, Regexp.escape('"->(client, args) {client.TODO_METHOD(**args)}"'), '->(client, args) {client.TODO_METHOD(**args)}')
replace_pattern(json_output, '"', "'")

# save to file
File.open(config.output_file, 'w') do |f|
    f.write(json_output)
end