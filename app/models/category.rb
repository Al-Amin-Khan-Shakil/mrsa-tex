class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_category, class_name: 'Category', foreign_key: 'parent_id', optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  def slug_candidates
    parent_category ? ["#{parent_category.name}-#{name}"] : [name]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
