class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.text    :body

      t.timestamps
    end
  end
end
