class User::Authenticate

  attr_accessor :params

  def self.with( params )
    a = User::Authenticate.new
    a.params = params
    a.authenticate
  end

  def authenticate
    if authenticated
      return user
    end
  end

  def authenticated
    user && password_match
  end

  def user
    @user ||= get_user
  end

  def get_user
    User.active.where(["login = ?", login]).first
  end

  def password_match
    user.authenticate password
  end

  def login
    params[:login]
  end

  def password
    params[:password]
  end
end

