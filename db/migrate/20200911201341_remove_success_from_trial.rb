class RemoveSuccessFromTrial < ActiveRecord::Migration[5.2]
  def change
    remove_column :trials, :success, :boolean
    add_column :trials, :result, :integer
  end
end
