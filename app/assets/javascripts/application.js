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
//= require jquery.remotipart


function closeForm() {
  $('span.w3-closebtn').closest('form').remove();
  $('.link-new a').show();
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('.image-preview').html('<img src=' + e.target.result + '>' + '</img>');
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).on('change', 'input#payment_image', function(){
  readURL(this);
});
