class Item < ApplicationRecord
  belongs_to :user
  belongs_to :location
  #accepts_nested_attributes_for :location
  belongs_to :category

  has_many :item_images, dependent: :delete_all
  #accepts_nested_attributes_for :item_images
  has_many :follower_item, :class_name => 'Item', foreign_key: 'follower_id'
  has_many :interesting_item, :class_name => 'Item', foreign_key: 'interesting_id'

  validates :name, presence: true
end
