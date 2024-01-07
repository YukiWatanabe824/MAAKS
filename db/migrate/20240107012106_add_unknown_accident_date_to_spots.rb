class AddUnknownAccidentDateToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :unknown_accident_date, :boolean, default: false
  end
end
