document.addEventListener('DOMContentLoaded', function () {
    var offsett = document.getElementById('offset');
    var post = document.getElementById('post');
    var UID = document.getElementById('UID');
    var btnloadmore = document.getElementById('btnloadmore');
    $.ajax({
        url: "/SocialNetworkIRCNV/GetLoadPost",
        type: "POST",
        data: {type: 'homepage', UID: 'UID.innerHTML', offset: '1'},
        success: function (data) {
            if (data === "null") {
                btnloadmore.innerHTML = 'You need some friend: ';
            } else {
                var currentOffset = parseInt(offsett.innerHTML);
                offsett.innerHTML = currentOffset + 1;
                post.innerHTML = post.innerHTML + data;
            }

//            var currentOffset = parseInt(offsett.innerHTML);
//            offsett.innerHTML = currentOffset + 1;
//            post.innerHTML = currentOffset+1;
        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
});

function addBusiness() {
    $('#createBusiness').modal('show');
}

function insertBusiness() {

    
    var formData = new FormData();

    var name = document.getElementById("name").value;
    var address = document.getElementById("address").value;
    var mail = document.getElementById("mail").value;
    var phone = document.getElementById("phone").value;
    var intro = document.getElementById("intro").value;
    var str = '';
    if (name.trim() === '')
        str += "name ";
    if (address.trim() === '')
        str += "address ";
    if (mail.trim() === '')
        str += "mail ";
    if (phone.trim() === '')
        str += "phone ";
    if (intro.trim() === '')
        str += "intro ";
    if (! (str === '')) {
        alert('all input ' + str + 'must be filled!!!');
        return;
    }
    var fileInput = document.querySelector('input[name="photo"]');
    var file = fileInput.files[0];

    formData.append('photo', file);
    formData.append('name', name);
    formData.append('address', address);
    formData.append('mail', mail);
    formData.append('phone', phone);
    formData.append('intro', intro);
    //formData.append('PostID', PostID);
    $.ajax({
        url: "/SocialNetworkIRCNV/AddBusiness",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            if (data === "null")
                alert("!!!Somthing wrong happen!!!");
            else {
                location.reload();
            }
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}
