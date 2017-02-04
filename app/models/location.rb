# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  district   :string
#  city       :string
#  region     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  validates :city, length: { minimum: 1, maximum: 20 },
                    presence: true, uniqueness: true
  has_many :items

end
