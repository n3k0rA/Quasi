class ChangeFormatOfFinishDate < ActiveRecord::Migration
  def up
    change_column :events, :finishDate, :datetime
  end

  def down
    change_column :events, :finishDate, :time
    
  end
end
