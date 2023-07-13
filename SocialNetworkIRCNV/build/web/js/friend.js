
function relate(Type, UID) {
    var friendstatus = document.getElementById('friendstatus');
    $.ajax({
        url: "/SocialNetworkIRCNV/ModifyRelation",
        type: "POST",

        data: {Type: Type, UID: UID},
        success: function (data) {

            if (data === "null") {
                alert('Request Fail');
            } else {
                friendstatus.innerHTML = data;
            }

        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}
function askAgainUnfiend(Type, UID) {
    if (confirm("Are you sure to unfriend!!!")) {
        relate(Type, UID);
    }
}
function displayName(x) {
    x.setAttribute('style', 'display: block');
}
function hideName(x) {
    x.setAttribute('style', 'display: none');
}

