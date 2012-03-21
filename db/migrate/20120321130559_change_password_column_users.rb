class ChangePasswordColumnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :password, :crypted_password
  end

  def down
    rename_column :users, :crypted_password, :password
  end
end
