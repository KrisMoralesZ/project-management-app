require 'rails_helper'

RSpec.describe Users::InvitationsController, type: :request do
  let(:organization) { Organization.create!(organization_name: "OrgTest", subdomain: "orgtest") }
  let(:inviter) do
    User.create!(
      email: "admin@orgtest.com",
      password: "password123",
      password_confirmation: "password123",
      name: "Admin User",
      role: "admin",
      organization: organization
    )
  end

  before do
    sign_in inviter
  end

  describe "POST /users/invitation" do
    let(:valid_params) do
      {
        user: {
          email: "newuser@org.com",
          name: "New User",
          role: "member"
        }
      }
    end

    it "creates an invited user with same organization" do
      expect {
        post user_invitation_path, params: valid_params
      }.to change(User, :count).by(1)

      user = User.last
      expect(user.email).to eq("newuser@org.com")
      expect(user.organization).to eq(inviter.organization)
      expect(user.invitation_token).not_to be_nil
      expect(response).to redirect_to(dashboard_path)
    end

    it "handles invitation failure" do
      invalid_params = valid_params.deep_merge(user: { email: "" })

      expect {
        post user_invitation_path, params: invalid_params
      }.not_to change(User, :count)

      expect(response).to redirect_to(dashboard_path)
      follow_redirect!
      expect(response.body).to include("Something went grong") # typo in controller, maybe fix it
    end
  end
end
