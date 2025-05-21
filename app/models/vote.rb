class Vote < ApplicationRecord
  belongs_to :voter
  belongs_to :candidate

  validates :voter_id, uniqueness: { message: "You've already voted"}
end
