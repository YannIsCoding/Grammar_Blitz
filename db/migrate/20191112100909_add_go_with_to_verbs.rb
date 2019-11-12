class AddGoWithToVerbs < ActiveRecord::Migration[5.2]
  def change
    add_column :verbs, :go_with, :string, array: true
  end
end
