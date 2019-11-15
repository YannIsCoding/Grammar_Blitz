class ChangeCaseColumnPersonPronouns < ActiveRecord::Migration[5.2]
  def change
    rename_column :personal_pronouns, :case, :g_case
  end
end
