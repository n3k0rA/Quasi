class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :user_id
      t.integer :event_id
      t.text    :des_es
      t.text    :des_eu
      t.text    :des_fr
      t.text    :des_en
      t.text    :comment

      t.timestamps
    end
  end
end
