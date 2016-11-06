var CLIENT_ID = "494101622219-l1hdph7rcjii2kblbldm107u7tljnme1"

var SCOPES = ['https://www.googleapis.com/auth/drive.file', 'https://www.googleapis.com/auth/drive.readonly'];
function DisplayMyName() 
{
}
// var SCOPES = ['https://www.googleapis.com/auth/drive'];
/**
 * Check if current user has authorized this application.
 */
function checkAuth() {
  var myName = arguments.callee.toString();
  myName = myName.substr('function '.length);
  myName = myName.substr(0, myName.indexOf('('));

  console.log(myName);
  gapi.auth.authorize(
    {
      'client_id': CLIENT_ID,
      'scope': SCOPES.join(' '),
      'immediate': true
    }, handleAuthResult);
}

/**
 * Handle response from authorization server.
 *
 * @param {Object} authResult Authorization result.
 */
function handleAuthResult(authResult) {
  var myName = arguments.callee.toString();
  myName = myName.substr('function '.length);
  myName = myName.substr(0, myName.indexOf('('));

  console.log(myName);
  var authorizeDiv = document.getElementById('authorize-div');
  if (authResult && !authResult.error) {
    // Hide auth UI, then load client library.
    loadDriveApi();
  } else {
    // Show auth UI, allowing the user to initiate authorization by
    // clicking authorize button.
  }
}

/**
 * Initiate auth flow in response to user clicking authorize button.
 *
 * @param {Event} event Button click event.
 */
// function handleAuthClick(event) {
//   var myName = arguments.callee.toString();
//   myName = myName.substr('function '.length);
//   myName = myName.substr(0, myName.indexOf('('));

//   console.log(myName);
//   gapi.auth.authorize(
//     {client_id: CLIENT_ID, scope: SCOPES.join(' '), immediate: false},
//     handleAuthResult);
//   return false;
// }

/**
 * Load Drive API client library.
 */
function loadDriveApi() {
  var myName = arguments.callee.toString();
  myName = myName.substr('function '.length);
  myName = myName.substr(0, myName.indexOf('('));

  console.log(myName);
  gapi.client.load('drive', 'v2', listFiles);
}

/**
 * Print files.
 */
function listFiles() {
  var myName = arguments.callee.toString();
  myName = myName.substr('function '.length);
  myName = myName.substr(0, myName.indexOf('('));

  console.log(myName);
  var fileId = gon.google_id
  var request = gapi.client.drive.files.get({
    'fileId': fileId
  });
  var touch = gapi.client.drive.files.touch({
    'fileId': fileId
  });
  debugger;
  touch.execute(function(resp) { });

  request.execute(function(resp) {
    console.log('Title: ' + resp.title);
    console.log('Description: ' + resp.description);
    console.log('MIME type: ' + resp.mimeType);
    console.log('MIME type: ' + resp.thumbnailLink);
    var img = new Image();
    var div = document.getElementById('output');
    div.appendChild(img);
    img.src = resp.thumbnailLink;
  });
  // var request = gapi.client.drive.files.list({
  //     'pageSize': 10,
  //     'fields': "nextPageToken, files(id, name)"
  //   });

  //   request.execute(function(resp) {
  //     appendPre('Files:');
  //     var files = resp.files;
  //     if (files && files.length > 0) {
  //       for (var i = 0; i < files.length; i++) {
  //         var file = files[i];
  //         appendPre(file.name + ' (' + file.id + ')');
  //       }
  //     } else {
  //       appendPre('No files found.');
  //     }
  //   });
}


/**
 * Append a pre element to the body containing the given message
 * as its text node.
 *
 * @param {string} message Text to be placed in pre element.
 */
// function appendPre(message) {
//   var myName = arguments.callee.toString();
//   myName = myName.substr('function '.length);
//   myName = myName.substr(0, myName.indexOf('('));

//   console.log(myName);
//   var pre = document.getElementById('output');
//   var textContent = document.createTextNode(message + '\n');
//   pre.appendChild(textContent);
// }

