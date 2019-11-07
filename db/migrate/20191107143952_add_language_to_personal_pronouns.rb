class AddLanguageToPersonalPronouns < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_pronouns, :language, :string
  end
end
