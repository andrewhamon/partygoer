class PreventDuplicateSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_index :submissions, [:user_id, :track_id, :party_id], unique: true
  end
end
