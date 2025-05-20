class AddGuardrailsToVoters < ActiveRecord::Migration[7.0]
  def change
    #email cannot be null
    change_column_null :voters, :email, false 
    add_index :voters, :email, unique: true

    add_reference :voters, :write_in_candidate, foreign_key: { to_table: :candidates}
  end
end
