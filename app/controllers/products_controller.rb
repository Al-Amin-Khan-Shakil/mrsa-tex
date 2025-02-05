class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.includes(variant_names: :variant_values).friendly.find(params[:slug])
  end

  def new
    @product = Product.new
    @product.variant_names.build.variant_values.build
  end

  def create
    @product = Product.new(product_params)
    Rails.logger.debug(@product.inspect)
    puts "#{@product}"

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :category_id,
      :description,
      :price,
      :stock,
      images: [],
      variant_names_attributes: [:id, :name, :product_id, :_destroy,
                                 { variant_values_attributes: %i[id value price stock variant_name_id image _destroy] }]
    )
  end
end
