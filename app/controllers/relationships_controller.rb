class RelationshipsController < ApplicationController
  def index
    @user = User.find_by id: params[:user_id]
    @title = params[:type]
    if %w(following followers).include? params[:type]
      @users = @user.send(params[:type]).paginate page: params[:page],
        per_page: Settings.users.per_page
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    @relationship = current_user.active_relationships
      .find_by followed_id: @user.id
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
