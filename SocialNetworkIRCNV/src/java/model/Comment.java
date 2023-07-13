package model;

import model.InterFaceObject;
import java.util.ArrayList;

public class Comment {

    private String CmtID, UserID, PostID, Content, TimeComment, ImageComment;
    int NumInterface;
    ArrayList<CommentChild> commentChild;

    public Comment() {
    }

    public Comment(String CmtID, String UserID, String PostID, String Content, String TimeComment,
            String ImageComment, int NumInterface, ArrayList<CommentChild> commentChild) {
        this.CmtID = CmtID;
        this.UserID = UserID;
        this.PostID = PostID;
        this.Content = Content;

        if (!ImageComment.isEmpty()) {
            this.ImageComment = "/SocialNetworkIRCNV/" + ImageComment;
        } else {
            this.ImageComment = "";
        }

        this.TimeComment = TimeComment;
        this.NumInterface = NumInterface;
        this.commentChild = commentChild;
    }

    public Comment(String CmtID, String UserID, String PostID, String Content, String TimeComment,
            String ImageComment, int NumInterface) {
        this.CmtID = CmtID;
        this.UserID = UserID;
        this.PostID = PostID;
        this.Content = Content;

        if (!ImageComment.isEmpty()) {
            this.ImageComment = "/SocialNetworkIRCNV/" + ImageComment;
        } else {
            this.ImageComment = "";
        }

        this.TimeComment = TimeComment;
        this.NumInterface = NumInterface;

    }

    public String getCmtID() {
        return CmtID;
    }

    public void setCmtID(String CmtID) {
        this.CmtID = CmtID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getPostID() {
        return PostID;
    }

    public void setPostID(String PostID) {
        this.PostID = PostID;
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

    public ArrayList<CommentChild> getCommentChild() {
        return commentChild;
    }

    public void setCommentChild(ArrayList<CommentChild> commentChild) {
        this.commentChild = commentChild;
    }

    public String getDiv(String id) {
        String href = (!id.equalsIgnoreCase(this.getUserID())) ? "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + this.getUserID() + "\" style=\"display: inline\">\n" : "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp\" style=\"display: inline\">\n";

        String str = "";
        if (this.getImageComment() != null && !this.getImageComment().isEmpty()) {
            str = "<img src=\"" + this.getImageComment() + "\">\n";
        }

        User user = new dao.UserDAO().getUserByID(this.getUserID());
        InterFaceObject interFaceObject = new dao.InterFaceObjectDAO().getInterFaceObjectByID(this.CmtID, id);
        return "<ul><li id=\"comment-" + this.getCmtID() + "\">"
                + "    <div class=\"comment\" id=\"" + this.getCmtID() + "\">\n"
                + getUpdateDiv(id)
                + "    </div>\n"
                + "</li></ul>";
    }

    public String getUpdateDiv(String id) {
        String href = "";
        String commentAction = "";
        if (id.equalsIgnoreCase(this.getUserID())) {
            href = "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askDeleteComment('" + this.getCmtID() + "')\">Delete</a>\n"
                    + "                            <a href=\"#\" onclick=\"askUpdateComment('" + this.getCmtID() + "')\">Modify</a>\n";

        } else {
            href = "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + this.getUserID() + "\" style=\"display: inline\">\n";
            commentAction = "<a href=\"#\" onclick=\"askreportComment('" + this.getCmtID() + "', '" + id + "','1')\">Report</a>\n";
        }
        String str = "";
        if (this.getImageComment() != null && !this.getImageComment().isEmpty()) {
            str = "<img src=\"" + this.getImageComment() + "\">\n";
        }
        User user = new dao.UserDAO().getUserByID(this.getUserID());
        InterFaceObject interFaceObject = new dao.InterFaceObjectDAO().getInterFaceObjectByID(this.CmtID, id);
        System.out.println("comment-log: " + this.getTimeComment());
        return "        <div class=\"comment-img\">\n"
                + "            <img src=\"" + user.getImgUser() + "\" alt=\"\">\n"
                + "        </div>\n"
                + "        <div class=\"comment-content\">\n"
                + "            <div class=\"comment-details\">\n"
                + href
                + "                <h4 class=\"comment-name\">" + user.getFullName() + "</h4>\n"
                + "</a>"
                + "                <span class=\"comment-log\">" + this.getTimeComment() + "</span>\n"
                + "<i class=\" dropdown fas fa-ellipsis-h\">\n"
                + "                    <div >\n"
                + "\n"
                + "                        <div class=\"dropdown-content\">\n"
                + commentAction
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
                + "                    <div class=\"comment-likes-up\" onclick=\"like('" + this.getCmtID() + "', '" + interFaceObject.getInterFaceID() + "')\">\n"
                + "                        " + interFaceObject.getInterFaceDiv() + "\n"
                + "\n"
                + "                    </div>\n"
                + "                    <span>" + this.NumInterface + "</span>\n"
                + "                </div>\n"
                + "                <div class=\"comment-reply\" onclick=\"reply('" + this.getCmtID() + "', '" + user.getFullName() + "')\">\n"
                + "                    <a href=\"#!\">Reply</a>\n"
                + "                </div>\n"
                + "            </div>\n"
                + "        </div>\n";

    }
}
