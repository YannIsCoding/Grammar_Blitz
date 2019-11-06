class DropGpp < ActiveRecord::Migration[5.2]
  def change
    drop_table :german_personal_pronouns
  end
end
