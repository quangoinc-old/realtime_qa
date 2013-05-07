class CreateIssueNotes < ActiveRecord::Migration
  def change
    create_table :issue_notes do |t|
      t.integer :issue_id
      t.integer :logged_by_id
      t.string :content

      t.timestamps
    end
  end
end
