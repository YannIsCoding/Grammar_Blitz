class AddVerbsToPrepositionsAsArray < ActiveRecord::Migration[5.2]
  def change
    add_column :prepositions, :verbs, :string, array: true
  end
end
