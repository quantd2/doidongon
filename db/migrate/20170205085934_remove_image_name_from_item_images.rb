class RemoveImageNameFromItemImages < ActiveRecord::Migration[5.0]
  def change
    remove_column :item_images, :image_name, :string
  end
end
