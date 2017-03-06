# == Schema Information
#
# Table name: item_images
#
#  id                 :integer          not null, primary key
#  image_name         :string
#  item_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class ItemImage < ApplicationRecord
  belongs_to :item
  has_attached_file :image,
                    :styles => { :medium => "400x400>",
                                 :small  => "220x220#",
                                 :thumb  => "100x100#" }
  validates_attachment_content_type :image,
      :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
      :message => 'file type is not allowed (only jpeg/png/gif images)'
end
