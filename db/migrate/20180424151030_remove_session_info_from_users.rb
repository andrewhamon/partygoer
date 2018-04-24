class RemoveSessionInfoFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :token
    remove_column :users, :pin
    remove_column :users, :verified
  end
end
