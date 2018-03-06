class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :token, null: false, index: { unique: true }
      t.float :lat
      t.float :lng

      t.timestamps
    end
    add_index :users, "ll_to_earth(lat, lng)", using: :gist
  end
end
