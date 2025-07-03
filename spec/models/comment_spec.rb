require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }

    it "is invalid if the content is too short" do
      comment = build(:comment, content: "")
      expect(comment).not_to be_valid
    end

    it "is valid with a proper content" do
      comment = build(:comment, content: "This is a valid comment.")
      expect(comment).to be_valid
    end
  end

  describe "factories" do
    it "has a valid factory" do
      expect(build(:comment)).to be_valid
    end
  end
end
