class AddTwilioColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_number, :string, null: false
    add_column :users, :pin, :string, null: false
    add_column :users, :verified, :boolean, null: false, default: false
  end
end
