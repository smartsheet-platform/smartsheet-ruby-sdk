# Smartsheet Ruby SDK [![Build Status](https://travis-ci.org/smartsheet-platform/smartsheet-ruby-sdk.svg?branch=master)](https://travis-ci.org/smartsheet-platform/smartsheet-ruby-sdk) [![Coverage Status](https://coveralls.io/repos/github/smartsheet-platform/smartsheet-ruby-sdk/badge.svg?branch=master)](https://coveralls.io/github/smartsheet-platform/smartsheet-ruby-sdk?branch=master) [![Gem Version](https://badge.fury.io/rb/smartsheet.svg)](https://badge.fury.io/rb/smartsheet)

This is an SDK to simplify connecting to the [Smartsheet API](http://www.smartsheet.com/developers/api-documentation) from Ruby applications.

## System Requirements

The SDK supports Ruby versions 2.2 or later.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smartsheet', '>= 1.0.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartsheet

## Documentation

The Smartsheet API documentation with corresponding SDK example code can be found [here](http://www.smartsheet.com/developers/api-documentation).

## Example Usage

To call the API, you must have an access token, which looks something like this example: `ll352u9jujauoqz4gstvsae05`. You can find the access token in the UI at Account > Personal Settings > API Access.

The following is a brief sample that shows you how to:

* Initialize the client
* List all sheets
* Load one sheet

```ruby
require 'smartsheet'

# Initialize the client
smartsheet_client = Smartsheet::Client.new(token: 'll352u9jujauoqz4gstvsae05')

# The `smartsheet_client` variable now contains access to all of the APIs

begin
  # List all sheets
  sheets = smartsheet_client.sheets.list

  # Select first sheet
  sheet_id = sheets[:data][0][:id]

  # Load the entire sheet
  puts smartsheet_client.sheets.get(sheet_id: sheet_id)

rescue Smartsheet::ApiError => e
  puts "Error Code: #{e.error_code}"
  puts "Message: #{e.message}"
  puts "Ref Id: #{e.ref_id}"
end
```

See the [read-write-sheet](https://github.com/smartsheet-samples/ruby-read-write-sheet) example to see a more robust use case in action.

## Basic Configuration

When creating the client object, pass an object with any of the following properties to tune its behavior.

* `token` - Your smartsheet API access token. If you omit this property (or pass an empty string) then the access token will be read from the system environment variable `SMARTSHEET_ACCESS_TOKEN`.

* `max_retry_time` - The maximum time in seconds to retry intermittent errors. (Defaults to 15 seconds.)

## Advanced Configuration Options
### Logging Configuration

Smartsheet expects a standard Ruby logger.  For example, to enable console logging of warnings and above, make a call such as the following:

```ruby
logger = Logger.new(STDOUT)
logger.level = Logger::INFO
smartsheet = Smartsheet::Client.new(logger: logger)
```

Supported log levels are as follows:

|Level          |What is logged                   |
|---------------|---------------------------------|
|`Logger::ERROR`|Failures only                    |
|`Logger::WARN` |Failures and retries             |
|`Logger::INFO` |Each call's URL and response code|
|`Logger::DEBUG`|Full headers and payloads        |

By default, payloads are truncated to 1024 characters.  To display full payloads, pass the `log_full_body` named flag to the `Smartsheet::Client` with the value true:

```ruby
smartsheet = Smartsheet::Client.new(logger: logger, log_full_body: true)
```

### Retry Configuration

For additional customization, you can specify a `backoff_method` function.  This function is called with two arguments:

* The first accepts the index of the retry being attempted (0 for the first retry, 1 for the second, etc.)
* The second accepts the Error Object that caused the retry.

The function must return the number of seconds to wait before making the subsequent retry call, or the symbol `:stop` if no more retries should be made.

The default implementation performs exponential backoff with jitter.

### JSON Input and Output
* `json_output` - A flag indicating if data should be returned as a JSON string. 

    By default, the Ruby SDK converts the raw JSON API response (with camelCase properties) to a Ruby hash with snake_case properties. If you prefer to receive results as the original JSON string, initialize the client with `json_output: true`.

    Regardless of this setting, the SDK will accept `body` parameters as a hash or JSON, and in either camelCase or snake_case.

### Assume User

* `assume_user` - Allows an admin to act on behalf of, or impersonate, the user to make API calls. The email address should NOT be URI encoded.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests, with code coverage provided automatically by the Coveralls gem. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

If you would like to contribute a change to the SDK, please fork a branch and then submit a pull request.
[More info here.](https://help.github.com/articles/using-pull-requests)

## Support

If you have any questions or issues with this SDK please post on [Stack Overflow using the tag "smartsheet-api"](http://stackoverflow.com/questions/tagged/smartsheet-api) or contact us directly at api@smartsheet.com.

## Release Notes

Each specific release is available for download via [GitHub](https://github.com/smartsheet-platform/smartsheet-ruby-sdk/tags).

**v1.0.0 (Nov 2017)**
Full release

**v1.0.0.beta (October 2017)**
Beta release of the Smartsheet SDK for Ruby

*Note*: Minor changes that result in a patch version increment in RubyGems (such as updates to the README) will not be tagged as a Release in GitHub.
