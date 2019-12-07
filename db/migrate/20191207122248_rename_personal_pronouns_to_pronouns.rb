class RenamePersonalPronounsToPronouns < ActiveRecord::Migration[5.2]
  def change
    rename_table :personal_pronouns, :pronouns
  end
end
