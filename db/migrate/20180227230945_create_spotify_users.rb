class CreateSpotifyUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :spotify_users do |t|
      t.string :sid, null: false, index: { unique: true }
      t.string :device_id
      t.string :token, null: false
      t.string :token_expires_at, null: false
      t.string :refresh_token, null: false

      t.timestamps
    end
  end
end
