class QuestionResponse < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :assessment_attempt
end
