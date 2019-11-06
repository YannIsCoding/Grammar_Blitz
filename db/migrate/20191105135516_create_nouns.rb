class CreateNouns < ActiveRecord::Migration[5.2]
  def change
    create_table :nouns do |t|
      t.string :value
      t.string :gender

      t.timestamps
    end
  end
end
