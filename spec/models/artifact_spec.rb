require 'rails_helper'

RSpec.describe Artifact, type: :model do
  describe "associations" do
    it { should belong_to(:project) }
    it { should belong_to(:creator).class_name("User") }
    it { should belong_to(:assignee).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe "factories" do
    it "has a valid factory" do
      artifact = build(:artifact)
      expect(artifact).to be_valid
    end
  end

  describe "custom behavior" do
    it "can not be created without an assignee" do
      artifact = build(:artifact, assignee: nil)
      expect(artifact).to be_invalid
    end
  end
end
