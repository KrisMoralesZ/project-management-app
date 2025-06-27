class Organization < ApplicationRecord
  has_many :users
  has_many :projects
  has_one :owner, -> { where(role: 0) }, class_name: "User"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
