class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end
  validates :name, presence: true
  validates :image, presence: true, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"], size_range: 1..(5.megabytes) }
end
