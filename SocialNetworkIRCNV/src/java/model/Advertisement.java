/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dao.BusinessDAO;
import dao.InterFaceObjectDAO;

/**
 *
 * @author van12
 */
public class Advertisement extends Post {

    private String AdvertiserID, BusinessID, ImagePost;
    private int NumShare, NumOfShow;
    private String Status;
    private int quantity;
    private String IDUserCurrent;
    // 'ongoing'  : đang quảng cáo 
    // 'inactive' : đang tạm hoãn quảng cáo 

    public Advertisement(String AdvertiserID, String BusinessID, String Content, String ImagePost, String TimePost, int NumInterface, int NumComment, int NumShare, int NumOfShow, String Status, int quantity) {
        this.AdvertiserID = AdvertiserID;
        this.BusinessID = BusinessID;
        super.setContent(Content);
        if (ImagePost == null || ImagePost.trim().isEmpty()) {
            this.ImagePost = "";
        } else {
            this.ImagePost = "/SocialNetworkIRCNV/" + ImagePost;
        }
        super.setTimePost(TimePost);
        super.setNumInterface(NumInterface);
        super.setNumComment(NumComment);
        this.NumShare = NumShare;
        this.NumOfShow = NumOfShow;
        this.Status = Status;
        this.quantity = quantity;
        super.setPostID(AdvertiserID);
    }

    public Advertisement(String AdvertiserID, String BusinessID, String Content, String ImagePost, String TimePost, int NumInterface, int NumComment, int NumShare, int NumOfShow, String Status, int quantity, String IDUserCurrent) {
        this.AdvertiserID = AdvertiserID;
        this.BusinessID = BusinessID;
        super.setContent(Content);
        if (ImagePost == null || ImagePost.trim().isEmpty()) {
            this.ImagePost = "";
        } else {
            this.ImagePost = "/SocialNetworkIRCNV/" + ImagePost;
        }
        super.setTimePost(TimePost);
        super.setNumInterface(NumInterface);
        super.setNumComment(NumComment);
        this.NumShare = NumShare;
        this.NumOfShow = NumOfShow;
        this.Status = Status;
        this.quantity = quantity;
        this.IDUserCurrent = IDUserCurrent;
        super.setPostID(AdvertiserID);
    }

    public String getIDUserCurrent() {
        return IDUserCurrent;
    }

