class AddDescriptionsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :des_es, :text
    add_column :events, :des_eu, :text
    add_column :events, :des_en, :text
    add_column :events, :des_fr, :text
  end
end
