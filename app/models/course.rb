class Course < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: [100, 100]
  end
end
