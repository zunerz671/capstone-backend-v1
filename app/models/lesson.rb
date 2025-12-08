class Lesson < ApplicationRecord
  has_many :lesson_pages, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_many :questions, through: :assessments
  validates :title, presence: true
end
