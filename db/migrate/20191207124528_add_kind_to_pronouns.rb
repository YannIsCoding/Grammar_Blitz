class AddKindToPronouns < ActiveRecord::Migration[5.2]
  def change
    add_column :pronouns, :kind, :string
  end
end
