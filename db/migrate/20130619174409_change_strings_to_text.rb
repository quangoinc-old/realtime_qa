class ChangeStringsToText < ActiveRecord::Migration
	def change
	  change_column :issues, :description, :text
	  change_column :issue_notes, :content, :text
	end
end
