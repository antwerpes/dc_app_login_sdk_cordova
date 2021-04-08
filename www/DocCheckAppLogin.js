var exec = require('cordova/exec');

var PLUGIN_NAME = "DocCheckAppLogin"; // This is just for code completion uses.

var DocCheckAppLogin = function() {}; // This just makes it easier for us to export all of the functions at once.
// All of your plugin functions go below this. 
// Note: We are not passing any options in the [] block for this, so make sure you include the empty [] block.
DocCheckAppLogin.openLogin = function(onSuccess, onError, loginId, language, templateName) {
   exec(onSuccess, onError, PLUGIN_NAME, "openLogin", [loginId, language, templateName]);
};

module.exports = DocCheckAppLogin;