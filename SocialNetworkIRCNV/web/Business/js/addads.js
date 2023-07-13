/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.getElementById('fileInput').addEventListener('change', function (event) {
    var file = event.target.files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('previewImage');
        previewImage.src = e.target.result;
        previewImage.style = "display: block; max-height: 300px ";
    };
    reader.readAsDataURL(file);
});
function askForAddAds(BID) {
    if (confirm('Are you confirm to add this ads?'))
        addAds(BID);
}
function addAds(BID) {
    var fileInput = document.querySelector('input[name="photo"]');
    var file = fileInput.files[0];
    var formData = new FormData();
    var content = document.getElementById("NewPostTextarea").value;
    var previewImage = document.getElementById('previewImage');
    formData.append('photo', file);
    formData.append('content', content);
    formData.append('BID', BID);
    $.ajax({
        url: "/SocialNetworkIRCNV/AddAds",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            var container = document.getElementById("post-input-container");
            container.innerHTML = data;
            alert("!!!Add new Advertise successfull!!!");
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}
