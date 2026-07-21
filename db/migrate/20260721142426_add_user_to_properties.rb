class AddUserToProperties < ActiveRecord::Migration[8.1]
  def change
    add_reference :properties, :user, foreign_key: true
  end
end
