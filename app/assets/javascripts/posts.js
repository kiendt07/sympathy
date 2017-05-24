$(document).on("turbolinks:load", function () {
  $(function () {
        $(".direct-upload").each(function () {
            var form = $(this)
            $(this).fileupload({
                url: form.attr("action"),
                type: "POST",
                autoUpload: true,
                dataType: "xml",
                add: function (event, data) {
                    $(".progress-bar").css("width", 0);
                    $(".intro-wrapper").removeClass("margin-top-15-percent");

                    $.ajax({
                        url: "/signed_urls",
                        type: "GET",
                        dataType: "json",
                        data: {doc: {title: data.files[0].name}}, // send the file name to the server so it can generate the key param
                        async: false,
                        success: function (data) {
                            // Now that we have our data, we update the form so it contains all
                            // the needed data to sign the request
                            form.find("input[name=key]").val(data.key)
                            form.find("input[name=policy]").val(data.policy)
                            form.find("input[name=signature]").val(data.signature)
                        }
                    })
                    data.submit();
                },
                send: function (e, data) {
                    $(".progress").fadeIn();
                },
                progress: function (e, data) {
                    // This is what makes everything really cool, thanks to that callback
                    // you can now update the progress bar based on the upload progress
                    // $(".progress-note").text("アップロードされた合計" +data.total/1000+ "KB のうち " + data.loaded/1000 + "KB");
                    console.log("アップロードされた合計" +data.total/1000+ "KB のうち " + data.loaded/1000 + "KB");
                    var percent = Math.round((data.loaded / data.total) * 100);
                    $(".progress-bar").css("width", percent + "%")
                },
                fail: function (e, data) {
                    console.log("fail" + data);
                },
                success: function (data) {
                    // Here we get the file url on s3 in an xml doc
                    $(".track-preview").html("");
                    var url = $(data).find("Location").text()

                    $("#track_url").val(url);

                    $(".track-preview audio source").attr("src", url);

                    audio = $(".track-preview audio");

                    audio.load();//suspends and restores all audio element


                    //audio[0].play(); changed based on Sprachprofi's comment below
                    $(".progress").hide();
                    $(".track-preview").show();

                    $("#submit").removeAttr("disabled");
                    $("#submit-private").removeAttr("disabled");
                },
                done: function () {
                },
            });

        });
  });

      $("#submit-private").click(function(){
        submitPrivate();
      })
      $("#track_url_raw").on("change keyup paste", function(){
        url = $("#track_url_raw").val();
        code = url.split("/")[url.split("/").length - 1].split(".")[0]
        embed_url = "<iframe scrolling=\"no\" width=\"640\" height=\"180\" src=\"http://mp3.zing.vn/embed/song/"+code+"\" frameborder=\"0\" allowfullscreen=\"true\"></iframe>"
        $(".track-preview").show().html("");
        $(".track-preview").append(embed_url);
        $("#track_url").val(url);
        $("#submit").removeAttr("disabled");
        $("#submit-private").removeAttr("disabled");
      });
});

function submitPrivate(){
  $("form#post_form #post_is_private").val(true);
  $("form#post_form").submit();
}
