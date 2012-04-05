class CreateAlarmsTable < ActiveRecord::Migration
  def up
    create_table :alarms do |t|
      t.integer   :user_id
      t.boolean   :active, :default=>true
      t.string    :title
      t.string    :keyword
      t.string    :where
      t.timestamps
    end
  end

  def down
    drop_table :alarms
  end
end
