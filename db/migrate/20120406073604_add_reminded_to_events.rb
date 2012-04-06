class AddRemindedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :reminded, :boolean, :default =>false
  end
end
