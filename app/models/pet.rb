class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :cares
end
