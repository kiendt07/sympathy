class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    if user_signed_in?
      redirect_to home_path
    else
      render layout: false
    end
  end

  def show
  end
end
