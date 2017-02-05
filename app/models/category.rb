# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  validates :name, length: { minimum: 1, maximum: 30 },
                    presence: true, uniqueness: true
  has_many :items
end
