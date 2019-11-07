class AddLanguageToNouns < ActiveRecord::Migration[5.2]
  def change
    add_column :nouns, :language, :string
  end
end
