require 'rails_helper'

RSpec.describe "Songs", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/songs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
