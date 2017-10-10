require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smartsheet/client'

require 'minitest/autorun'
require 'mocha/mini_test'

TOKEN = '0123456789'.freeze

module Smartsheet
  module Test
    def stub_sleep(obj)
      obj.stubs(:sleep).with do |time|
        Timecop.travel(Time.now + time)
      end
    end
  end
end