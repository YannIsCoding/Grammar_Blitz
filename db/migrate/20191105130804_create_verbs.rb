class CreateVerbs < ActiveRecord::Migration[5.2]
  def change
    create_table :verbs do |t|
      t.string :value
      t.string :person
      t.string :preterit
      t.string :type

      t.timestamps
    end
  end
end
