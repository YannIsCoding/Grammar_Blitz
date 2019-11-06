class DropVerb < ActiveRecord::Migration[5.2]
  def change
    drop_table :verbs
  end
end
