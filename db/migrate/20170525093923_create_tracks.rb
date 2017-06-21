class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :track_type
      t.boolean :is_private, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
