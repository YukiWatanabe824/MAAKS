class AddAddressToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :address, :string
  end
end
