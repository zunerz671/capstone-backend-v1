class Assessment < ApplicationRecord
  belongs_to :lesson
  has_many :questions, dependent: :destroy
  has_many :assessment_attempts, dependent: :destroy

  validates :title, presence: true
  validates :lesson, presence: true
end
