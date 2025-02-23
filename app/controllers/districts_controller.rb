class DistrictsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_district, only: %i[show edit update destroy]

  def index
    @districts = District.all
  end

  def show; end

  def new
    @district = District.new
    @district.sub_districts.build
  end

  def create
    @district = District.new(district_params)

    if @district.save
      redirect_to @district, notice: 'District was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @district.update(district_params)
      redirect_to @district, notice: 'District was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @district.destroy
    redirect_to districts_path, notice: 'District was successfully deleted.'
  end

  private

  def set_district
    @district = District.includes(:sub_districts).find(params[:id])
  end

  def district_params
    params.require(:district).permit(:name, sub_districts_attributes: %i[id name district_id _destroy])
  end
end
