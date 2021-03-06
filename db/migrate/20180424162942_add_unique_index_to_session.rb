class AddUniqueIndexToSession < ActiveRecord::Migration[5.1]
  def change
    add_index :sessions, %i[user_id pin], unique: true
    add_index :sessions, :token, unique: true
  end
end
