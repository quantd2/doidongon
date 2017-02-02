class Item < ApplicationRecord
  belongs_to :user
  belongs_to :location
  #accepts_nested_attributes_for :location
  belongs_to :category

  has_many :item_images, dependent: :delete_all
  #accepts_nested_attributes_for :item_images
  has_many :relationships,
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :followed_items,
    through: :relationships,
    source: :followed

  has_many :reverse_relationships,
    foreign_key: "followed_id",
    class_name: "Relationship",
    dependent: :destroy
  has_many :followers,
    through: :reverse_relationships,
    source: :follower

  validates :name, presence: true

  def following?(other_item)
    relationships.find_by_followed_id(other_item.id)
  end

  def follow!(other_item)
    relationships.create!(followed_id: other_item.id)
  end

  def unfollow!(other_item)
    relationships.find_by_followed_id(other_item.id).destroy
  end
end
