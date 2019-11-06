class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :value
      t.string :gender
      t.string :case
      t.boolean :definite

      t.timestamps
    end
  end
end
