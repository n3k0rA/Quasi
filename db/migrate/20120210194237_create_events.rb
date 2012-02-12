class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :sdate
      t.time :stime
      t.date :fdate
      t.time :ftime
      t.string :place
      t.string :town
      t.string :province
      t.decimal :price
      t.text :description
      t.string :email
      t.string :website
      t.string :phone

      t.timestamps
    end
  end
end
