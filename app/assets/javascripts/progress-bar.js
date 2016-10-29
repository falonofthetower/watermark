$(document).ready(function(){
  function updateProgressBar(id) {
    $.getJSON("/progress/" + id, function(data) {
      $("#job-progress" + id).text(data['status'] + "%");
      $("#job-progress" + id).attr( "aria-valuenow", data['status'] );
      $("#job-progress" + id).css({"width": data['status'] + "%"});
    });
    var timeoutID = setTimeout(function() { updateProgressBar(id) }, 1000)
  }
});
