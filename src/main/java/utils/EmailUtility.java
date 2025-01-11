/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.mail.MessagingException;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Authenticator;
import jakarta.mail.Session;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EmailUtility {

    public static void sendEmail(String recipient, String subject, String content) throws MessagingException {
        String host = "smtp.gmail.com";
        String port = "587";
        final String user = "huyhoang23112004ct@gmail.com";  // email của bạn
        final String password = "kank gxqh qqib lbjd";  // mật khẩu ứng dụng của Gmail

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);
    }

    public static void main(String[] args) throws MessagingException {
        String recipient = "hwang.huyhoang@gmail.com";
        String subject = "Haloo";
        String content = "welcome!";

        sendEmail(recipient, subject, content);
    }
}
