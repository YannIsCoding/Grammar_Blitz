class ChangeLanguageToEnglishInArticles < ActiveRecord::Migration[5.2]
  def change
  rename_column :articles, :language, :english
  end
end
