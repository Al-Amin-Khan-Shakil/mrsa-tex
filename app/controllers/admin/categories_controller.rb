class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_parent_category, only: %i[new create index]

   def index
    @admin_categories = if @parent_category
                          @parent_category.subcategories
                        else
                          Category.where(parent_id: nil)
                        end
  end

  def show
  end

  def new
    @admin_category =  @parent_category ? @parent_category.subcategories.new : Category.new
  end

  def edit
  end

  def create
    @admin_category = @parent_category ? @parent_category.subcategories.new(admin_category_params) : Category.new(admin_category_params)

    if @admin_category.save
      redirect_to admin_category_path(@admin_category.id), notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin_category.update(admin_category_params)
      redirect_to admin_category_path(@admin_category.id), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_category.destroy!
    redirect_to admin_categories_path, status: :see_other, notice: "Category was successfully destroyed."
  end

  private
    def set_category
      @admin_category = Category.find_by!(id: params[:id])
    end

    def set_parent_category
      return unless params[:category_id]

      @parent_category =  Category.find_by!(id: params[:category_id])
    end

    def admin_category_params
      params.require(:category).permit(:name, :image, :parent_id)
    end
end
