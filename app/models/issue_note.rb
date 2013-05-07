class IssueNote < ActiveRecord::Base
  attr_accessible :content, :issue_id, :logged_by, :project_id
  belongs_to :issue
  belongs_to :logged_by, :class_name => "User", :foreign_key => "logged_by_id"
  after_create :push_update
  after_update :push_update
  def push_update
  	Pusher.trigger('deliverable'+self.issue.deliverable_id.to_s, 'note_update', {:issue => self.issue_id, :note => self, :logged_by => self.logged_by})
  end
end