    public void setIDUserCurrent(String IDUserCurrent) {
        this.IDUserCurrent = IDUserCurrent;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAdvertiserID() {
        return AdvertiserID;
    }

    public void setAdvertiserID(String AdvertiserID) {
        this.AdvertiserID = AdvertiserID;
    }

    public String getBusinessID() {
        return BusinessID;
    }

    public void setBusinessID(String BusinessID) {
        this.BusinessID = BusinessID;
    }

    public String getImagePost() {
        return ImagePost;
    }

    public void setImagePost(String ImagePost) {
        this.ImagePost = ImagePost;
    }

    public int getNumShare() {
        return NumShare;
    }

    public void setNumShare(int NumShare) {
        this.NumShare = NumShare;
    }

    public int getNumOfShow() {
        return NumOfShow;
    }

    public void setNumOfShow(int NumOfShow) {
        this.NumOfShow = NumOfShow;
    }

    public String getStatus() {
        return Status;
    }

    public String getDivView() {
        return "<td class=\"post-image\">\n"
                + "    <img id=\"image-"+this.AdvertiserID+"\"style=\"width: 50px;\" src=\""+this.ImagePost+"\" alt=\"Không Có ?nh\">\n"
                + "</td>\n"
                + "<td id=\"content-"+this.AdvertiserID+"\">"+this.getContent()+" </td>\n"
                + "<td>"+this.getNumInterface()+"</td>\n"
                + "<td id=\"quantity-"+this.AdvertiserID+"\">"+this.getQuantity()+"</td>\n"
                + "<td id=\"status-"+this.AdvertiserID+"\">"+this.Status+"</td>\n"
                + "<td><a href=\"#\" onclick=\"postAds('"+this.AdvertiserID+"', '"+this.getBusinessID()+"')\" >Post</a>\n"
                + "    /<a href=\"#\" onclick=\"viewAds('"+this.AdvertiserID+"', '"+this.getBusinessID()+"')\">View</a>\n"
                + "    /<a href=\"#\" onclick=\"DeleteAds('"+this.AdvertiserID+"')\">Delete</a>\n"
                + "</td>";
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getUpdateDiv() {
        String href;
        BusinessDAO businessDAO = new BusinessDAO();
        Business business = businessDAO.getBusinessByBusinessID(BusinessID);
        if (IDUserCurrent.equalsIgnoreCase(business.getUserID())) {
            href = "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp\" style=\"display: inline\">\n";
        } else {
            href = "<a class=\"suggestion-href\" href=\"/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=" + business.getUserID() + "\" style=\"display: inline\">\n";
            //postAction = "<a href=\"#\" onclick=\"askReportPost('" + this.getPostID() + "', '"+IDUserCurrent+"')\">Report</a>\n";
        }
        InterFaceObject interFaceObject = new InterFaceObjectDAO().getInterFaceObjectByID(AdvertiserID, IDUserCurrent);
        return "            <div class=\"post-top\">\n"
                + "                <p style=\"display: none\">" + this.getAdvertiserID() + "</p>\n"
                + "                <div class=\"dp\" >\n"
                + "                    <img src=\"" + business.getImageAvatar() + "\" alt=\"\" style=\"width: 100%;\" >\n"
                + "                </div>\n"
                + "                <div class=\"post-info\">\n"
                + href
                + "                    <p class=\"name\" style=\"color: #003140\">" + business.getBrandName() + "</p>\n"
                + "        </a>"
                + "                    <span class=\"time\" style=\"color: #70d8ff\">" + "sponsored" + "</span>\n"
                + "                </div>\n"
                + "                <i class=\" dropdown fas fa-ellipsis-h\">\n"
                + "                    <div >\n"
                + "\n"
                + "                        <div class=\"dropdown-content\">\n"
                + "                        </div>\n"
                + "                    </div>\n"
                + "                </i>\n"
                + "            </div>\n"
                + "\n"
                + "            <div class=\"post-content\" style=\"text-align: center;\">\n"
                + "                <p style=\"text-align: left; word-wrap:break-word; margin-right: 20px;\">" + this.getContent().trim() + "</p>\n"
                + "                    <img src=\"" + this.getImagePost() + "\"style=\"margin: 0 auto; max-width: 100%\"/>\n"
                + "            </div>\n"
                + "            <div class=\"counter\">\n"
                + "                <div class=\"count-like\">\n"
                + "                    <span>" + this.getNumInterface() + "</span>\n"
                + "                </div>\n"
                /*+ "                <div class=\"count-cmt\">\n"
                + "                    <span>" + this.getNumComment() + "</span>\n"
                + "                </div>\n"
                + "                <div class=\"count-share\">\n"
                + "                    <span>" + this.getNumShare() + "</span>\n"
                + "                </div>\n"*/
                + "            </div>\n"
                + "\n"
                + "\n"
                + "            <div class=\"post-bottom\" style=\" width: 90%; color:  #00abfd; border-top: 1px #00587c solid; margin-left: 5%; padding: 0 5%;\">\n"
                + "                <div class=\"action\" onclick=\"like('" + AdvertiserID + "', '" + interFaceObject.getInterFaceID() + "')\">\n"
                + interFaceObject.getInterFaceDiv()
                + "                </div>\n"
                /*+ "                <div class=\"action\" onclick=\"openPost('" + AdvertiserID +"')\">\n"
                + "                    <a href=\"#writecomment\" style=\"text-decoration: none; color:  #00abfd;\">\n"
                + "                        <i class=\"far fa-comment\"></i>\n"
                + "                        <span>Comment</span>\n"
                + "                    </a>\n"
                + "                </div>\n"
                + "                <div class=\"action\" onclick=\"SharePost('" + AdvertiserID + "', '" + business.getImageAvatar() + "', '" + business.getBrandName() + "', '" + this.getContent().trim() + "', '" + this.getImagePost() + "')\">\n"
                + "                    <i class=\" dropdown fa fa-share\">\n"
                + "                    </i>\n"
                + "                    <span>Share</span>\n"
                + "                </div>\n"*/
                + "            </div>\n";
    }

    public String getDiv() {
        return "<div class=\"post\" style=\"margin: 10px; background: white; border-radius: 10px\" id=\"" + AdvertiserID + "\">\n"
                + getUpdateDiv()
                + "        </div>                  \n";
    }
}
