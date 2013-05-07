$('body').on('click','.status-change li > a',function(){
	var issueId = $(this).parents('tr').attr('id').replace('issue-','')
	$.ajax({
		type: 'put',
		url: '/update_issue/',
		data: {id:issueId,status:$(this).text()}
	})
})
$('body').on('click','.assignment-change li > a',function(){
	var issueId = $(this).parents('tr').attr('id').replace('issue-','')
	$.ajax({
		type: 'put',
		url: '/update_owner/',
		data: {id:issueId,assigned_to_id:$(this).data("assigned_id")}
	})
})
$('body').on('hidden', '.modal', function () {
  $(this).removeData('modal');
}); 


$('body').on('mouseenter','p.new',function(){
	$(this).removeClass('new')
});

  var issueList = $("#issue_list").dataTable({
    "aoColumns": [
      null,
      null,
      null,
      null,
      null,
      {"bSortable": false, "bSearchable": false },
      { "bSearchable": false }
    ],
    "bLengthChange": false,
    "iDisplayLength": 500,
    "bPaginate": false,
    "bInfo": false });



  $('body').on('click','#open_issues',function(){
    if($(this).is(":checked")) {
      issueList.$('tr').each(function(){
        var that = $(this)
        if($(this).find('.current-status').text() == "Confirmed" || $(this).find('.current-status').text() == "Non-issue"){
          that.addClass('status-hide')
        }
      })
      issueList.fnSetDisplayLength = 500;
      issueList.fnDraw();
    }
    else {
      issueList.$('tr').removeClass('status-hide');
      issueList.fnDraw();
    }
  })

  $('body').on('click','#my_issues',function(){
  	var user = $(this).data('user')
  	if($(this).is(":checked")) {
  		issueList.$('tr').each(function(){
  			var that = $(this)
  			console.log($(this).find('.current-user').text())
  			console.log(user)
  			if($(this).find('.current-user').text() != user){
  				that.addClass('user-hide')
  			}
  		})
  		issueList.fnSetDisplayLength = 500;
  		issueList.fnDraw();
  	}
  	else {
  		issueList.$('tr').removeClass('user-hide');
  		issueList.fnDraw();
  	}
  })
  
  
  var BugherdIssueList = $("#bugherd_issue_list").dataTable({
    "aoColumns": [
      null,
      null,
      null,
      null,
    ]

  });

  $('body').on('click','#create_bugherd',function(){
    $(this).attr('disabled','disabled')
  })
  $('body').on('ajax:complete','#create_bugherd',function(){
    console.log('hell')
    document.location.reload(true)
  })