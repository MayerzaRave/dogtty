class Care < ApplicationRecord
  belongs_to :pet
  belongs_to :place, optional: true
end
