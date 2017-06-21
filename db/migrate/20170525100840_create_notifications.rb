class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notified_by_id
      t.string :notice_type
      t.boolean :read
      t.boolean :checked

      t.timestamps
    end
  end
end
