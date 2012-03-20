class RemoveSdateAndFdateFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :sdate
    remove_column :events, :fdate
  end

  def down
    add_column :events, :sdate
    add_column :events, :fdate
  end
end
