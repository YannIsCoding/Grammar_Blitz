class ChangeLanguageToEnglishInPersonPronouns < ActiveRecord::Migration[5.2]
  def change
  rename_column :personal_pronouns, :language, :english
  end
end
