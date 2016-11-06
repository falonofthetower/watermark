var CLIENT_ID = "494101622219-l1hdph7rcjii2kblbldm107u7tljnme1"

// var SCOPES = ['https://www.googleapis.com/auth/drive.metadata.readonly', 'https://www.googleapis.com/auth/drive.file'];
var SCOPES = ['https://www.googleapis.com/auth/drive'];

var accessToken;
function onApiLoad() {
  gapi.load('auth', authenticateWithGoogle);
  gapi.load('picker');
}
function authenticateWithGoogle() {
  window.gapi.auth.authorize({
    'client_id': CLIENT_ID,
    'scope': SCOPES.join(' '),
  }, handleAuthentication);
}
function handleAuthentication(result) {
  if(result && !result.error) {
    accessToken = result.access_token;
    $('#choose_image').hide();
    setupPicker();
  }
}
function setupPicker() {
  var picker = new google.picker.PickerBuilder()
    .setOAuthToken(accessToken)
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
    document.getElementById('watermark_google_id').value = id;
    document.forms['new_watermark'].submit();
  } else if (data.action == "cancel") {
    $('#choose_image').show();

    $("#choose_image").click(function() {
      $('#choose_image').hide();
      setupPicker();
    });
  }
}
$("#choose_image").click(function() {
  $('#choose_image').hide();
  setupPicker();
});

