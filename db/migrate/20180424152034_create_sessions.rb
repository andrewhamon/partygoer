class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.string :pin, null: false
      t.boolean :verified, null: false, default: false

      t.timestamps
    end
  end
end
