class CreateCandidateType < ActiveRecord::Migration
  def change
    create_table :candidate_types do |t|
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
