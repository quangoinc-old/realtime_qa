class Project < ActiveRecord::Base
  attr_accessible :code, :name, :client_ids
  has_many :deliverables
  has_many :client_project_assignments
  has_many :clients, :through => :client_project_assignments, :source => :user
  accepts_nested_attributes_for :client_project_assignments, :allow_destroy => true
  accepts_nested_attributes_for :clients, :allow_destroy => true
end
