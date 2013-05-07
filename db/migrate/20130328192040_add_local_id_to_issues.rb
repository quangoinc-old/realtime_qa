class AddLocalIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :local_id, :integer
  end
end
