class ReplaceSubmissionTimestampsWithEnum < ActiveRecord::Migration[5.1]
  def change
    remove_column :submissions, :played_at, :datetime, null: false
    remove_column :submissions, :skipped_at, :datetime, null: false
    remove_column :submissions, :playing, :boolean, null: false

    add_column :submissions, :queue_status, :integer, default: 0, null: false
    add_index :submissions, :queue_status
  end
end
