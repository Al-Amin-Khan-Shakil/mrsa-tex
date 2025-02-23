class SubDistrict < ApplicationRecord
  belongs_to :District

  validates :name, presence: true
end
