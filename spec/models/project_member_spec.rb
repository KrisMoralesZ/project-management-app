require 'rails_helper'

RSpec.describe ProjectMember, type: :model do
  describe "associations" do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:user) }
  end

  describe "factories" do
    it "has a valid factory" do
      project_member = build(:project_member)
      expect(project_member).to be_valid
    end
  end
end
