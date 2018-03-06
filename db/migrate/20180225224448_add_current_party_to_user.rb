class AddCurrentPartyToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :current_party, index: true, foreign_key: { to_table: :parties }
  end
end
