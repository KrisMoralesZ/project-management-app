require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
