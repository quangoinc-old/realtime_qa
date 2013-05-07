class AddBugherdIdtoDeliverable < ActiveRecord::Migration
  def change
    add_column :deliverables, :bugherd_id, :integer
  end
end
