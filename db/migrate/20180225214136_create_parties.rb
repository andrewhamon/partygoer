class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.references :owner, null: false, index: true, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.float :lat, null: false
      t.float :lng, null: false

      t.timestamps
    end
    add_index :parties, 'll_to_earth(lat, lng)', using: :gist
  end
end
