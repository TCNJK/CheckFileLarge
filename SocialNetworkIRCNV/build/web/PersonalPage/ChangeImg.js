document.getElementById('fileInput1').addEventListener('change', function (event) {
    var file = event.target.files[0];
    // T?o ??i t??ng FileReader ?? ??c t?p tin
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('previewImage1');
        previewImage.src = e.target.result;
        previewImage.style = "display: block; width:100%";
    };
    reader.readAsDataURL(file);
});
document.getElementById('fileInput2').addEventListener('change', function (event) {
    var file = event.target.files[0];

    // T?o ??i t??ng FileReader ?? ??c t?p tin
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('imgPost');
        previewImage.src = e.target.result;
        previewImage.style = " max-width:660px; max-height:660px;";
    };
    reader.readAsDataURL(file);
});
document.getElementById('fileInput3').addEventListener('change', function (event) {
    var file = event.target.files[0];
    // T?o ??i t??ng FileReader ?? ??c t?p tin
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('previewImage3');
        previewImage.src = e.target.result;
    };
    reader.readAsDataURL(file);
});
document.getElementById('fileInput4').addEventListener('change', function (event) {
    var file = event.target.files[0];
    // T?o ??i t??ng FileReader ?? ??c t?p tin
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('previewImage4');
        previewImage.src = e.target.result;
    };
    reader.readAsDataURL(file);
});