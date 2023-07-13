/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function otherProfile(UID) {
    window.location.href = "/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + UID;
}
function openPost(PostID) {
    window.open("/SocialNetworkIRCNV/post?PostID=" + PostID, '_blank');
}
function openHref(URL) {
    window.location.href = URL;
}
