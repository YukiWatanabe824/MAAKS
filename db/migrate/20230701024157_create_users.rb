class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :uid
      t.string :password
      t.string :avatar_url

      t.timestamps
    end
  end
end
