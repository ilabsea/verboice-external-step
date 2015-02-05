function projectChanged(element){
  element.on('change',function(){
    var elementId = element.attr("id");

    if(element.val()) {
      $.ajax({
        method: 'GET',
        url: "/project_variables",
        data: {project_id: element.val()},
        success: function(variables){
          addVariablesTo(variables, 'step_variable_id');
        }
      });
    } else {
      addVariablesTo([], 'step_variable_id');
    }
  });
};

function addVariablesTo(variables, elementId){
  var defaultOption = {id: '', name: '--- select variable ---'};
  variables.unshift(defaultOption);

  options = $.map(variables, function(item){
    return "<option value='" + item.id + "' >" + item.name + "</options>";
  });

  $("#" +elementId).html(options);
};
