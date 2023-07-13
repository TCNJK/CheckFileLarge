/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

const likeButton = document.querySelector('.like-button');
const reactions = document.querySelector('.reactions');
function like(ObejectID, Type) {

    $.ajax({
        url: "/SocialNetworkIRCNV/LikeObject",
        type: "POST",
        data: {ObejectID: ObejectID, Type: Type},
        success: function (data) {
            if (data === null) {
                alert("you must login to interface with social media");
            } else {
                var obeject = document.getElementById(ObejectID);
                    obeject.innerHTML = data;
                /*if (ObejectID.startsWith("CID") || ObejectID.startsWith("ILD")) {
                    var obeject = document.getElementById('comment-' + ObejectID);
                    obeject.innerHTML = data;
                } else {
                    var obeject = document.getElementById(ObejectID);
                    obeject.innerHTML = data;
                }*/
            }

        },
        error: function (xhr) {
            console.log("?ã x?y ra l?i: ");
        }
    });
}
