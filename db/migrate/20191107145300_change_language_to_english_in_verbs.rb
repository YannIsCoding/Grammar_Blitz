class ChangeLanguageToEnglishInVerbs < ActiveRecord::Migration[5.2]
  def change
    rename_column :verbs, :language, :english
  end
end
