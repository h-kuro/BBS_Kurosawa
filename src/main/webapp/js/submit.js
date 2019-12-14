$('#AjaxForm').submit(function (event) {
    event.preventDefault();
    var $form = $(this);
    var $button = $form.find('.submit');
    $.ajax({
        url: $form.attr('action'),
        type: $form.attr('method'),
        data: $form.serialize(),
        timeout: 10000,
        beforeSend: function (xhr, settings) {
            $button.attr('disabled', true);
        },
        complete: function (xhr, textStatus) {
            $button.attr('disabled', false);
        },
        success: function (result, textStatus, xhr) {
            $form[0].reset();
            $("#result").append(result);
            window.location.reload();
            var PostForm = $('#PostForm').offset().top;
            $('html, body').animate({scrollTop: PostForm});
        },
        error: function (xhr, textStatus, error) {
        }
    });
});
function openWindow(url, type, id) {
    const altUrl = url + '?type=' + type + '&id=' + id;
    const features = 'width=' + String(screen.width / 4) + ',height=' + String(screen.height / 4);
    window.open(altUrl, "auth", features);
}