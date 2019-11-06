class CreateGermanPersonalPronouns < ActiveRecord::Migration[5.2]
  def change
    create_table :german_personal_pronouns do |t|
      t.string :value
      t.string :person
      t.string :case

      t.timestamps
    end
  end
end
