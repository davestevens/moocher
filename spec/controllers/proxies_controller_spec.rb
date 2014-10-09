require "rails_helper"
require "webmock/rspec"

describe ProxiesController do
  describe "#create" do
    it "makes a web request" do
      stub_request(:get, "http://example.com/path")

      post(:create, type: "GET", url: "http://example.com/path")

      expect(a_request(:get, "http://example.com/path")).to have_been_made
    end
  end
end
