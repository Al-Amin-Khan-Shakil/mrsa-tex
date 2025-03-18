json.extract! admin_product, :id, :name, :slug, :description, :price, :stock, :category_id, :active, :created_at,
              :updated_at
json.url admin_product_url(admin_product, format: :json)
