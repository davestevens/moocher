require "rails_helper"

describe "Root Path" do
  it "routes to home#index" do
    expected_route = { controller: "home", action: "index" }

    expect(get: root_path).to route_to(expected_route)
  end
end
