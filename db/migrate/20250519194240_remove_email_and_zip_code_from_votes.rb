class RemoveEmailAndZipCodeFromVotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :votes, :email, :string
    remove_column :votes, :zip_code, :string
  end
end
