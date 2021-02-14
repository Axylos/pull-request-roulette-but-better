class ApplicationController < ActionController::Base
  def authenticate! 
    token = session[:token]

    begin
      user_data = JsonWebToken.decode(token)
      self.current_user = User.find(user_data[:user_id])
    rescue
      reset_session
      flash[:alert] = "You are not logged in" 
      redirect_to login_url
    end

  end

  def current_user
    self.current_user
  end

  attr_accessor :current_user
end
