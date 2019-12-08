class AddGenderToPronouns < ActiveRecord::Migration[5.2]
  def change
    add_column :pronouns, :gender, :string
  end
end
