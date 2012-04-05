class CreateTableCategoriesAlarms < ActiveRecord::Migration
  def up
    create_table "categories_alarms", :id => false do |t|
      t.integer  "category_id"
      t.integer  "alarm_id"
    end
  end

  def down
    drop_table :categories_alarms
  end
end
