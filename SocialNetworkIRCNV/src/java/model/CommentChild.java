/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class CommentChild {

    private String ChilID, UserID, CmtID, Content, TimeComment, ImageComment;
    int NumInterface;
    private String PostID;

    public CommentChild(){
        
    }
    public CommentChild(String ChilID, String UserID, String CmtID, String Content, String TimeComment, String ImageComment, int NumInterface, String PostID) {
        this.ChilID = ChilID;
        this.UserID = UserID;
        this.CmtID = CmtID;
        this.Content = Content;
        this.TimeComment = TimeComment;

        if(!ImageComment.isEmpty())
            this.ImageComment ="/SocialNetworkIRCNV/"+ ImageComment;
        else  this.ImageComment = "";
        this.NumInterface = NumInterface;
        this.PostID = PostID;
    }

    public String getPostID() {
        return PostID;
    }

    public void setPostID(String PostID) {
        this.PostID = PostID;
    }

    public String getChilID() {
        return ChilID;
    }

    public void setChilID(String ChilID) {
        this.ChilID = ChilID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getCmtID() {
        return CmtID;
    }

    public void setCmtID(String CmtID) {
        this.CmtID = CmtID;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public String getTimeComment() {
        return TimeComment;
    }

    public void setTimeComment(String TimeComment) {
        this.TimeComment = TimeComment;
    }

    public String getImageComment() {
        return ImageComment;
    }

    public void setImageComment(String ImageComment) {
        this.ImageComment = ImageComment;
    }

    public int getNumInterface() {
        return NumInterface;
    }

    public void setNumInterface(int NumInterface) {
        this.NumInterface = NumInterface;
    }

    public String getDiv(String id) {
        String str = "";
        if (this.getImageComment() != null && !this.getImageComment().isEmpty()) {
            str = "<img src=\"" + this.getImageComment() + "\">\n";
        }
        String href= "";
        String commentAction = "";
        if (id.equalsIgnoreCase(this.getUserID())) {
            href =  "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askDeleteComment('" + this.getChilID() + "')\">Delete</a>\n"
                    + "                            <a href=\"#\" onclick=\"askUpdateComment('" + this.getChilID() + "')\">Modify</a>\n";

        } else {
            href =  "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + this.getUserID() + "\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askreportComment('" + this.getChilID() + "', '" + id + "','1')\">Report</a>\n";
        }
        User user = new dao.UserDAO().getUserByID(this.getUserID());
        InterFaceObject interFaceObject = new dao.InterFaceObjectDAO().getInterFaceObjectByID(this.getChilID(), id);
        return "<ul><li id='comment-" + this.ChilID + "'>\n"
                + "    <div class=\"comment\" id='" + this.ChilID + "'>\n"
                + getUpdateDiv(id)
                + "        </div>\n"
                + "</li></ul>";
    }

    public String getUpdateDiv(String id) {
        String href= "";
        String commentAction = "";
        if (id.equalsIgnoreCase(this.getUserID())) {
            href =  "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askDeleteComment('" + this.getChilID() + "')\">Delete</a>\n"
                    + "                            <a href=\"#\" onclick=\"askUpdateComment('" + this.getChilID() + "')\">Modify</a>\n";

        } else {
            href =  "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + this.getUserID() + "\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askreportComment('" + this.getChilID() + "', '" + id + "','1')\">Report</a>\n";
        }
        String str = "";
        if (this.getImageComment() != null && !this.getImageComment().isEmpty()) {
            str = "<img src=\"" + this.getImageComment() + "\">\n";
        }
        User user = new dao.UserDAO().getUserByID(this.getUserID());
        InterFaceObject interFaceObject = new dao.InterFaceObjectDAO().getInterFaceObjectByID(this.getChilID(), id);
        return "        <div class=\"comment-img\">\n"
                + "            <img src=\"" + user.getImgUser() + "\" alt=\"\">\n"
                + "        </div>\n"
                + "        <div class=\"comment-content\">\n"
                + "            <div class=\"comment-details\">\n"
                + href
                + "                <h4 class=\"comment-name\">" + user.getFullName() + "</h4>\n"
                + "</a>"
                + "                <span class=\"comment-log\">" + this.getTimeComment() + "</span>\n"
                + "                <i class=\" dropdown fas fa-ellipsis-h\">\n"
                + "                    <div >\n"
                + "\n"
                + "                        <div class=\"dropdown-content\">\n"
                +commentAction
                + "                        </div>\n"
                + "                    </div>\n"
                + "                </i>\n"
                + "            </div>\n"
                + "            <div class=\"comment-desc\">\n"
                + "                <p>" + this.getContent() + "<br>\n"
                + str
                + "                </p>\n"
                + "            </div>\n"
                + "            <div class=\"comment-data\">\n"
                + "                <div class=\"comment-likes\">\n"
                + "                    <div class=\"comment-likes-up\" onclick=\"like('" + this.getChilID() + "', '" + interFaceObject.getInterFaceID() + "')\">\n"
                + interFaceObject.getInterFaceDiv()
                + "\n"
                + "                    </div>\n"
                + "                    <span>" + this.getNumInterface() + "</span>\n"
                + "                </div>\n"
                + "                <div class=\"comment-reply\" onclick=\"reply('" + this.getCmtID() + "', '" + user.getFullName() + "')\">\n"
                + "                    <a href=\"#!\">Reply</a>\n"
                + "                </div>\n"
                + "            </div>\n"
                + "    </div>\n";
    }
}
