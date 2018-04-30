class AddColumnImagesToArticles < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :articles, :img_art
  end
end
