class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :title, null: false
      t.string :accident_type, null: false
      t.text :contents, null: false
      t.date :accident_date, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false

      t.timestamps
    end

    add_column :spots, :user_id, :integer, null: false
    add_foreign_key :spots, :users
  end
end
