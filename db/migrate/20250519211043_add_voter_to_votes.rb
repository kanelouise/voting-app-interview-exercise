class AddVoterToVotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :votes, :voter, null: false, foreign_key: true
  end
end
