class AddAttemptsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attempts, :integer, :default=>"0"
  end
end
