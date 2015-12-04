// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function success_msg(msg) {
	document.getElementById("success-box").innerHTML = "<span>"+msg+"!</span>"
	jQuery("#success-box").fadeIn('slow');
	jQuery("#success-box").delay(2000).fadeOut('slow');
};

function error_msg(msg) {
	document.getElementById("danger-box").innerHTML = ""
	messages = JSON.parse(msg)
	for (var i=0; i < messages.length; i++) {
		document.getElementById("danger-box").innerHTML += "<span>"+messages[i]+"</span><br />"
	}
	jQuery("#danger-box").fadeIn('slow');
	jQuery("#danger-box").delay(3000).fadeOut('slow');
};