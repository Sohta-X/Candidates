class CreateCandidateProgresses < ActiveRecord::Migration
  def change
    create_table :candidate_progresses do |t|
      t.integer :candidate_id
      t.datetime :sent_at
      t.datetime :replied_at
      t.datetime :meeting_at

      t.timestamps
    end
    add_index :candidate_progresses, :candidate_id
  end
end
