class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name, null: false, default: ''
      t.integer :country_id
      t.integer :city_id
      t.integer :kind
      t.string :personal_url
      t.integer :phone
      t.string :email
      t.string :image
      t.string :status
      t.string :probability, null: false, default: 0

      t.timestamps
    end
    add_index :candidates, [:country_id, :city_id]
  end
end
