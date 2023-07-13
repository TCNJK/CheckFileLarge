function loadMorePost(type, UID, offset) {
    var offsett = document.getElementById('offset');
    var post = document.getElementById('post');
    var btnloadmore = document.getElementById('btnloadmore');
    $.ajax({
        url: "/SocialNetworkIRCNV/GetLoadPost",
        type: "POST",
        data: {type: type, UID: UID, offset: offset},
        success: function (data) {
            if (data === "usernull") {
                btnloadmore.innerHTML = 'That all post of user';
            }else if(data==='infonull'){
                btnloadmore.innerHTML = 'That all of your post: ';
            }else if(data==='homenull'){
                btnloadmore.innerHTML = 'Maybe you post some post or need add friend';
            }
            else {
                var currentOffset = parseInt(offsett.innerHTML);
                offsett.innerHTML = currentOffset + 1;
                post.innerHTML =  post.innerHTML + data;
            }
//            var currentOffset = parseInt(offsett.innerHTML);
//            offsett.innerHTML = currentOffset + 1;
//            post.innerHTML = currentOffset+1;
        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}
