class ChangeEventColumnInMicroposts < ActiveRecord::Migration
  def up
    rename_column :microposts, :event_id, :object_id
  end

  def down
  end
end
