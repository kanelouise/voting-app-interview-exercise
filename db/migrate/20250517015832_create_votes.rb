class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.string :email
      t.string :zip_code
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
