class RenameFinishDateInEvents < ActiveRecord::Migration
  def up
    rename_column :events, :finishDate, :finish_date
  end

  def down
    rename_column :events, :finish_date, :finishDate
  end
end
