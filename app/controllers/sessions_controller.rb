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

  def create
    redirect_to reviews_url
  end
end
