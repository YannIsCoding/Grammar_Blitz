class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.string :value
      t.string :english
      t.integer :word_indexes, array: true
      t.references :user
      t.references :exercice

      t.timestamps
    end
  end
end
