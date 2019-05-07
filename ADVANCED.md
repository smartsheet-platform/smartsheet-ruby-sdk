# Advanced Topics for the Smartsheet SDK for Ruby

## Event Reporting
The following sample demonstrates 'best' practices for enumerating events using the Smartsheet Event Reporting feature. All enumerations must begin using the since parameter to the `get` method. Specify 0 as an argument (i.e. since=0) if you wish to begin enumeration at the beginning of stored event history. A more common scenario would be to enumerate events over a certain time frame by providing an ISO 8601 formatted or numerical (UNIX epoch) date as an argument to `get`. In this sample, events for the previous 7 days are enumerated.

After the initial list of events is returned, you should only continue to enumerate events if the `moreAvailable` flag in the previous response indicates that more data is available. To continue the enumeration, supply an argument to the `stream_position` parameter to the `get` method (you must pass in a value for `since` or `stream_position` but never both). The `stream_position` argument can be retrieved from the `nextStreamPosition` attribute of the previous response.


Many events have additional information available as a part of the event. That information can be accessed from the `additionalDetails` attribute (Note that attributes of the `additionalDetails` object uses camelCase/JSON names, e.g. `sheetName` not `sheet_name`). An example is provided for `sheetName` below. Information about the additional details provided can be found [here](https://smartsheet-platform.github.io/api-docs/?ruby#event-reporting).

```Ruby
require 'smartsheet'
require 'date'

# Initialize the client - use your access token here
smartsheet_client = Smartsheet::Client.new(token: '1234')
# The `smartsheet_client` variable now contains access to all of the APIs

begin
  smartsheet_client.events.get()
  # The first call to the events reporting API
  # requires the since query parameter.
  # If you pass in an UNIX epoch date, numericDates must be true

  # Subsequent calls require the streamPosition property

  # This example is looking specifically for new sheet events
  # Find all created sheets

rescue Smartsheet::ApiError => e
  puts "Error Code: #{e.error_code}"
  puts "Message: #{e.message}"
  puts "Ref Id: #{e.ref_id}"
end
```