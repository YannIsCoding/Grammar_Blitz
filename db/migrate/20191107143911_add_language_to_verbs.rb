class AddLanguageToVerbs < ActiveRecord::Migration[5.2]
  def change
    add_column :verbs, :language, :string
  end
end
