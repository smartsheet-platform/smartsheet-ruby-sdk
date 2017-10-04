require_relative '../../test_helper'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/endpoint_spec'
require 'smartsheet/api/request_spec'

describe Smartsheet::API::RequestSpec do
  it 'doesnt allow multiple file specs' do
    -> {Smartsheet::API::RequestSpec.new(
        file_options: {path: 'some/path', filename: 'fn', file: {}, file_length: 123}
    )}.must_raise ArgumentError
  end

  it 'doesnt allow partial file specs' do
    -> {Smartsheet::API::RequestSpec.new(
        file_options: {filename: 'fn', file_length: 123}
    )}.must_raise ArgumentError
  end

  it 'allows valid path file specs' do
    Smartsheet::API::RequestSpec.new(
        file_options: {path: 'some/path'}
    )
  end

  it 'allows valid obj file specs' do
    Smartsheet::API::RequestSpec.new(
        file_options: {filename: 'fn', file: {}, file_length: 123}
    )
  end

  it 'allows empty file specs' do
    Smartsheet::API::RequestSpec.new
  end
end
