class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :admin, :string
  end
end
