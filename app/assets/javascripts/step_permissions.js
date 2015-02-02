$(function(){
  createTypeahead()
  addButtonClick()
  removeButtonClick()
})

function createTypeahead(){
  var $inputTypeahead = $("#step_permission_user")
  if($inputTypeahead.length == 0 )
    return false

  var urlSearch = $inputTypeahead.attr("data-url")

  var sources = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('email'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: urlSearch,
    ttl: 1000 * 5
  });

  // initialize the bloodhound suggestion engine
  sources.initialize();

  var $typeaheadValue = $("#step_permission_user_value")

  // instantiate the typeahead UI
  $inputTypeahead.typeahead({ hint: true, highlight: true, minLength: 1 }, {
    displayKey: 'email',
    source: sources.ttAdapter(),
    templates: {
      empty: '<div class="empty-message">No result found, please retry</div>'
    }
  }).
  on('typeahead:selected', function(event, data){
    $typeaheadValue.val(data.id)
  }).
  on('typeahead:autocompleted', function(e, data){
    $typeaheadValue.val(data.id)
  });
}

function addButtonClick(){
  $("#add-permission").on('click', function(){
    var url = $("#step_permission_url").attr('action')
    var userEmail = $("#step_permission_user").val()
    var userId = $("#step_permission_user_value").val()

    var data = {
      user_id: userId,
      user_email: userEmail
    }

    $.ajax({
      url: url,
      data: data,
      method: 'POST',
      success: function(response){
        addToTable(response)
        setNotification("notice", "User with email " + userEmail + " has been created")
        clearInput()
      },
      error: function(response) {
        setNotification("alert", response.responseText)
        clearInput()
      }
    })
    return false;
  })
}

function clearInput(){
  $("#step_permission_user").val('')
  $("#step_permission_user_value").val('')
}

function addToTable(response){
  var $table = $("#step-permissions-list")
  var $row = $(response)
  $table.find("tbody").prepend($row)
  $row.fadeIn()
}

function removeButtonClick(){
  $(document).on("click", '.remove-step-permissions', function(){
    var $this = $(this)

    var url = $this.attr('href')
    var confirmText = 'Are you sure to remove' //$this.attr('data-confirm')
    if(!confirm(confirmText))
      return false
    var $table = $("#step-permissions-list")

    $.ajax({
      method: 'DELETE',
      url: url,
      success: function(){
        var $tr = $this.parent().parent()
        $tr.fadeOut(1000, function(){
          $tr.remove()
        });
        setNotification('notice', 'User has been removed')
      },

      error: function(response){
        setNotification('alert', 'Failed to remove user, please try again')
      }
    })

    return false


  })
}

