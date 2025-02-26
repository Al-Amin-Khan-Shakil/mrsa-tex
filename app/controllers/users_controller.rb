class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @users = User.new
  end

  def create
    @users = User.new(admin_params)

    if @user.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(admin_params)
      flash[:notice] = 'Account was successfully updated.'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @user == current_admin
      flash[:alert] = 'You cannot delete your own account.'
    else
      @user.destroy
      flash[:notice] = 'Account was successfully deleted'
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = 'Account does not exist.'
    render action_name
  end

  def admin_params
    params.require(:user).permit(:f_name, :l_name, :phone_number, :role, :profile_picture, :gender, :email, :password,
                                  :password_confirmation)
  end
end
