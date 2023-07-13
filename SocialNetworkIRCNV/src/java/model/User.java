/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

/**
 *
 * @author 84384
 */
public class User extends Person {

    private String Nation, imgUser, coverImg;
    private int NumFriend, NumPost;
    private Role role;
    private String intro;
    public User() {
    }

    public User(String FullName, String Mail, String DOB, boolean Gender) {
        super(FullName, Mail, DOB, Gender);
    }

    public User(String Nation, String imgUser) {
        this.Nation = Nation;
        this.imgUser = imgUser;

    }

    public User(String Nation, String imgUser, String UserID, String FullName, String Address, String Mail, String PhoneNumber, 
            String DOB, boolean Gender, int  NumFriend, int NumPost, String intro) {
        super(UserID, FullName, Address, Mail, PhoneNumber, DOB, Gender);
        this.Nation = Nation;
//        this.imgUser = "/SocialNetworkIRCNV/"+imgUser;
        if (imgUser == null || imgUser.trim().isEmpty()) {
            this.imgUser = "data:image/png;base64,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";
        } else {
            this.imgUser = "/SocialNetworkIRCNV/" + imgUser.replaceAll(" ", "%20");
        }
        this.NumFriend= NumFriend;
        this.NumPost= NumPost;
        this.intro= intro;
        //intro, Address
    }

    public User(String Nation, String imgUser, String coverImg, String UserID, String FullName, String Address, String Mail, String PhoneNumber, 
            String DOB, boolean Gender, int  NumFriend, int NumPost, String intro) {
        super(UserID, FullName, Address, Mail, PhoneNumber, DOB, Gender);
        this.Nation = Nation;
//         this.imgUser = "/SocialNetworkIRCNV/"+imgUser;
//          this.coverImg = "/SocialNetworkIRCNV/"+imgUser;
        if (imgUser == null || imgUser.trim().isEmpty()) {
            this.imgUser = "https://cdn-icons-png.flaticon.com/512/1946/1946429.png";
        } else {
            this.imgUser = "/SocialNetworkIRCNV/" + imgUser.replaceAll(" ", "%20");
        }
        if (coverImg == null || coverImg.trim().isEmpty()) {
            this.coverImg = "data:image/jpeg;base64,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";
        } else {
            this.coverImg = "/SocialNetworkIRCNV/" + coverImg.replaceAll(" ", "%20");
        }
         this.NumFriend= NumFriend;
        this.NumPost= NumPost;
        this.intro= intro;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public int getNumFriend() {
        return NumFriend;
    }

    public void setNumFriend(int NumFriend) {
        this.NumFriend = NumFriend;
    }

    public int getNumPost() {
        return NumPost;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public void setNumPost(int NumPost) {
        this.NumPost = NumPost;
    }

    public String getNation() {
        return Nation;
    }

    public void setNation(String Nation) {
        this.Nation = Nation;
     }

    public String getImgUser() {
        return imgUser;
    }

    public void setImgUser(String imgUser) {
        this.imgUser = imgUser;
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    @Override
    public String toString() {
        return super.toString() + "User{" + "Nation=" + Nation + ", imgUser=" + imgUser + ", coverImg=" + coverImg + '}';
    }

    public String getDivFriend() {
        return "<div class=\"col-md-6 col-xl-4\" onclick=\"otherProfile('" + this.getUserID() + "')\">\n" +
"                    <div class=\"card\">\n" +
"                        <div class=\"card-body\">\n" +
"                            <div class=\"media align-items-center\">\n" +
"                                <img src = \"" + this.getImgUser() + "\" class=\"avatar avatar-xl mr-3\">\n" +
"                                <div class=\"media-body overflow-hidden\">\n" +
"                                    <h5 class=\"card-text mb-0\">" + this.getFullName() + "</h5>\n" +
"                                    <p class=\"card-text text-uppercase text-muted\">" + this.Nation + "</p>\n" +
"                                </div>\n" +
"                                <i class=\"icon fa-regular fa-message\"></i>\n" +
"                                <i class=\"fa-solid fa-user-minus\"></i>  \n" +
"                                \n" +
"                            </div><a href=\"#\" class=\"tile-link\"></a>\n" +
"                            \n" +
"                        </div>\n" +
"                    </div>\n" +
"                </div>";
    }

}
