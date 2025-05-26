require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:users) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe 'Devise modules' do
    it 'includes validatable' do
      expect(Organization.devise_modules).to include(:validatable)
    end
  end
end
