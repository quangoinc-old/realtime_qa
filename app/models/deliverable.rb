class Deliverable < ActiveRecord::Base
  attr_accessible :description, :location, :name, :status, :project_id
  has_many :issues
  belongs_to :project
end
