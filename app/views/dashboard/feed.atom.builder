atom_feed do |feed|
  feed.title "My Quango Assurance Issues"
  feed.updated @my_issues.maximum(:updated_at)
  @my_issues.each do |issue|
    begin
      feed.entry issue, created: issue.created_at, url: "#{root_url}qa/#{issue.deliverable_id}" do |entry|
        entry.title ""+issue.deliverable.project.code + ": "+issue.location + " - " + issue.description+""
        entry.content issue.description + "<br/><strong>Current Status:</strong> " + issue.status + "<br/><strong>Logged By</strong>: " + issue.logged_by.name+ "<br/><strong>Assigned To</strong>: " + issue.assigned_to.name, :type => 'html'
        entry.author do |author|
          author.name issue.logged_by.name
        end
      end
    rescue
    end
  end
  @dep_issues.each do |issue|
    begin
      feed.entry issue, created: issue.created_at, url: "#{root_url}qa/#{issue.deliverable_id}" do |entry|
        entry.title ""+issue.deliverable.project.code + ": "+issue.location + " - " + issue.description+""
        entry.content issue.description + "<br/><strong>Current Status:</strong> " + issue.status + "<br/><strong>Logged By</strong>: " + issue.logged_by.name+ "<br/><strong>Assigned To</strong>: " + issue.assigned_to.name, :type => 'html'
        entry.author do |author|
          author.name issue.logged_by.name
        end
      end
    rescue
    end
  end
end