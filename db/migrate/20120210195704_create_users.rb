class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :town
      t.string :province
      t.string :website

      t.timestamps
    end
  end
end
