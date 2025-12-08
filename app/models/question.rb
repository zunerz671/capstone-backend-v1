class Question < ApplicationRecord
  belongs_to :assessment
  belongs_to :lesson
end
