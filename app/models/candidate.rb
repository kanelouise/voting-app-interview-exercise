class Candidate < ApplicationRecord
  has_many :votes

  validates :names, presence: true, uniqueness: { case_sensitive: false}
end
