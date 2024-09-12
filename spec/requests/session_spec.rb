require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /sign_in" do
    it "returns http success" do
      get "/session/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_up" do
    it "returns http success" do
      get "/session/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

end
