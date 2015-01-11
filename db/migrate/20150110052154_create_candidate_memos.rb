class CreateCandidateMemos < ActiveRecord::Migration
  def change
    create_table :candidate_memos do |t|
      t.integer :candidate_id, null: false
      t.string :name
      t.text :memo

      t.timestamps
    end
    add_index :candidate_memos, :candidate_id
  end
end
