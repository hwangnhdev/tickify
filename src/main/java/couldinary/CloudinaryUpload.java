///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package couldinary;
//
//import com.cloudinary.Cloudinary;
//import com.cloudinary.utils.ObjectUtils;
//import java.io.File;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.util.Map;
//
///**
// *
// * @author Tang Thanh Vui - CE180901
// */
//public class CloudinaryUpload {
//
//    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=TickifyDB;trustServerCertificate=true";
//    private static final String DB_USER = "sa";
//    private static final String DB_PASSWORD = "123456";
//
//    public static void uploadImageToEvent(int eventId, String imageUrl, String imageTitle) {
//        CouldinaryConfig cloudinaryConfig = new CouldinaryConfig();
//        Cloudinary cloudinary = cloudinaryConfig.getInstance();
//
//        try {
//            Map uploadResult;
//            if (imageUrl.startsWith("http")) {
//                // Upload trực tiếp từ URL nếu là link hợp lệ
//                uploadResult = cloudinary.uploader().upload(imageUrl, ObjectUtils.emptyMap());
//            } else {
//                // Upload từ file cục bộ
//                File file = new File(imageUrl);
//                uploadResult = cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
//            }
//
//            String uploadedImageUrl = uploadResult.get("secure_url").toString();
//
//            // Lưu vào SQL Server
//            try ( Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);  PreparedStatement pstmt = conn.prepareStatement(
//                    "INSERT INTO EventImages (event_id, image_url, image_title) VALUES (?, ?, ?)")) {
//                pstmt.setInt(1, eventId);
//                pstmt.setString(2, uploadedImageUrl);
//                pstmt.setString(3, imageTitle);
//                pstmt.executeUpdate();
//                System.out.println("Store image into database successfully: " + uploadedImageUrl);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static void main(String[] args) {
////        uploadImageToEvent(1,
////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image1.jpg",
////                "Music banner");
////        uploadImageToEvent(32,
////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image2.jpg",
////                "Music banner");
//////        uploadImageToEvent(32,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image2.jpg",
//////                "Music banner");
//////        uploadImageToEvent(33,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image3.webp",
//////                "Music banner");
//////        uploadImageToEvent(34,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image4.webp",
//////                "Music banner");
//////        uploadImageToEvent(35,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image5.webp",
//////                "Music banner");
//////        uploadImageToEvent(36,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image6.webp",
//////                "Music banner");
//////        uploadImageToEvent(37,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image7.webp",
//////                "Music banner");
//////        uploadImageToEvent(38,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image8.webp",
//////                "Music banner");
//////        uploadImageToEvent(39,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image9.webp",
//////                "Music banner");
//////        uploadImageToEvent(40,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image10.webp",
//////                "Music banner");
//////        uploadImageToEvent(41,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image11.webp",
//////                "Music banner");
//////        uploadImageToEvent(42,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image12.webp",
//////                "Music banner");
//////        uploadImageToEvent(43,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image13.webp",
//////                "Music banner");
//////        uploadImageToEvent(44,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image14.webp",
//////                "Music banner");
//////        uploadImageToEvent(45,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image15.webp",
//////                "Music banner");
//////        uploadImageToEvent(46,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image16.webp",
//////                "Music banner");
//////        uploadImageToEvent(47,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image17.webp",
//////                "Music banner");
//////        uploadImageToEvent(48,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image18.jpg",
//////                "Music banner");
//////        uploadImageToEvent(49,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image19.jpg",
//////                "Music banner");
//////        uploadImageToEvent(50,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image20.jpg",
//////                "Music banner");
//////        uploadImageToEvent(51,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image21.jpg",
//////                "Music banner");
//////        uploadImageToEvent(52,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image22.jpg",
//////                "Music banner");
//////        uploadImageToEvent(53,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image23.jpg",
//////                "Music banner");
//////        uploadImageToEvent(54,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image24.jpg",
//////                "Music banner");
//////        uploadImageToEvent(55,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image25.jpg",
//////                "Music banner");
//////        uploadImageToEvent(56,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image26.jpg",
//////                "Music banner");
//////        uploadImageToEvent(57,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image27.jpg",
//////                "Music banner");
//////        uploadImageToEvent(58,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image28.jpg",
//////                "Music banner");
//////        uploadImageToEvent(59,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image29.jpg",
//////                "Music banner");
//////        uploadImageToEvent(60,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image30.jpg",
//////                "Music banner");
//////        uploadImageToEvent(61,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image11.webp",
//////                "Music banner");
//////        uploadImageToEvent(62,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image12.webp",
//////                "Music banner");
//////        uploadImageToEvent(63,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image13.webp",
//////                "Music banner");
//////        uploadImageToEvent(64,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image14.webp",
//////                "Music banner");
//////        uploadImageToEvent(65,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image15.webp",
//////                "Music banner");
//////        uploadImageToEvent(66,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image16.webp",
//////                "Music banner");
//////        uploadImageToEvent(67,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image17.webp",
//////                "Music banner");
//////        uploadImageToEvent(68,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image18.jpg",
//////                "Music banner");
//////        uploadImageToEvent(69,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image19.jpg",
//////                "Music banner");
//////        uploadImageToEvent(70,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image20.jpg",
//////                "Music banner");
//////        uploadImageToEvent(71,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image21.jpg",
//////                "Music banner");
//////        uploadImageToEvent(72,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image22.jpg",
//////                "Music banner");
//////        uploadImageToEvent(73,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image23.jpg",
//////                "Music banner");
//////        uploadImageToEvent(74,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image24.jpg",
//////                "Music banner");
//////        uploadImageToEvent(75,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image25.jpg",
//////                "Music banner");
//////        uploadImageToEvent(76,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image26.jpg",
//////                "Music banner");
//////        uploadImageToEvent(77,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image27.jpg",
//////                "Music banner");
//////        uploadImageToEvent(78,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image28.jpg",
//////                "Music banner");
//////        uploadImageToEvent(79,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image29.jpg",
//////                "Music banner");
//////        uploadImageToEvent(80,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image30.jpg",
//////                "Music banner");
//////        uploadImageToEvent(81,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image22.jpg",
//////                "Music banner");
//////        uploadImageToEvent(82,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image23.jpg",
//////                "Music banner");
//////        uploadImageToEvent(83,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image24.jpg",
//////                "Music banner");
//////        uploadImageToEvent(84,
//////                "D:/Semester5/SWP391/Code/tickify/src/main/webapp/images/image25.jpg",
//////                "Music banner");
////    }
////}
