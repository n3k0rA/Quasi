class AddTitleTranslationsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title_es, :string
    add_column :events, :title_eu, :string
    add_column :events, :title_fr, :string
    add_column :events, :title_en, :string
  end
end
