class UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def show
    @user = User.find params[:id]
    @relationship = current_user.active_relationships
      .find_by followed_id: @user.id
  end
end
