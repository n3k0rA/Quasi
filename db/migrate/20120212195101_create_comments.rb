class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :body
      t.references :event

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :event_id
  end
end
