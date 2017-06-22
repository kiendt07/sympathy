class NotificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @notifications = current_user.notifications.newest_first
      .paginate page: params[:page], per_page: Settings.notifications.per_page
  end
end
