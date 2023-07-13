document.getElementById('fileInput').addEventListener('change', function (event) {
    var file = event.target.files[0];
    // T?o ??i t??ng FileReader ?? ??c t?p tin
    var reader = new FileReader();
    reader.onload = function (e) {
        var previewImage = document.getElementById('previewImage');
        previewImage.src = e.target.result;
        previewImage.style = "display: block; width:100%";
    };
    reader.readAsDataURL(file);
});
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


function clearFileInput() {
    document.getElementById('fileInput2').value = "";
    document.getElementById('imgPost').src = "";
}

function load(Type) {
//lấy dữ liệu ảnh    
    if (Type === 'Post') {
        var fileInput = document.querySelector('input[name="photo"]');
        var file = fileInput.files[0];
        var formData = new FormData();
        var content = document.getElementById("NewPostTextarea").value;
        var privacy = $("#privacy").val();
        var previewImage = document.getElementById('previewImage');
        formData.append('photo', file);
        formData.append('privacy', privacy);
        formData.append('content', content);
        formData.append('Type', Type);
        //formData.append('PostID', PostID);
        $.ajax({
            url: "/SocialNetworkIRCNV/NewPost",
            type: "POST",
            processData: false,
            contentType: false,
            data: formData,
            success: function (data) {
                var row = document.getElementById("post");
                row.innerHTML = data + row.innerHTML;
                previewImage.style = "display: none";
            },
            error: function (xhr) {
                console.log("?? x?y ra l?i: ");
            }
        });
    } else {
        var formData = new FormData();

        var PostID = document.getElementById("PostIDPostShareModel").value;
        var content = document.getElementById("contentPostShareModel").value;
        var privacy = $("#privacyPostShareModel").val();

        formData.append('PostID', PostID);
        formData.append('content', content);
        formData.append('privacy', privacy);
        formData.append('Type', Type);

        $.ajax({
            url: "/SocialNetworkIRCNV/NewPost",
            type: "POST",
            processData: false,
            contentType: false,
            data: formData,
            success: function (data) {
                location.reload();
                var row = document.getElementById("post");
                row.innerHTML = data + row.innerHTML;

            },
            error: function (xhr) {
                location.reload();
                console.log("?? x?y ra l?i: ");
            }
        });
    }
    ;
}
function deletePost(PostID, Type) {
    var post = document.getElementById(PostID);
    var postContain = document.getElementById("post");
    $.ajax({
        url: "/SocialNetworkIRCNV/DeletePost",
        type: "POST",
        data: {PostID: PostID, Type: Type},
        success: function (data) {
            if (data.trim() === "null") {
                alert("Can't delete other user post " + PostID);
                console.log("null");
            } else {
                //    alert("true " + PostID);
                if (post) {
                    post.setAttribute('style', 'display: none');
                    console.log("true");
                }
            }
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}

function changeInfo() {
    $('#changeinfo').modal('show');
}
function openchangeimageavatar() {
    $('#change-image-avatar').modal('show');
}
function openchangeimagebackground() {
    $('#change-image-background').modal('show');
}
function SharePost(PostIDown, imgUserDown, name_userDown, contentDown, img_postDown) {
    var imgUser = document.getElementById('imgUserDown');
    var content = document.getElementById('contentDown');
    var img_post = document.getElementById('img_postDown');
    var name_use = document.getElementById('name_userDown');
    var PostID = document.getElementById('PostIDPostShareModel');
    
    //////////////////////////////xử lí xuống dòng//////////////////////////////
        // Thay thế các lần xuống dòng bằng <br>
    let replacedLineBreaks = contentDown.replace(/\n/g, "<br>");

    // Tách các phần bằng dòng trống
    let sections = replacedLineBreaks.split("<br><br><br>");

    // Tạo một mảng các phần trong thẻ div
    let divSections = sections.map(section => `<div>${section}</div>`);

    // Kết hợp các phần đã được đặt trong thẻ div
    let result = divSections.join("<br>");
    //////////////////////////////kết thúc xử lí xuống dòng//////////////////////////////
     
    imgUser.src = imgUserDown;
    content.innerHTML = result;
    img_post.src = img_postDown;
    name_use.innerHTML = name_userDown;
    PostID.value = PostIDown;
    $('#modalShare').modal('show');
}
//document.addEventListener('DOMContentLoaded', function () {
//    // Lấy tất cả các phần tử <img> trên trang
//    var images = document.getElementsByTagName('img');
//
//    // Duyệt qua từng phần tử <img> và kiểm tra src
//    for (var i = 0; i < images.length; i++) {
//        var img = images[i];
//
//        // Kiểm tra nếu src của hình ảnh là rỗng
//        if (img.src === '') {
//            img.style.display = 'none'; // Ẩn hình ảnh
//        }
//    }
//});
function modifyPost(PostID, imgUser, Nameuser, timePost, Public, Content, imgPost) {
    var postID = document.getElementById('IDpost');
    var img_user = document.getElementById('imgUser');
    var Fullname = document.getElementById('FullNameU');
    var time = document.getElementById('timePost');
    var Publics = document.getElementById('isPublic');
    var content = document.getElementById('contentPost');
    var img_post = document.getElementById('imgPost');

    postID.innerHTML = PostID;
    img_user.src = imgUser;
    img_post.src = imgPost;
    Fullname.innerHTML = Nameuser;
    time.innerHTML = timePost;
    Publics.checked = Public;
    content.innerHTML = Content;

    $("#modifyModal").modal("show");

}
function loadUpdate() {
    var fileInput = document.querySelector('input[name="photoPost"]');
    var file = fileInput.files[0];
    var formData = new FormData();

    var IDpost = document.getElementById("IDpost");
    var contentPost = document.getElementById("contentPost").value;
    var privacy = document.getElementById("isPublic").value;
    var post = document.getElementById("post").innerHTML;

    formData.append('IDpost', IDpost.innerHTML);
    formData.append('photoPost', file);
    formData.append('isPublic', privacy);
    formData.append('contentPost', contentPost);
    $.ajax({
        url: "/SocialNetworkIRCNV/ModifyPost",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            IDpost.style.display = 'none';
            post = data + post;

        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
    location.reload(true);

}