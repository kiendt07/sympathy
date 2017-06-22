$(document).on('turbolinks:load', function() {
  var elements = document.getElementsByTagName('audio');
  $.each(elements, function(){
    $(this).on('play', function(){
      var id = $(this).closest('.post').data('post-id');
      $.ajax({
        type: 'POST',
        url: '/posts/' + id + '/impressions'
      });
    });
  });
});
