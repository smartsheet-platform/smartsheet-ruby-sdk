# Advanced Topics for the Smartsheet SDK for Ruby

## Event Reporting
The following sample demonstrates best practices for consuming the event stream returned from the Smartsheet Event Reporting feature. 

The sample uses the `smartsheet_client.events.get` method to request lists of events from the stream. The first request sets the `since` parameter with the point in time (i.e. event occurrence datetime) in the stream from which to start consuming events. The `since` parameter can be set with a datetime value that is either formatted as ISO 8601 (e.g. 2010-01-01T00:00:00Z) or as UNIX epoch (in which case the `numeric_dates` parameter must also be set to `True`. By default the `numeric_dates` parameter is set to `False`).

To consume the next list of events after the initial list of events is returned, set the `stream_position` parameter with the `next_stream_position` attribute obtained from the previous request and don't set the `since` parameter with any values. This is because when using the `get` method, either the `since` parameter or the `stream_position` parameter should be set, but never both. 

Note that the `more_available` attribute in a response indicates whether more events are immediately available for consumption. If events aren't immediately available, they may still be generating so subsequent requests should keep using the same `stream_position` value until the next list of events is retrieved.

Many events have additional information available as a part of the event. That information can be accessed from the data stored in the `additional_details` attribute. Information about the additional details provided can be found [here](https://smartsheet-platform.github.io/api-docs/?ruby#event-reporting).


```Ruby
require 'smartsheet'
require 'time'
require 'date'
require 'pp'

# Initialize the client - use your access token here
$smartsheet_client = Smartsheet::Client.new(token: 'JKlMNOpQ12RStUVwxYZAbcde3F5g6hijklM789')
# The `client` variable now contains access to all of the APIs

today = (DateTime.now)
date_week_ago = (today - 7).to_time.utc.iso8601 


def get_events(params)
    result = $smartsheet_client.events.get(params: params)
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