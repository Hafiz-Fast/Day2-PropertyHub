class AddBedroomsToProperties < ActiveRecord::Migration[8.1]
  def change
    add_column :properties, :bedrooms, :integer
  end
end
