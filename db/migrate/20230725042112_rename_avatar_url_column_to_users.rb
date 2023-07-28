class RenameAvatarUrlColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :avatar_url, :avatar
  end
end
