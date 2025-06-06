class Artifact < ApplicationRecord
  belongs_to :project
  attr_accessor :upload
  MAX_FILE_SIZE = 10.megabytes

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILESIZE}") unless upload.size <= self.class::MAX_FILESIZE
    end
  end
end
