require 'rails_helper'

RSpec.describe Organizations::SessionsController, type: :request do
  let(:organization) { Organization.create!(email: 'org@example.com', password: 'password123', subdomain: 'myorg') }

  describe 'POST /organizations/sign_in' do
    it 'signs in the organization and redirects to its subdomain' do
      post organization_session_path, params: {
        organization: {
          email: organization.email,
          password: 'password123'
        }
      }

      expect(response).to redirect_to(root_url(subdomain: organization.subdomain, host: "localhost", protocol: "http"))
      follow_redirect!
      expect(controller.current_organization).to eq(organization)
    end
  end

  describe 'DELETE /organizations/sign_out' do
    before do
      sign_in organization
    end

    it 'signs out the organization and redirects to root' do
      delete destroy_organization_session_path

      expect(response).to redirect_to(root_url(subdomain: nil, host: "localhost", protocol: "http"))
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end
