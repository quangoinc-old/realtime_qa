class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:get_user]
	before_filter :client_check, :except => [:project_list, :qa, :get_user]
	BugherdAPI.authenticate ENV["BUGHERD_LOGIN"], ENV["BUGHERD_PASSWORD"]
	include ApplicationHelper
	def show

	end
	def client_check
		if current_user.client
			redirect_to :action => :project_list
		end
	end
	def index
		@deliverables = Deliverable.where('status = ?','open')
		@open = []
		@deliverables.each do |d|
			oi = false
			oi = d.issues.each do |i|
				if i.open?
					break true
				end			
			end
			if oi == true
				@open << d
			end
		end
		@issues = Issue.where('created_date is between ? and ?',(Date.today - 5.days),(Date.today + 5.days))
		@my_issues = Issue.where('assigned_to_id = ? and status != ? and status !=?',current_user,'Confirmed','Non-issue')
		@dep_issues = Issue.where('assigned_to_id = ? and status !=? and status !=?',User.where('name = ?',current_user.department.titlecase).first.id,'Confirmed','Non-issue')
		@deliverable = Deliverable.new()
	end
	def deliverables_list
		if current_user.client
			@project = current_user.project
		else
			@project = Project.find(params[:id])
		end
	end
	def project_list
		if current_user.client
			@project = current_user.project
		else
			@project = Project.all
		end
	end
	def client_list
		@clients = User.where('client = ?',true)
	end
	def project
		if params[:id]
			@model = Project.find(params[:id])
		else
			@model = Project.new()
		end
		render :layout => !request.xhr?
	end
	def deliverable
		if params[:id]
			@model = Deliverable.find(params[:id])
		else
			@model = Deliverable.new()
		end
		render :layout => !request.xhr?
	end
	def client
		if params[:id]
			@model = User.find(params[:id])
		else
			@model = User.new()
		end
		render :layout => !request.xhr?
	end
	def invite_client
		@client = User.invite!(:email => params[:user][:email], :name => params[:user][:name], :client => true)
		render :json => @client
	end
	def invite_user
		@user = User.invite!(:email => params[:user][:email], :name => params[:user][:name], :client => false, :department => params[:user][:department])
		render :json => @user
	end
	def update_user
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		render :json => @user
	end
	def user
		if params[:id]
			@model = User.find(params[:id])
		else
			@model = User.new()
		end
		render :layout => !request.xhr?
	end
	def update_client
		@client = User.find(params[:id])
		@client.update_attributes(params[:user])
		render :json => @client
	end
	def update_owner
		@issue = Issue.find(params[:id])
		if @issue.assigned_to_id == params[:assigned_to_id]
			return false
		end
		@issue.assigned_to_id = params[:assigned_to_id]
		@note = IssueNote.new()
		@note.content = "Reassigned to: " + @issue.assigned_to.name
		@note.logged_by = current_user
		@note.issue = @issue
		@note.save
		render :json => @issue.save
	end
	def qa
		if params[:id]
				@deliverable = Deliverable.find(params[:id])
			if @deliverable.bugherd_id.blank?
				project = BugherdAPI::Project.create(:name => @deliverable.name, :devurl => @deliverable.location)
				project.is_public = true
				project.save
				@deliverable.bugherd_id = project.id
				@deliverable.save
			end
				@bugherd = BugherdAPI::Project.find(@deliverable.bugherd_id)
				@bugherd_issues = BugherdAPI::Task.all(:params => {:project_id => @deliverable.bugherd_id}).sort_by &:local_task_id
				@users = User.scoped
				@bugherd_issues.each do |bi|
					if bi.status_id == 0 || bi.status_id == nil
						issue = Issue.new
						issue.deliverable_id = params[:id]
						logger = @users.where('email = ?',bi.requester_email)
						if logger.blank?
							issue.logged_by_id = 5
						else
							issue.logged_by_id = logger.first.id
						end
						issue.description = bi.description
						issue.location = bi.site + bi.url
						issue.status = 'New'
						issue.bugherd_id = bi.id
						issue.save
						bi.status_id = 1
						bi.save
					else
						next
					end
			end
				@issues = Issue.where('deliverable_id = ?',@deliverable.id)
		else
			redirect_to :action => 'project_list'
		end
	end
	def note
		if params[:id]
			@model = IssueNote.find(params[:id])
		else
			@model = IssueNote.new()
		end
		render :layout => !request.xhr?
	end
	def issue
		if params[:id]
			@model = Issue.find(params[:id])
		else
			@model = Issue.new()
		end
		render :layout => !request.xhr?
	end
	def update_issue
		@issue = Issue.find(params[:id])
		if @issue.status == params[:status]
			return false
		end
		@issue.status = params[:status]
		@note = IssueNote.new()
		@note.content = "Status: " + @issue.status
		@note.logged_by = current_user
		@note.issue = @issue
		@note.save
		@issue.save
		if @issue.bugherd_id && params[:status] == 'Confirmed'
			task = BugherdAPI::Task.find(@issue.bugherd_id, :params => {:project_id => @issue.deliverable.bugherd_id})
			task.status_id = 5
			task.save
		end
		if @issue.bugherd_id && params[:status] == 'Non-issue'
			task = BugherdAPI::Task.find(@issue.bugherd_id, :params => {:project_id => @issue.deliverable.bugherd_id})
			task.status_id = 5
			task.save
		end
		render :json => @issue
	end
	def get_user
    if current_user
      auth = Pusher[params[:channel_name]].authenticate(params[:socket_id],
        user_id: current_user.id, # => required
        user_info: {:name => current_user.name, :gravatar => avatar_url(current_user) }
      )
      render :json => auth
    else
      render :text => "Not authorized", :status => '403'
    end
	end
	def account
		@user = User.find(params[:id])
	end
	def bugherd_help

	end
	def user_management
		@users = User.where('client = ?',false)
	end
	def feed
		@user = User.find(params[:id])
		@deliverables = Deliverable.where('status = ?','open')
		@open = []
		@deliverables.each do |d|
			oi = false
			oi = d.issues.each do |i|
				if i.open?
					break true
				end			
			end
			if oi == true
				@open << d
			end
		end
		@issues = Issue.where('created_date is between ? and ?',(Date.today - 5.days),(Date.today + 5.days))
		@my_issues = Issue.where('assigned_to_id = ? and status != ? and status !=?',@user.id,'Confirmed','Non-issue')
		@dep_issues = Issue.where('assigned_to_id = ? and status !=? and status !=?',User.where('name = ?',@user.department.titlecase).first.id,'Confirmed','Non-issue')
	end
end
