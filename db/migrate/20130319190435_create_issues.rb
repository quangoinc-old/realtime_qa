class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :status
      t.string :description
      t.string :location
      t.integer :logged_by_id
      t.integer :assigned_to_id
      t.integer :deliverable_id
      t.timestamps
    end
  end
end
