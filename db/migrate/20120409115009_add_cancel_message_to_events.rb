class AddCancelMessageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cancel_message, :text
  end
end
