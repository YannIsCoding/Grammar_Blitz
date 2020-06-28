class AddEdictedToStructures < ActiveRecord::Migration[5.2]
  def change
    add_column :structures, :edicted, :boolean
  end
end
