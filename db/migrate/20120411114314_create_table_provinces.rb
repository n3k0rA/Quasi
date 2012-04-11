class CreateTableProvinces < ActiveRecord::Migration
  def up
    create_table :provinces do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :provinces
  end
end
