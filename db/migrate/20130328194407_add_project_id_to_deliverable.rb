class AddProjectIdToDeliverable < ActiveRecord::Migration
  def change
    add_column :deliverables, :project_id, :integer
  end
end
