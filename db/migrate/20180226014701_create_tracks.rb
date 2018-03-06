class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :sid, null: false, index: { unique: true }
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end
  end
end
