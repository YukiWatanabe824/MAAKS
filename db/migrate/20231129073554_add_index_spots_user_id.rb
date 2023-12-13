class AddIndexSpotsUserId < ActiveRecord::Migration[7.1]
  def change
    add_index :spots, :user_id
  end
end
