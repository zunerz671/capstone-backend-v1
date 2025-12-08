class QuestionResponse < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :assessment_attempt

  validates :response, presence: true
  validates :user, presence: true
  validates :question, presence: true
  validates :assessment_attempt, presence: true
end
