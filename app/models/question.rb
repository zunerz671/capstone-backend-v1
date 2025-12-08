class Question < ApplicationRecord
  belongs_to :assessment
  belongs_to :lesson
  has_many :question_responses, dependent: :destroy

  validates :title, presence: true
  validates :assessment, presence: true
  validates :image_url, presence: true
  validates :correct_answer, presence: true
end
