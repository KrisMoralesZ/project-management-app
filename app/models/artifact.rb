class Artifact < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :attachment

  validates :name, presence: true
  validates :description, presence: true
  attr_accessor :upload
  MAX_FILE_SIZE = 10.megabytes

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILE_SIZE}") unless upload.size <= self.class::MAX_FILE_SIZE
    end
  end
end
