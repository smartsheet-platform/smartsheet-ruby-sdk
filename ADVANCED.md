# Advanced Topics for the Smartsheet SDK for Ruby

## Event Reporting
The following sample demonstrates 'best' practices for enumerating events using the Smartsheet Event Reporting feature. All enumerations must begin using the since parameter to the `get` method. Specify 0 as an argument (i.e. since=0) if you wish to begin enumeration at the beginning of stored event history. A more common scenario would be to enumerate events over a certain time frame by providing an ISO 8601 formatted or numerical (UNIX epoch) date as an argument to `get`. In this sample, events for the previous 7 days are enumerated.

After the initial list of events is returned, you should only continue to enumerate events if the `more_available` flag in the previous response indicates that more data is available. To continue the enumeration, supply an argument to the `stream_position` parameter to the `get` method (you must pass in a value for `since` or `stream_position` but never both). The `stream_position` argument can be retrieved from the `next_stream_position` attribute of the previous response.

Many events have additional information available as a part of the event. That information can be accessed from the `additional_details` attribute. Information about the additional details provided can be found [here](https://smartsheet-platform.github.io/api-docs/?ruby#event-reporting).


```Ruby
require 'smartsheet'
require 'time'
require 'date'
require 'pp'

# Initialize the client - use your access token here
## TODO - remove token
$client = Smartsheet::Client.new(token: '1234')
# The `client` variable now contains access to all of the APIs

today = (DateTime.now)
date_week_ago = (today - 7).to_time.utc.iso8601 


def get_events(params)
    result = $client.events.get(params: params)
    # pp result
    print_new_sheet_events(result[:data])

    more_events_available = result[:more_available]
    next_stream_position = result[:next_stream_position]
    get_next_stream_of_events(more_events_available, next_stream_position)
end 

# Subsequent calls require the streamPosition property
def get_next_stream_of_events(more_events_available, next_stream_position)
    params = {
        stream_position: next_stream_position,
        max_count: 1
    }

    if more_events_available 
        get_events(params);
    end
end 

# This example is looking specifically for new sheet events
def print_new_sheet_events(data)
    data.each do |value|
        # Find all created sheets
        if value[:object_type] == "SHEET" && value[:action] == "CREATE"
            pp value
        end
        
    end
end 


begin
    params = {
        since: date_week_ago,
        max_count: 1
    }

    # The first call to the events reporting API
    # requires the since query parameter.
    # If you pass in an UNIX epoch date, numericDates must be true
    get_events(params)

rescue Smartsheet::ApiError => e
  puts "Error Code: #{e.error_code}"
  puts "Message: #{e.message}"
  puts "Ref Id: #{e.ref_id}"
end
```