class RemoveEventsCreatedFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :events_created
  end

  def down
    add_column :users, :events_created, :string
  end
end
