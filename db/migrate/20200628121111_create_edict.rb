class CreateEdict < ActiveRecord::Migration[5.2]
  def change
    create_table :edicts do |t|
      t.string :value
      t.string :english
      t.references :structure, foreign_key: true
    end
  end
end
