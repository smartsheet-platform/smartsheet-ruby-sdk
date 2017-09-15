module Smartsheet
  module API
    # Methods for building Smartsheet API URLs
    module URLs
      API_URL = 'https://api.smartsheet.com/2.0'.freeze

      def build_url(*segments, context: {})
        segments
          .collect { |seg| seg.is_a?(Symbol) ? context[seg] : seg }
          .unshift(API_URL)
          .join '/'
      end
    end
  end
end