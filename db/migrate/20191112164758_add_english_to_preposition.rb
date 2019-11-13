class AddEnglishToPreposition < ActiveRecord::Migration[5.2]
  def change
    add_column :prepositions, :english, :string
  end
end
