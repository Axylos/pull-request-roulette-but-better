class ReviewsController < ApplicationController
  before_action :authenticate!
  def index
    p session[:token]



  end
end
