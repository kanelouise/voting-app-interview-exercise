class Voter < ApplicationRecord
  has_secure_password validations: false
  
  has_one :vote
  belongs_to :write_in_candidate, class_name: "Candidate", optional: true

  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :zip_code, presence: true
end
