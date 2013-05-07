class AddDepartmentToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_department, :boolean
  end
end
