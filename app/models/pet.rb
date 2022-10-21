class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :cares, dependent: :destroy
  has_many :deseases, dependent: :destroy
end
