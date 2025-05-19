class CreateVoters < ActiveRecord::Migration[7.0]
  def change
    create_table :voters do |t|
      t.string :email, null: false
      t.string :password
      t.string :zip_code

      t.timestamps
    end
  end
end
