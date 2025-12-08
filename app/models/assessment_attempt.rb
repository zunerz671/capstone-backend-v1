class AssessmentAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :assessment
  has_many :question_responses, dependent: :destroy

  validates :user, presence: true
  validates :assessment, presence: true
end
