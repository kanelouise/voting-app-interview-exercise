class ChangeVotersPasswordToPasswordDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :voters, :password, :password_digest
  end
end
