class RenameColumnsPicInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :pic_file_name, :photo_file_name
    rename_column :users, :pic_content_type, :photo_content_type
    rename_column :users, :pic_file_size, :photo_file_size
    rename_column :users, :pic_updated_at, :photo_updated_at
  end

  def down
  end
end
