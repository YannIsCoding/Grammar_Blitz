class ChangeCaseColumnArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :case, :g_case
  end
end
