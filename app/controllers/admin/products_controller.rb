class Admin::ProductsController < ApplicationController
  before_action :set_admin_product, only: %i[show edit update destroy]

  def index
    @admin_products = Product.all
  end

  def show; end

  def new
    @admin_product = Product.new
  end

  def edit; end

  def create
    @admin_product = Product.new(admin_product_params)

    if @admin_product.save
      redirect_to admin_product_path(@admin_product.id), notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin_product.update(admin_product_params)
      redirect_to admin_product_path(@admin_product.id), notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_product.destroy!
    redirect_to admin_products_path, status: :see_other, notice: 'Product was successfully destroyed.'
  end

  private

  def set_admin_product
    @admin_product = Product.find_by!(id: params[:id])
  end

  def admin_product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :active)
  end
end
