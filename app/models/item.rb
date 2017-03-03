# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  category_id :integer
#

class Item < ApplicationRecord
  belongs_to :user
  belongs_to :location
  #accepts_nested_attributes_for :location
  belongs_to :category

  has_many :item_images, dependent: :destroy
  #accepts_nested_attributes_for :item_images
  default_scope {order(:created_at => :desc)}
  scope :location_filter, -> (location_id) { where location_id: location_id }
  scope :category_filter, -> (category_id) { where category_id: category_id }

  has_many :relationships,
            foreign_key: "follower_id",
            dependent: :destroy,
            before_add: :check_following_limit
  has_many :followed_items, through: :relationships, source: :followed

  has_many :reverse_relationships,
            foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy,
            before_add: :check_followed_limit
  has_many :followers_items, through: :reverse_relationships, source: :follower

  #validates_length_of :reverse_relationships, maximum: 3
  #validate :followed_count_within_bounds

  validates :name, length: { minimum: 1, maximum: 50 }, presence: true
  validates :description, length: { minimum: 0, maximum: 300 }

  def following?(other_item)
    relationships.find_by_followed_id(other_item.id)
  end

  def follow!(other_item)
    relationships.create!(followed_id: other_item.id)
  end

  def unfollow!(other_item)
    relationships.find_by_followed_id(other_item.id).destroy
  end

  def image_list style
    list = []
    self.item_images.each do | image |
      list << image.image.url(style)
    end
    list
  end

  def check_following_limit relationship
    if self.relationships.count > 2
      errors.add(:relationships, message: 'you can just follow maximum 3 items')
      raise Exception.new 'you can just follow maximum 3 items'
    end
  end

  def check_followed_limit reverse_relationship
    if self.reverse_relationships.count > 2
      errors.add(:reverse_relationships, message: 'this item has been already followed by mazimum 3 items')
      raise Exception.new 'this item has been already followed by mazimum 3 items'
    end
  end
end
