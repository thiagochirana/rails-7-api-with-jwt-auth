require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /sign_up" do
    it "returns http success" do
      get "/registration/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update_user" do
    it "returns http success" do
      get "/registration/update_user"
      expect(response).to have_http_status(:success)
    end
  end

end
