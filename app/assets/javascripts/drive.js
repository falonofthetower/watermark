var CLIENT_ID = "494101622219-l1hdph7rcjii2kblbldm107u7tljnme1"

var SCOPES = ['https://www.googleapis.com/auth/drive.file', 'https://www.googleapis.com/auth/drive.readonly'];
var accessToken = gon.access_token;
function onApiLoad() {
  gapi.load('auth2');
  gapi.load('picker');

  $("#choose_image").click(function() {
    $( this ).hide();
    setupPicker(gon.access_token);
  });
}


function setupPicker() {
  var picker = new google.picker.PickerBuilder()
    .setOAuthToken(gon.access_token)
    .setAppId('494101622219')
    .addView(new google.picker.DocsUploadView())
    .addView(new google.picker.DocsView())
    .setCallback(pickerCallback)
    .build();
  picker.setVisible(true);
}

function pickerCallback(data) {
  var url = 'nothing';
  if (data.action == google.picker.Action.PICKED) {
    var doc = data[google.picker.Response.DOCUMENTS][0];
    var id = doc.id;
    document.getElementById('image_google_id').value = id;
    document.forms['new_image'].submit();
  } else if (data.action == "cancel") {
    $('#choose_image').show();

    $("#choose_image").click(function() {
      $('#choose_image').hide();
      setupPicker(gon.access_token);
    });
  }
}

function authMe() {
  gapi.auth.setToken({access_token: gon.access_token});
  listFiles();
}
function listFiles() {
  var fileId = gon.google_id;

  gapi.client.load('drive', 'v2', function() {
    var request = gapi.client.drive.files.get({
      'fileId': fileId
    });
    request.execute(function(resp) {
      console.log('Title: ' + resp.title);
      console.log('Description: ' + resp.description);
      console.log('MIME type: ' + resp.mimeType);
      console.log('Thumbnaillink: ' + resp.thumbnailLink);
      var image = '<img src="' + resp.thumbnailLink + '" />';
      $('#output').prepend(image);
    });
  });
}
