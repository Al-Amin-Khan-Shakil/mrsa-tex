class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destory]
  before_action :set_parent_category, only: %i[new create index]

  def index
    @categories = if @parent_category
                    @parent_category.subcategories
                  else
                    Category.where(parent_id: nil)
                  end
  end

  def show
  end

  def new
    @category = @parent_category ? @parent_category.subcategories.new : Category.new
  end

  def create
    @category = @parent_category ? @parent_category.subcategories.new(category_params)

    if @category.save
      flash[:notice] = 'Category created successfully.'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category update successfully.'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category deleted successfully.'
      redirect_to categories_path, notice: 'Category deleted successfully.'
    else
      flash.now[:alert] = 'Failed to delete category.'
      render :show
    end
  end

  private

  def set_category
    @category = Category.friendly.find(params[:slug])
  end

  def set_parent_category
    return unless params[:category_slug]

    @parent_category = Category.friendly.find(params[:category_slug])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
