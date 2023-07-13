/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author 84384
 */
public class Send {
//String user="ircnvsocialnetwork@gmail.com";
    // String pass= "hnixdtpcfwjedvvt";

    final static String user = "ircnvsocialnetwork@gmail.com";
    final static String pass = "abvicwbypkycpkal";

    public void sendEmail(String emailTo, String emailSubject, String emailContent) {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.starttls.required", "true");
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
        //ngocan2002@gmail.com
//        String emailTo= "ngocan2002@gmail.com";
//        String emailSubject= "chi la 1 chiec mail tao lao";
//        String emailContent= "an yeu viet, viet yeu an <3";   

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipient(
                    Message.RecipientType.TO,
                    InternetAddress.parse(emailTo.trim())[0]
            );
            message.setSubject(emailSubject);
            message.setText(emailContent);
            Transport.send(message);
            System.out.println("done");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void sendMailForgotPass(String mail, String name, String code) {
        try {
            String emailSubject = "VERIFY CODE FOR CONFIRM";
            String emailContent = "hello user " + name + " this is reset password code: " + code;
            sendEmail(mail, emailSubject, emailContent);
        } catch (Exception e) {
            System.out.println("controller.GMAIL.sendMailForgotPass()");
            e.printStackTrace();
        }

    }
public void sendMailCheckSignUp(String mail, String name, String code) {
        try {
            String emailSubject = "VERIFY CODE FOR SIGNUP";
            String emailContent = "hello user " + name + " thank you for your enjoy us \n this is your mail code: " + code;
            sendEmail(mail, emailSubject, emailContent);
        } catch (Exception e) {
            System.out.println("controller.GMAIL.sendMailCheckSignUp()");
            e.printStackTrace();
        }

    }
    public void sendEmail(ArrayList<String> emailTo, String emailSubject, String emailContent) {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.starttls.required", "true");
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
        //ngocan2002@gmail.com
//        String emailTo= "ngocan2002@gmail.com";
//        String emailSubject= "chi la 1 chiec mail tao lao";
//        String emailContent= "an yeu viet, viet yeu an <3";   
        for (int i = 0; i < emailTo.size(); i++) {
            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(user));
                message.setRecipient(
                        Message.RecipientType.TO,
                        InternetAddress.parse(emailTo.get(i).trim())[0]
                );
                message.setSubject(emailSubject);
                message.setText(emailContent);
                Transport.send(message);
                System.out.println("done");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public static void main(String[] args) {

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.starttls.required", "true");
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//        prop.put("mail.smtp.starttls.required", "true");
//        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
        //ngocan2002@gmail.com
        String emailTo = "van123872000@gmail.com";
        String emailSubject = "chi la 1 chiec mail tao lao";
        String emailContent = "lol";
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipient(
                    Message.RecipientType.TO,
                    InternetAddress.parse(emailTo)[0]
            );
            message.setSubject(emailSubject);
            message.setText(emailContent);
            Transport.send(message);
            System.out.println("done");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
