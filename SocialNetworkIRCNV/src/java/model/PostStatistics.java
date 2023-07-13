package model;

public class PostStatistics {

    String month;
    int postNumber;

    public PostStatistics(String month, int postNumber) {
        this.month = month;
        this.postNumber = postNumber;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getPostNumber() {
        return postNumber;
    }

    public void setPostNumber(int postNumber) {
        this.postNumber = postNumber;
    }

}