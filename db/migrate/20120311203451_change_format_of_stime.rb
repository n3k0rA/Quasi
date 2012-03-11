class ChangeFormatOfStime < ActiveRecord::Migration
  def up
    change_column :events, :stime, :datetime
  end

  def down
    change_column :events, :stime, :time
  end
end
