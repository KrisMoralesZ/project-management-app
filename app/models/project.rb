class Project < ApplicationRecord
  belongs_to :organization

  has_many :artifacts
  has_many :project_members
  has_many :users, through: :project_members

  validates :title, presence: true
  validates :details, presence: true
  validates :expected_completion_date, presence: true
end
