class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
    :message => 'file type is not allowed (only jpeg/png/gif images)'

  has_many :items, dependent: :destroy
end
