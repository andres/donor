module UserAuthentication

  private

  def authenticate_user
    logged_in || redirect_to_login
  end

  def logged_in
    if session[:user_id]
      session[:updated_at] = Time.zone.now
      @current_user = User.active.find( session[:user_id] )
    end
  end

  def redirect_to_login
    redirect_to new_session_url
  end
end
