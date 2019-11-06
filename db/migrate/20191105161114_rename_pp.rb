class RenamePp < ActiveRecord::Migration[5.2]
  def change
   rename_table :german_personal_pronouns, :personal_pronouns
  end
end
