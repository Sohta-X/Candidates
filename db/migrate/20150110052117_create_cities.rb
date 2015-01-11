class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :country_id, null: false
      t.string :title, null: false, default: ""

      t.timestamps
    end
    add_index :cities, :country_id
  end
end
