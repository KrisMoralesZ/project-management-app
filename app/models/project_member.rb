class ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :project, presence: true
  validates :user, presence: true
end
