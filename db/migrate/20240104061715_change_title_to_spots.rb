class ChangeTitleToSpots < ActiveRecord::Migration[7.1]
  def change
    change_column_null :spots, :title, true
  end
end
