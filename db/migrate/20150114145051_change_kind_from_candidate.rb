class ChangeKindFromCandidate < ActiveRecord::Migration
  def up
    rename_column :candidates, :kind, :candidate_type_id
  end

  def down
    rename_column :candidates, :candidate_type_id, :kind
  end
end
