class District < ApplicationRecord
  has_many :sub_districts, dependent: :destroy
  accepts_nested_attributes_for :sub_districts, allow_destroy: true

  validates :name, presence: true
end
