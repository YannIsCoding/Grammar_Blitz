class AddLanguageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :language, :string
  end
end
