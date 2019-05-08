# Smartsheet Ruby SDK [![Build Status](https://travis-ci.org/smartsheet-platform/smartsheet-ruby-sdk.svg?branch=master)](https://travis-ci.org/smartsheet-platform/smartsheet-ruby-sdk) [![Coverage Status](https://coveralls.io/repos/github/smartsheet-platform/smartsheet-ruby-sdk/badge.svg?branch=master)](https://coveralls.io/github/smartsheet-platform/smartsheet-ruby-sdk?branch=master) [![Gem Version](https://badge.fury.io/rb/smartsheet.svg)](https://badge.fury.io/rb/smartsheet)

This is an SDK to simplify connecting to the [Smartsheet API](http://www.smartsheet.com/developers/api-documentation) from Ruby applications.

## System Requirements

The SDK supports Ruby versions 2.2 or later.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smartsheet', '>= 1.3.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartsheet

## Documentation

The Smartsheet API documentation with corresponding SDK example code can be found [here](http://www.smartsheet.com/developers/api-documentation).

The generated SDK RubyDoc is available [here](http://www.rubydoc.info/gems/smartsheet/Smartsheet).

## Example Usage

To call the API, you must have an access token, which looks something like this example: `ll352u9jujauoqz4gstvsae05`. You can find the access token in the UI at Account > Personal Settings > API Access.

The following is a brief sample that shows you how to:

* Initialize the client
* List all sheets
* Load one sheet

```ruby
require 'smartsheet'

# Initialize the client - use your access token here
smartsheet_client = Smartsheet::Client.new(token: 'll352u9jujauoqz4gstvsae05')
# The `smartsheet_client` variable now contains access to all of the APIs

begin
  # List all sheets
  sheets = smartsheet_client.sheets.list

  # Select first sheet
  sheet_id = sheets[:data][0][:id]

  # Load the entire sheet
  puts "Loading sheet id #{sheet_id}"
  sheet = smartsheet_client.sheets.get(sheet_id: sheet_id)
  puts "Loaded #{sheet[:total_row_count]} rows from sheet '#{sheet[:name]}'"

rescue Smartsheet::ApiError => e
  puts "Error Code: #{e.error_code}"
  puts "Message: #{e.message}"
  puts "Ref Id: #{e.ref_id}"
end
```

See the [read-write-sheet](https://github.com/smartsheet-samples/ruby-read-write-sheet) example to see a more robust use case in action.

## Conventions

Each endpoint may take a number of keyword arguments, including the special keyword argument `body` for requests that accept a request body. Smartsheet's API Ruby documentation provides the parameters expected for each endpoint.

Each endpoint also provides two optional keyword arguments:

* `params` - This option is common for specifying enhancements or additional features for an API call. It specifies the query string for the call's URL.

  This must be a hash of URL query string fields to their values. For example, to make a call with the query string `?include=comments&includeAll=true`, an API call would look like the following:

  ```ruby
  ...get( ..., params: {include: 'comments', includeAll: true})
  ```

* `header_overrides` - This option is less frequently used, as it overrides the HTTP headers sent by API calls on an individual basis. _Use with caution_, as some headers are required to allow the SDK to function properly.
  
  This must be a hash of headers to override values. For example, to make a call with a modified `Assume-User` header set to `jane.doe@smartsheet.com`, an API call would look like the following:

  ```ruby
  ...get( ..., header_overrides: {'Assume-User' => 'jane.doe@smartsheet.com'})
  ```

## Basic Configuration

When creating the client object, pass an object with any of the following properties to tune its behavior.

* `token` - Your smartsheet API access token. If you omit this property (or pass an empty string) then the access token will be read from the system environment variable `SMARTSHEET_ACCESS_TOKEN`.

* `max_retry_time` - The maximum time in seconds to retry intermittent errors. (Defaults to 15 seconds.)

* `base_url` - By default, the SDK connects to the production API URL. Provide a custom base URL to connect to other environments. For example, to access SmartsheetGov, the `base_url` will be `https://api.smartsheetgov.com/2.0`.
  * To access Smartsheetgov, you will need to specify the Smartsheetgov API URI, `https://api.smartsheetgov.com/2.0/`, as the `base_url` during creation of the Smartsheet client object. The Smartsheetgov URI is defined as a constant (`GOV_API_URL`).


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

### User Agent

* `user_agent` - A custom app name to add to the user agent header; this helps Smartsheet diagnose any issues you may have while using the SDK.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Running the Tests
#### All
1. Run `rake test`. Note, the mock API tests will fail unless the mock server is running. See [Mock API Tests](#mock-api-tests)

#### Unit Tests
1. Run `rake test:units`

#### Mock API Tests
1. Clone the [Smartsheet SDK tests](https://github.com/smartsheet-platform/smartsheet-sdk-tests) repo and follow the instructions from the README to start the mock server
2. Run `rake test:mock_api`

## Passthrough Option

If there is an API Feature that is not yet supported by the Ruby SDK, there is a passthrough option that allows you to call arbitrary API endpoints.

To invoke the passthrough, your code can call one of the following three methods:

`response = smartsheet.request(method:, url_path:, body:, params:, header_overrides:)`

`response = smartsheet.request_with_file(method:, url_path:, file:, file_length:, filename:, content_type:, params:, header_overrides:)`

`response = smartsheet.request_with_file_from_path(method:, url_path:, path:, filename:, content_type:, params:, header_overrides:)`

* `method`: The method to invoke, one of `:get`, `:post`, `:put`, or `:delete`
* `url_path`: The specific API endpoint you wish to invoke. The client object base URL gets prepended to the caller’s endpoint URL argument.
* `body`: An optional hash of data to be passed as a JSON request body
* `file`: An opened `File` object to read as the request body, generally for file attachment endpoints
* `path`: The path of a file to be read as the request body, generally for file attachment endpoints
* `file_length`: The length of a file body in octets
* `filename`: The name of a file body
* `content_type`: The MIME type of a file body
* `params`: An optional hash of query parameters
* `header_overrides`: An optional hash of HTTP header overrides

All calls to passthrough methods return a JSON result, converted to a hash using symbol keys, in the same manner as the rest of the SDK. For example, after a `PUT` operation, the API's result message could be contained in `response[:message]`. If you prefer raw JSON instead of a hash, create a client with `json_output` configured; see client documentation above for more info.

### Passthrough Example

The following example shows how to POST data to `https://api.smartsheet.com/2.0/sheets` using the passthrough method and a hash:

```ruby
payload = {
  name: 'my new sheet',
  columns: [
    {
      title: 'Favorite',
      type: 'CHECKBOX',
      symbol: 'STAR'
    },
    {
      title: 'Primary Column',
      primary: true,
      type: 'TEXT_NUMBER'
    }
  ]
}

response = smartsheet.request(
  method: :post,
  url_path: 'sheets',
  body: payload
)
```

## Advanced Topics
For details about more advanced features, see [Advanced Topics](ADVANCED.md).

## Contributing

If you would like to contribute a change to the SDK, please fork a branch and then submit a pull request.
[More info here.](https://help.github.com/articles/using-pull-requests)

## Support

If you have any questions or issues with this SDK please post on [Stack Overflow using the tag "smartsheet-api"](http://stackoverflow.com/questions/tagged/smartsheet-api) or contact us directly at api@smartsheet.com.

## Release Notes

Each specific release is available for download via [GitHub](https://github.com/smartsheet-platform/smartsheet-ruby-sdk/tags). Detailed release notes are available in [CHANGELOG.md].

*Note*: Minor changes that result in a patch version increment in RubyGems (such as updates to the README) will not be tagged as a Release in GitHub.
