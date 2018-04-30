class AddColumnAttachmentToCategory < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :categories, :cat_img
  end
end
