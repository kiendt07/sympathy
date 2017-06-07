$(document).on('turbolinks:load', function() {
  $(function() {
    $('.direct-upload').each(function() {
      var form = $(this);
      $(this).fileupload({
        url: form.attr('action'),
        type: 'POST',
        autoUpload: true,
        dataType: 'xml',
        add: function (event, data) {
          $('.progress-bar').css('width', 0);
          $.ajax({
            url: '/signed_urls',
            type: 'GET',
            dataType: 'json',
            data: {doc: {title: data.files[0].name}},
            async: false,
            success: function (data) {
              form.find('input[name=key]').val(data.key);
              form.find('input[name=policy]').val(data.policy);
              form.find('input[name=signature]').val(data.signature);
            }
          });
          data.submit();
        },

        send: function () {
          $('.progress').fadeIn();
        },

        progress: function (e, data) {
          var percent = Math.round((data.loaded / data.total) * 100);
          $('.progress-bar').css('width', percent + '%');
        },

        success: function (data) {
          $('.track-preview iframe').attr('src', '');
          var url = $(data).find('Location').text();

          $('#track_url').val(url);
          $('.track-preview audio source').attr('src', url);
          var audio = $('.track-preview audio');
          audio.load();

          $('.progress').hide();
          $('.track-preview').show();
          $('#submit').removeAttr('disabled');
          $('#submit-private').removeAttr('disabled');
        },
      });
    });
  });

  $('#submit-private').click(function(){
    submitPrivate();
  });

  $('#track_url_raw').on('change keyup paste', function(){
    var url = $('#track_url_raw').val();
    var code = url.split('/')[url.split('/').length - 1].split('.')[0];
    var embed_url = '<iframe scrolling=\'no\' width=\'500\' height=\'150\' src='+
      '\'http://mp3.zing.vn/embed/song/'+code+'\' frameborder=\'0\'' +
      'allowfullscreen=\'true\'></iframe>';
    $('.track-preview').show().html('');
    $('.track-preview').append(embed_url);
    $('#track_url').val(url);
    $('#submit').removeAttr('disabled');
    $('#submit-private').removeAttr('disabled');
  });
});

function submitPrivate() {
  $('form#new_post #post_is_private').val(true);
  $('form#new_post').submit();
}
