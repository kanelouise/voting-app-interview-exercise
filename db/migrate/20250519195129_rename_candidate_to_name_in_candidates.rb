class RenameCandidateToNameInCandidates < ActiveRecord::Migration[7.0]
  def change
    rename_column :candidates, :candidate, :name
  end
end
