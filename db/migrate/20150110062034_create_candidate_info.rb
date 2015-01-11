class CreateCandidateInfo < ActiveRecord::Migration
  def change
    create_table :candidate_details do |t|
      t.integer :candidate_id
      t.integer :kind
      t.string :sns_link

      t.timestamps
    end
    add_index :candidate_details, :candidate_id
  end
end
