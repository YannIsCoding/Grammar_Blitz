class AddKindNounsToPrepositions < ActiveRecord::Migration[5.2]
  def change
    add_column :prepositions, :kind_nouns, :string, array: true
  end
end
