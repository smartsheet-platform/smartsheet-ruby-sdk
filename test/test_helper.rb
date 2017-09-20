require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smartsheet/smartsheet_client'

require 'minitest/autorun'
require 'mocha/mini_test'
