class CreateVerbNounLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :verb_noun_links do |t|
      t.references :noun, foreign_key: true
      t.references :verb, foreign_key: true

      t.timestamps
    end
  end
end
