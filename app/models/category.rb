class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_category, class_name: 'Category', foreign_key: 'parent_id', optional: true

  has_one_attached :image

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  after_update :update_subcategory_slug, if: :saved_change_to_name?

  def slug_candidates
    parent_category ? ["#{parent_category.name}-#{name}"] : [name]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  private

  def update_subcategory_slug
    subcategories.find_each do |subcategory|
      subcategory.slug = nil
      subcategory.save!
    end
  end
end