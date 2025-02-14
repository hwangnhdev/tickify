/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package couldinaryConfig;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Map;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class CloudinaryUpload {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=TickifyDB;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123456";

    public static void uploadImageToEvent(int eventId, String imageUrl, String imageTitle) {
        CouldinaryConfig cloudinaryConfig = new CouldinaryConfig();
        Cloudinary cloudinary = cloudinaryConfig.getInstance();

        try {
            Map uploadResult;
            if (imageUrl.startsWith("http")) {
                // Upload trực tiếp từ URL nếu là link hợp lệ
                uploadResult = cloudinary.uploader().upload(imageUrl, ObjectUtils.emptyMap());
            } else {
                // Upload từ file cục bộ
                File file = new File(imageUrl);
                uploadResult = cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
            }

            String uploadedImageUrl = uploadResult.get("secure_url").toString();

            // Lưu vào SQL Server
            try ( Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);  PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO EventImages (event_id, image_url, image_title) VALUES (?, ?, ?)")) {
                pstmt.setInt(1, eventId);
                pstmt.setString(2, uploadedImageUrl);
                pstmt.setString(3, imageTitle);
                pstmt.executeUpdate();
                System.out.println("Store image into database successfully: " + uploadedImageUrl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        uploadImageToEvent(14,
                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image3.webp",
                "Music banner");
        uploadImageToEvent(15,
                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image4.jpg",
                "Music banner");
    }
}
