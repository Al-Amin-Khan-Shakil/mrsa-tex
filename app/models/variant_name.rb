class VariantName < ApplicationRecord
  extend FriendlyId
  friendly_id :variant_name_slug_candidates, use: :slugged

  belongs_to :product
  has_many :variant_values, dependent: :destroy

  accepts_nested_attributes_for :variant_values, allow_destroy: true
  validates :name, presence: true

  def variant_name_slug_candidates
    ["#{product.name}-#{name}"]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
