require "rails_helper"

describe HomeController do
  describe "#index" do
    it "renders :index template" do
      get(:index)

      expect(controller).to render_template(:index)
    end
  end
end
