class User < ApplicationRecord
  has_secure_password
  has_many :question_responses, dependent: :destroy
  has_many :assessment_attempts, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[student admin] }
end
