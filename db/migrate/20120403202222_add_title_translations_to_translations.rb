class AddTitleTranslationsToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :title_es, :string
    add_column :translations, :title_eu, :string
    add_column :translations, :title_fr, :string
    add_column :translations, :title_en, :string
  end
end
