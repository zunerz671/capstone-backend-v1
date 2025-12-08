class LessonPage < ApplicationRecord
  belongs_to :lesson

  validates :image_url, presence: true
end
