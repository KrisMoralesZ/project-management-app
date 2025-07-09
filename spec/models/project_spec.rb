require "rails_helper"

RSpec.describe Project, type: :model do
  let(:organization) { create(:organization) }

  it "is valid with valid attributes" do
    project = build(:project, organization: organization)
    expect(project).to be_valid
  end

  it "is invalid without a title" do
    project = build(:project, title: nil, organization: organization)
    expect(project).not_to be_valid
  end

  it "is invalid without details" do
    project = build(:project, details: nil, organization: organization)
    expect(project).not_to be_valid
  end

  it "is invalid without an expected_completion_date" do
    project = build(:project, expected_completion_date: nil, organization: organization)
    expect(project).not_to be_valid
  end

  it "belongs to an organization" do
    assoc = described_class.reflect_on_association(:organization)
    expect(assoc.macro).to eq(:belongs_to)
  end

  it "has many users through project_members" do
    assoc = described_class.reflect_on_association(:users)
    expect(assoc.macro).to eq(:has_many)
  end
end
