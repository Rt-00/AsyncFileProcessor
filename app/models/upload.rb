class Upload < ApplicationRecord
  has_one_attached :file

  validates :filename, presence: true
end
