class ChangeNameSDateColumn < ActiveRecord::Migration
  def up
    rename_column :events, :stime, :startDate
  end

  def down
  end
end
