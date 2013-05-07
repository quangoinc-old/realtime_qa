class CreateClientProjectAssignments < ActiveRecord::Migration
  def change
    create_table :client_project_assignments do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
