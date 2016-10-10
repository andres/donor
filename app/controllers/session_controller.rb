class SessionController < ApplicationController

  skip_before_action :authenticate_user

  def index
  end

  def create
    @current_user = User::Authenticate.with( params )
    if @current_user.present?
      session[:user_id] = @current_user.id
      redirect_to people_url
    else
      session[:current_id] = nil
      flash[:alert] = 'Login incorrect'
      render action: 'index'
    end
  end

  def destroy
    session[:user_id] = nil
    render action: 'index'
  end
end
