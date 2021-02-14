class SessionsController < ApplicationController
  def login
    @token = form_authenticity_token
  end

  def register
    @token = form_authenticity_token
  end

  def index
  end

  def show
  end

  def destroy
    reset_session
    redirect_to login_url
  end

  def create
    @user = User.find_by(user_params[:email])
    if @user&.authenticate(user_params[:password])
      session[:token] = JsonWebToken.encode(
        user_id: @user.id,
        username: @user.username,
        email: @user.email
      )
      redirect_to reviews_url
    else
      flash[:alert] = "Invalid Username/Password Combination"
      redirect_to login_url
    end
  end

  protected

  def user_params
    params.permit(:email, :password)
  end
end
