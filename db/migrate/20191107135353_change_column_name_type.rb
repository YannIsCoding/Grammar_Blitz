class ChangeColumnNameType < ActiveRecord::Migration[5.2]
  def change
    rename_column :verbs, :type, :g_case
  end
end
