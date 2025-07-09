require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'POST /users' do
    let(:valid_params) do
      {
        user: {
          email: 'user@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          organization_name: 'Test Org',
          subdomain: 'testorg'
        }
      }
    end

    it 'creates a new organization and a user, redirects to subdomain' do
      expect {
        post user_registration_path, params: valid_params
      }.to change(User, :count).by(1).and change(Organization, :count).by(1)

      user = User.last
      org = Organization.last

      expect(user.organization).to eq(org)
      expect(user.email).to eq('user@example.com')
      expect(response).to redirect_to(root_url(subdomain: org.subdomain, host: "localhost", protocol: "http"))
    end

    it 'renders errors when user is invalid' do
      invalid_params = valid_params.deep_merge(user: { email: '' })

      post user_registration_path, params: invalid_params

      expect(response.body).to include("error") # customize based on your error view
      expect(User.count).to eq(0)
    end
  end
end
