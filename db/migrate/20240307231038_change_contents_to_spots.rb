class ChangeContentsToSpots < ActiveRecord::Migration[7.1]
  def change
    change_column_null :spots, :contents, true
  end
end
