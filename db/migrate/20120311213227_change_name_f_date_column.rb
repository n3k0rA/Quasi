class ChangeNameFDateColumn < ActiveRecord::Migration
  def up
     rename_column :events, :ftime, :finishDate
  end

  def down
  end
end
