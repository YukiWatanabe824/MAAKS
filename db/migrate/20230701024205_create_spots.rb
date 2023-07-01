class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :title, null: false
      t.string :type, null: false
      t.text :contents, null: false
      t.date :date, null: false
      t.string :longitude, null: false
      t.string :latitude, null: false

      t.timestamps
    end

    add_column :spots, :user_id, :integer, null: false
    add_foreign_key :spots, :users
  end
end
