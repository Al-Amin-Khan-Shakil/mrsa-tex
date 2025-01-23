class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin, only: %i[show edit update destroy]

  def index
    @admins = Admin.all
  end

  def show; end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to @admin
    else
      flash.now[:alert] = @admin.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      flash[:notice] = "Account was successfully updated."
      redirect_to admin_path(@admin)
    else
      flash.now[:alert] = @admin.errors.full_messages.to_sentence.
      render :edit
    end
  end

  def destroy
    if @admin == current_admin
      flash[:alert] = 'You cannot delete your own account.'
    else
      @admin.destroy
      flash[notice] = 'Account was successfully deleted'
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = 'Account does not exist.'
    render action_name
  end

  def admin_params
    params.require(:admin).permit(:f_name, :l_name, :phone_number, :role, :gender, :email, :password, :password_confirmation)
  end
end
