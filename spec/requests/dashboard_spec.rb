require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  before do
    sign_in(create(:organization), scope: :organization)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
