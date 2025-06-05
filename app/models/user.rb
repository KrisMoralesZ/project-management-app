class User < ApplicationRecord
  belongs_to :organization
  acts_as_tenant(:organization)

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

  before_validation :assign_default_role, on: :create

  has_many :project_members
  has_many :projects, through: :project_members

  def is_admin?
    role == 0
  end

  def is_member?
    role == 1
  end

  private
  def assign_default_role
    return if role.present?

    if organization && organization.users.reload.count == 0
      self.role = 0
    else
      self.role = 1
    end
  end
end
