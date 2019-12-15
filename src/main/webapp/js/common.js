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
        },
        error: function (xhr, textStatus, error) {
        }
    });
});
function openWindow(url, type, id) {
    const altUrl = url + '?type=' + type + '&id=' + id;
    var width = screen.width / 2;
    var height = screen.height / 2;
    var x = (screen.availWidth - width ) / 2;
    var y = (screen.availHeight - height) / 2;
    const features = 'width=' + width + ',height=' + height
        + ",top=" + y +  ",left=" + x;
    window.open(altUrl, "auth", features);
}