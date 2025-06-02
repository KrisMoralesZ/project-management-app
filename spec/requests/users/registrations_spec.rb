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
          subdomain: 'testorg',
          organization_id: 1
        }
      }
    end

    it 'renders errors when user is invalid' do
      invalid_params = valid_params.deep_merge(user: { email: '' })

      post user_registration_path, params: invalid_params

      expect(response.body).to include("error")
      expect(User.count).to eq(0)
    end
  end
end
