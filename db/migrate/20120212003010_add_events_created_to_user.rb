class AddEventsCreatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :events_created, :string
  end
end
