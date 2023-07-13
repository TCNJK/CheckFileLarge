function note(Type) {
    var offset = document.getElementById('offset-note');
    var friendcontainer= document.getElementById('notificationDropdown');
    $.ajax({
        url: "/SocialNetworkIRCNV/NoteReport",
        type: "POST",
        data: {Type: 'load', offset: offset.innerHTML},
        success: function (data) {

            if (data === "null") {
                 friendcontainer.innerHTML= friendcontainer.innerHTML+ 'You don\'t have any more post';
                 var btnLoad = document.getElementById('btn-load-note');
                btnLoad.remove();
            } else {
                 var btnLoad = document.getElementById('btn-load-note');
                btnLoad.remove();
                var currentOffset = parseInt(offset.innerHTML);
                offset.innerHTML = currentOffset + 1;
               friendcontainer.innerHTML= friendcontainer.innerHTML + data+' <button id="btn-load-note" onclick="note(\'load\')">load more note</button>';
            }
        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}
function notee(Type) {
    var offset = document.getElementById('offset-note');
    var friendcontainer= document.getElementById('notificationDropdown');
    $.ajax({
        url: "/SocialNetworkIRCNV/NoteReport",
        type: "POST",
        data: {Type: 'load', offset: offset.innerHTML},
        success: function (data) {

            if (data === "null") {
                 friendcontainer.innerHTML= friendcontainer.innerHTML+ 'You don\'t have any more post';
                 var btnLoad = document.getElementById('btn-load-note');
                btnLoad.remove();
            } else {
                 var btnLoad = document.getElementById('btn-load-note');
                btnLoad.remove();
                var currentOffset = parseInt(offset.innerHTML);
                offset.innerHTML = currentOffset + 1;
               friendcontainer.innerHTML= friendcontainer.innerHTML + data+' <button id="btn-load-note" onclick="notee(\'load\')">load more note</button>';
            }
        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}
function noteload(Type) {
    var offset = document.getElementById('offset-note');
    var friendcontainer= document.getElementById('notificationDropdown');
   
    $.ajax({
        url: "/SocialNetworkIRCNV/NoteReport",
        type: "POST",

        data: {Type: 'load', offset: offset.innerHTML },
        success: function (data) {
            
            
            if (data === "null") {
                friendcontainer.innerHTML= friendcontainer.innerHTML+'You don\'t have any more note';
                var btnLoad = document.getElementById('btn-load-note');
                btnLoad.remove();
            } else {
                
               var currentOffset = parseInt(offset.innerHTML);
                offset.innerHTML = currentOffset + 1;
               friendcontainer.innerHTML= data+' <button id="btn-load-note" onclick="notee(\'load\')">load more note</button>';
            }
        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}

