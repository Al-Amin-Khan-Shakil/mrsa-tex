class VariantValue < ApplicationRecord
  extend FriendlyId
  friendly_id :variant_value_slug_candidates, use: :slugged

  belongs_to :variant_name
  has_one :product, through: :variant_name

  has_one_attached :image

  validates :value, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def variant_value_slug_candidates
    if variant_name&.product
      ["#{variant_name.product.name}-#{variant_name.name}-#{value}"]
    else
      ["#{variant_name&.name}-#{value}"]
    end
  end

  def should_generate_new_friendly_id
    name_changed? || super
  end
end
