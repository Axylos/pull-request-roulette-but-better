require 'byebug'
class UsersController < ApplicationController
  def create
    data = user_params
    @user = User.new(user_params)

    if !@user.save 
      err = @user.errors
      flash[:alert] = err.full_messages.first
      redirect_to register_url
    else 
      session[:token] = JsonWebToken.encode(
        user_id: @user.id,
        username: @user.username,
        email: @user.email
      )
      redirect_to reviews_url
    end

  end

  protected
  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
