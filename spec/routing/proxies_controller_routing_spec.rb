require "rails_helper"

describe ProxiesController do
  describe "Routing" do
    it "routes to #create" do
      expected_route = { controller: "proxies", action: "create" }

      expect(post: proxy_path).to route_to(expected_route)
    end
  end
end
