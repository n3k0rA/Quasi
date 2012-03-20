class RemoveCreatedByFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :created_by
  end

  def down
    add_column :events, :created_by, :string
  end
end
