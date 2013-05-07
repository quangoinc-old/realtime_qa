class AddBugherdIssueIDtoIssue < ActiveRecord::Migration
	def change
	  add_column :issues, :bugherd_id, :integer
	end
end
