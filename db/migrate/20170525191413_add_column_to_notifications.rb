class AddColumnToNotifications < ActiveRecord::Migration[5.0]
  def change
  	add_column :notifications, :notificationable_id, :integer
  	add_column :notifications, :notificationable_type, :string
  end
end
