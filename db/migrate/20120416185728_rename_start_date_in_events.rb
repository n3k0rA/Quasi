class RenameStartDateInEvents < ActiveRecord::Migration
  def up
    rename_column :events, :startDate, :start_date
  end

  def down
    rename_column :events, :start_date, :startDate
  end
end
