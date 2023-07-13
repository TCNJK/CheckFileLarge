/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function reply(CmtID, name) {
    var btn = document.getElementById('button-load-comment');
    var content = document.getElementById("NewPostTextarea");
    btn.setAttribute('onclick', 'loadComment(\'' + CmtID + '\')');
    content.value = '@' + name + ' ' + content.value;
}
function loadComment(id) {
    //id có thể là PostID hoặc là CmtID tùy thuộc vào nó là comment hay commentChild
    var fileInput = document.querySelector('input[name="photo"]');
    var file = fileInput.files[0];
    var formData = new FormData();
    var content = document.getElementById("NewPostTextarea").value;
    var previewImage = document.getElementById('previewImage');
    formData.append('photo', file);
    formData.append('content', content);
    formData.append('id', id);
    //formData.append('PostID', PostID);
    $.ajax({
        url: "/SocialNetworkIRCNV/NewComment",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            var row = document.getElementById('comment-' + id);
            row.innerHTML = row.innerHTML + data;
            previewImage.style = "display: none";
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}
function loadmorecomment(id, offset) {
    var contain = document.getElementById('comment-' + id);
    var btn = document.getElementById('btn-' + id);
    //formData.append('PostID', PostID);
    $.ajax({
        url: "/SocialNetworkIRCNV/LoadComment",
        type: "POST",
        data: {id: id, offset: offset},
        success: function (data) {
            if (data === 'null') {
                btn.innerHTML = '';
            } else {
                var currentOffset = parseInt(offset);
                currentOffset = currentOffset + 1;
                contain.innerHTML = contain.innerHTML + data;
                btn.setAttribute('onclick', 'loadmorecomment(\'' + id + '\', \'' + currentOffset + '\')');
            }
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}

function askDeleteComment(id) {
    if (confirm("!!!Do you want to delete this comment!!!"))
        deleteComment(id);
}
function askUpdateComment(id) {
    if (confirm("!!!Do you want to Update this comment!!!"))
        updateComment(id);
}

function deleteComment(id) {
    var contain = document.getElementById('comment-' + id);
    //formData.append('PostID', PostID);
    $.ajax({
        url: "/SocialNetworkIRCNV/DeleteOrUpdateComment",
        type: "POST",
        data: {id: id, type: "delete"},
        success: function (data) {
            if (data === 'null') {
                alert("You can't delete this comment");
            } else {
                contain.innerHTML = "";
            }
        },
        error: function (xhr) {
            alert("Something wrong");
        }
    });
}
function updateComment(id) {
    var contain = document.getElementById('update-' + id);
    var fileInput = document.querySelector('input[name="photo"]');
    var file = fileInput.files[0];
    var formData = new FormData();
    formData.append('photo', file);
    formData.append('id', id);
    formData.append('type', 'update');
    //formData.append('PostID', PostID);
    $.ajax({
        url: "/SocialNetworkIRCNV/DeleteOrUpdateComment",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            if (data === 'null') {
                alert("You can't update this comment");
            } else {
                contain.innerHTML = "";
            }
        },
        error: function (xhr) {
            alert("Something wrong");
        }
    });
}