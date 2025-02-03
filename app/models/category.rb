class Category < ApplicationRecord
  extent FriendlyID
  friendly_id :name, use: :slugged

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_category, class_name: 'Category', optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
