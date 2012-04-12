class DropCategoriesAlarmTable < ActiveRecord::Migration
  def up
    drop_table :categories_alarms
  end

  def down
  end
end
