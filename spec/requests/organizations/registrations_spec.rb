require 'rails_helper'

RSpec.describe Organizations::RegistrationsController, type: :request do
  describe 'POST /organizations' do
    let(:valid_params) do
      {
        organization: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          organization_name: 'TestOrg',
          subdomain: 'testorg'
        }
      }
    end

    it 'creates a new organization and a user, redirects to subdomain' do
      expect {
        post organization_registration_path, params: valid_params
      }.to change(Organization, :count).by(1)
                                       .and change(User, :count).by(1)

      org = Organization.last
      expect(response).to redirect_to(root_url(subdomain: org.subdomain))
      expect(flash[:notice]).to eq("Organization created successfully.")
    end

    it 'renders errors when invalid' do
      invalid_params = valid_params.deep_merge(organization: { email: '' })

      post organization_registration_path, params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("form")
    end
  end
end
