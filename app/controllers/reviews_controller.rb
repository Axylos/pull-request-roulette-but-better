class ReviewsController < ApplicationController
  def index
    p session[:token]


  end
end
