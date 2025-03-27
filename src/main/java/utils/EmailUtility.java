/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import configs.EmailConfig;
import com.google.zxing.WriterException;
import configs.CloudinaryConfig;
import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.activation.URLDataSource;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

import jakarta.mail.MessagingException;
import jakarta.mail.util.ByteArrayDataSource;
import java.io.IOException;
import java.net.URL;
import static utils.QRCodeGenerator.generateQRCode;
import static utils.QRCodeGenerator.generateQRCodeAsBytes;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EmailUtility {
    
    static String host = "smtp.gmail.com";
    static String port = "587";
    static String user = EmailConfig.EMAIL_USER;
    static String password = EmailConfig.EMAIL_PASS;

    public static void sendEmail(String recipient, String subject, String content) throws MessagingException {
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

    public static void sendEmailWithQRCode(String recipient, String subject, String content, String qrData) throws MessagingException, IOException, WriterException {
        // Configure email properties
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        // Create a new email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject(subject);

        // Create the email body
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(content);

//        // Generate QR code as byte array
//        byte[] qrCodeBytes = generateQRCodeAsBytes(qrData);
//
//        // Attach QR code image
//        MimeBodyPart imagePart = new MimeBodyPart();
//        DataSource dataSource = new ByteArrayDataSource(qrCodeBytes, "image/png");
//        imagePart.setDataHandler(new DataHandler(dataSource));
//        imagePart.setFileName("qrcode.png");

//        // Tạo QR code dưới dạng byte[]
//        byte[] qrCodeBytes = generateQRCodeAsBytes(qrData);
//
//        // Upload lên Cloudinary và lấy URL
//        String cloudinaryUrl = CloudinaryConfig.uploadQRCode(qrCodeBytes, qrData);

//        // Lưu URL vào database
//        saveQRCodeUrlToDatabase(qrData, cloudinaryUrl);

        // Đính kèm QR code từ Cloudinary vào email
        MimeBodyPart imagePart = new MimeBodyPart();
        DataSource dataSource = new URLDataSource(new URL(qrData));
        imagePart.setDataHandler(new DataHandler(dataSource));
        imagePart.setFileName("qrcode.png");

        // Gửi email
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(imagePart);
        message.setContent(multipart);

        Transport.send(message);
    }
    
    private static void saveQRCodeUrlToDatabase(String ticketId, String qrCodePath) {
//        String sql = "INSERT INTO ticket_qr (ticket_id, qr_code_path) VALUES (?, ?) ON DUPLICATE KEY UPDATE qr_code_path = VALUES(qr_code_path)";
//
//        try (Connection conn = DatabaseUtils.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, ticketId);
//            stmt.setString(2, qrCodePath);
//            stmt.executeUpdate();
//        }
    }

    public static void main(String[] args) throws MessagingException {
        try {
            // Create QR data
            String qrData = "ticketId=12345;eventId=E001;userName=Nguyen Van C";

            // Send email with QR code
            String recipient = "hwang.huyhoang@gmail.com";
            String subject = "Your Ticket!";
            String content = "Here is the QR code for your ticket. Please bring it with you to the event.";
            
            EmailUtility.sendEmailWithQRCode(recipient, subject, content, qrData);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
