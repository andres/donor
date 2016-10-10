class UsersController < ApplicationController
  def index
    @users = User.by_name
  end

  def new
    @user = User.new(active: true)
  end
  
  def create
    @user = User.new( permitted_params )
    if @user.save
      flash[:success] = 'Created'
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes( permitted_update )
      flash[:success] = 'Updated'
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  private
  def permitted_params
    params.require(:user).permit(:login, :password, :password_confirmation, :active)
  end

  def permitted_update
    params.require(:user).permit(:password, :password_confirmation, :active)
  end
end
