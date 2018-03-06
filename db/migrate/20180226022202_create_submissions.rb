class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.references :user,  foreign_key: true, null: false
      t.references :track, foreign_key: true, null: false
      t.references :party, foreign_key: true, null: false
      t.integer :score, null: false, default: 0, index: true
      t.datetime :played_at, index: true
      t.datetime :skipped_at, index: true
      t.boolean  :playing, null: false, default: false, index: true

      t.timestamps
    end
  end
end
