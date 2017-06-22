require "will_paginate/array"
class PagesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    if user_signed_in?
      redirect_to home_path
    else
      render layout: false
    end
  end

  def show
    @feeds = current_user.feeds.paginate page: params[:page],
      per_page: Settings.users.per_page
  end
end
