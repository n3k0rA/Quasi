class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
    add_column :users, :persistence_token, :string
  end
end
