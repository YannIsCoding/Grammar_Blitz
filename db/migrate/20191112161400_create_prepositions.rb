class CreatePrepositions < ActiveRecord::Migration[5.2]
  def change
    create_table :prepositions do |t|
      t.string :value
      t.string :g_case

      t.timestamps
    end
  end
end
