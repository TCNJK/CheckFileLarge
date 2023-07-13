function report() {
    var rpID = document.getElementById('rpID').value;
    var userID = document.getElementById('userID').value;
    var isPost = document.getElementById('isPost').value;
    var action = document.getElementById('action').value;

    if (action === 'post') {
        reportPost(rpID, userID);
    } else if (action === 'comment') {
        reportComment(rpID, userID, isPost);
    } else if (action === 'user') {
        reportUser(rpID, userID);
    }
}

function reportPost(rpID, userID) {
    var data = {
        rpID: rpID,
        userID: userID
    };

    // Gửi yêu cầu Ajax tới Servlet
    $.ajax({
        url: '../../AddPostReport',
        type: 'POST',
        data: data,
        success: function (response) {
            // Xử lý phản hồi từ Servlet nếu cần
            console.log('Báo cáo bài viết thành công');
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi nếu có
            console.log('Lỗi yêu cầu: ' + error);
        }
    });
}

function reportComment(rpID, userID, isPost) {
    var data = {
        rpID: rpID,
        userID: userID,
        isPost: isPost
    };

    // Gửi yêu cầu Ajax tới Servlet
    $.ajax({
        url: '../../AddCommentReport',
        type: 'POST',
        data: data,
        success: function (response) {
            // Xử lý phản hồi từ Servlet nếu cần
            console.log('Báo cáo bài viết thành công');
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi nếu có
            console.log('Lỗi yêu cầu: ' + error);
        }
    });
}

function reportUser(rpID, userID) {
    var data = {
        rpID: rpID,
        userID: userID,
    };

    // Gửi yêu cầu Ajax tới Servlet
    $.ajax({
        url: '../../AddUserReport',
        type: 'POST',
        data: data,
        success: function (response) {
            // Xử lý phản hồi từ Servlet nếu cần
            console.log('Báo cáo bài viết thành công');
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi nếu có
            console.log('Lỗi yêu cầu: ' + error);
        }
    });
}
