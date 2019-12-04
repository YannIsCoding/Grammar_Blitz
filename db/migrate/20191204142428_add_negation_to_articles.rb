class AddNegationToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :negation, :boolean
  end
end
