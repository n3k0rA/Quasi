class AddBannedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :banned, :boolean
  end
end
