class ChangeLanguageToEnglishInNouns < ActiveRecord::Migration[5.2]
  def change
    rename_column :nouns, :language, :english
  end
end
