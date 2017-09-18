require 'minitest/autorun'
require_relative '../../../lib/smartsheet/api/urls'

module Smartsheet
  describe Smartsheet::API::URLs do
    before do
      @object = Object.new
      @object.extend(Smartsheet::API::URLs)
    end

    describe "#build_urls" do
      it "returns slash separated url" do
        @object.build_url(*["a", "b", "c"]).must_equal "https://api.smartsheet.com/2.0/a/b/c"
      end

      it "has correct base" do
        @object.build_url(*[]).must_equal "https://api.smartsheet.com/2.0"
      end

      it "handles symbols" do
        @object.build_url(*["a", :a_id, "b", :b_id], context: {a_id: 123, b_id: 234}).must_equal "https://api.smartsheet.com/2.0/a/123/b/234"
      end

      it "raises on missing symbol" do
        # TODO: This isn't great behavior. We should probably throw some sort of exception when the context is incomplete
        @object.build_url(*["a", :a_id, "b", :b_id], context: {a_id: 123}).must_equal "https://api.smartsheet.com/2.0/a/123/b/"
      end
    end
  end
end