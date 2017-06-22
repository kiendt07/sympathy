// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require js-routes
//= require sweetalert
//= require jquery-fileupload/vendor/jquery.ui.widget
//= require jquery-fileupload/jquery.fileupload
//= require jquery-fileupload/jquery.iframe-transport
//= require amplitude
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
  var userAvatars = $('.user-avatar');
  $.each(userAvatars, function(){
    var url = $(this).data('user-avatar');
    $(this).css('background-image', 'url('+ url +')');
  });

  $('.bandcamp-link').on('click', function (e) {

    e.stopPropagation();
  });

  jQuery('.song').on('mouseover', function () {
    jQuery(this).css('background-color', '#00A0FF');
    jQuery(this).find('.song-meta-data .song-title').css('color', '#FFFFFF');
    jQuery(this).find('.song-meta-data .song-artist').css('color', '#FFFFFF');
    if (!jQuery(this).hasClass('amplitude-active-song-container')) {
      jQuery(this).find('.play-button-container').css('display', 'block');
    }
    jQuery(this).find('img.bandcamp-grey').css('display', 'none');
    jQuery(this).find('img.bandcamp-white').css('display', 'block');
    jQuery(this).find('.song-duration').css('color', '#FFFFFF');
  });

  jQuery('.song').on('mouseout', function () {
    jQuery(this).css('background-color', '#FFFFFF');
    jQuery(this).find('.song-meta-data .song-title').css('color', '#272726');
    jQuery(this).find('.song-meta-data .song-artist').css('color', '#607D8B');
    jQuery(this).find('.play-button-container').css('display', 'none');
    jQuery(this).find('img.bandcamp-grey').css('display', 'block');
    jQuery(this).find('img.bandcamp-white').css('display', 'none');
    jQuery(this).find('.song-duration').css('color', '#607D8B');
  });

  jQuery('.song').on('click', function () {
    jQuery(this).find('.play-button-container').css('display', 'none');
  });

});

jQuery.extend(window, Routes);
