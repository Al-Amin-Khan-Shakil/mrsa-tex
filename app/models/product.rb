class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :category
  has_many :variant_names, dependent: :destroy

  has_many_attached :images

  accepts_nested_attributes_for :counties, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
