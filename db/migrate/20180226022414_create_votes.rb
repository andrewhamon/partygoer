class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :submission, foreign_key: true, null: false
      t.integer :value, null: false

      t.timestamps
    end

    add_index :votes, %i[user_id submission_id], unique: true
  end
end
