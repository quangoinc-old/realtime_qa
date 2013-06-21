class Issue < ActiveRecord::Base
  attr_accessible :assigned_to_id, :description, :location, :logged_by_id, :status, :logged_by, :assigned_to, :deliverable_id
  has_many :issue_notes, :include => [:issue]
  belongs_to :logged_by, :class_name => "User", :foreign_key => "logged_by_id"
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  belongs_to :deliverable
  after_update :push_update
  after_create :push_update
  before_create :set_local_id
  def push_update
  	Pusher.trigger('deliverable'+self.deliverable_id.to_s, 'issue_update', {:issue => self, :notes => self.issue_notes, :assigned_to => self.assigned_to, :logged_by => self.logged_by, :changes => self.changed})
  end
  def set_local_id
    count = Issue.where('deliverable_id = ?',self.deliverable).size
    self.local_id = count+1
  end
  def open?
    if self.status == "Non-issue" || self.status == "Confirmed" || self.status.nil?
      return false
    else
      return true
    end
  end
end
