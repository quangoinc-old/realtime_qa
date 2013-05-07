class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :project_ids, :client, :department
  # attr_accessible :title, :body
  has_many :occurances_as_logged_by, :class_name => "Issue", :foreign_key => "logged_by_id"
  has_many :occurances_as_assigned_to, :class_name => "Issue", :foreign_key => "assigned_to_id"
  has_many :occurances_as_logged_by, :class_name => "IssueNote", :foreign_key => "logged_by_id"
  has_many :client_project_assignments
  has_many :projects, :through => :client_project_assignments
  accepts_nested_attributes_for :client_project_assignments, :allow_destroy => true
  accepts_nested_attributes_for :projects, :allow_destroy => true
end
