class RemovePhotoFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :photo, :string
  end
end
