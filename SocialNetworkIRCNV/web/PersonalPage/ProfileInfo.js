function relate(Type, UID) {
    var isfriend= "<div style='color: blue'><i class='fa-solid fa-user-check'></i> Your Friend </div>";
    var request= "<div style='color: black'><i class='fa-solid fa-people-arrows'></i> Requested </div>";
    var isNotFriend= "<div style='color: black'><i class='fa-solid fa-user-check'></i> Stranger </div>";
    var friendstatus= document.getElementById('friendstatus');
    $.ajax({
        url: "/SocialNetworkIRCNV/Relation",
        type: "POST",
        data: {Type: Type, UID: UID },
        success: function (data) {
            if(data=== "null"){
                alert('Request Fail');
            }else{
                friendstatus.innerHTML= data;
            }

        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}

document.addEventListener('DOMContentLoaded', function () {
    var offsett = document.getElementById('offset');
    var post = document.getElementById('post');
    var btnloadmore = document.getElementById('btnloadmore');
    $.ajax({
        url: "/SocialNetworkIRCNV/GetLoadPost",
        type: "POST",
        data: {type: 'profileinfo', UID: 'UID.innerHTML', offset: '1'},
        success: function (data) {
            if (data === "null") {
                btnloadmore.innerHTML = 'You didnt have any post: ';
            } else {
                var currentOffset = parseInt(offsett.innerHTML);
                offsett.innerHTML = currentOffset + 1;
                post.innerHTML =  post.innerHTML+data;
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