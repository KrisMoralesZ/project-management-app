require 'rails_helper'

RSpec.describe Users::InvitationsController, type: :request do
  let(:organization) {
    Organization.create!(
      organization_name: "OrgTest",
      subdomain: "org_test",
      email: "org_test@test.com",
      password: "password"
    )
  }
  let(:user) {
    User.create!(
      name: organization.organization_name,
      email: organization.email,
      password: "password",
      role: 0,
      organization_id: organization.id
    )
  }

  before do
    ActsAsTenant.current_tenant = organization
    sign_in user, scope: :user
  end

  describe "POST /users/invitation" do
    let(:valid_params) do
      {
        user: {
          email: "newuser@org.com",
          name: "New User",
          role: 1
        }
      }
    end

    # it "creates an invited user with same organization" do
    #   expect {
    #     post user_invitation_path, params: valid_params
    #   }.to change(User, :count).by(1)
    #
    #   user = User.last
    #   expect(user.email).to eq("newuser@org.com")
    #   expect(user.organization).to eq(inviter.organization)
    #   expect(user.invitation_token).not_to be_nil
    #   expect(response).to redirect_to(dashboard_path)
    # end
    #
    # it "handles invitation failure" do
    #   invalid_params = valid_params.deep_merge(user: { email: "" })
    #
    #   expect {
    #     post user_invitation_path, params: invalid_params
    #   }.not_to change(User, :count)
    #
    #   expect(response).to redirect_to(dashboard_path)
    #   follow_redirect!
    #   expect(response.body).to include("Something went grong") # typo in controller, maybe fix it
    # end
  end
end
