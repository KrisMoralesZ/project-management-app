require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:organization) }

  it { should validate_presence_of(:role) }

  describe '#is_admin?' do
    it 'returns true when role is admin (0)' do
      user = described_class.new(role: 0)
      expect(user.is_admin?).to be(true)
    end

    it 'returns false when role is member (1)' do
      user = described_class.new(role: 1)
      expect(user.is_admin?).to be(false)
    end
  end

  describe 'before_validation :assign_default_role' do
    let(:organization) { create(:organization) }

    it 'assigns admin if it is the first user in the organization' do
      user = User.new(email: 'admin@example.com', password: 'password', organization: organization)
      user.valid?
      expect(user.role).to eq(0)
    end

    it 'assigns member if not the first user' do
      create(:user, organization: organization, role: 1)
      user = User.new(email: 'member@example.com', password: 'password', organization: organization)
      user.valid?
      expect(user.role).to eq(1)
    end
  end
end
