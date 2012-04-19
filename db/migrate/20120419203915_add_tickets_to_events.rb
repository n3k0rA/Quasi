class AddTicketsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :tickets, :string
  end
end
