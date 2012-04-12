class CreateAlarmsCategoriesTable < ActiveRecord::Migration
  def up
    create_table "alarms_categories", :id => false do |t|
      t.integer  "alarm_id"
      t.integer  "category_id"
    end
  end

  def down
    drop_table :alarms_categories
  end
end
