class Project < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true
  validates :details, presence: true
  validates :expected_completion_date, presence: true
end
