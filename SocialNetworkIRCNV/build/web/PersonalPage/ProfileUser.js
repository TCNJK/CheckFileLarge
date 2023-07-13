
document.addEventListener('DOMContentLoaded', function () {
    var offsett = document.getElementById('offset');
    var post = document.getElementById('post');
    var UID = document.getElementById('UID');
    var btnloadmore = document.getElementById('btnloadmore');
    $.ajax({
        url: "/SocialNetworkIRCNV/GetLoadPost",
        type: "POST",
        data: {type: 'profileuser', UID: UID.innerHTML, offset: '1'},
        success: function (data) {
            if (data === "null") {
                btnloadmore.innerHTML = 'User didnt have any post: ' + UID.innerHTML;
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