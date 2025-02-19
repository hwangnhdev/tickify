//package utils;
//
///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//
//import io.jsonwebtoken.*;
//import io.jsonwebtoken.security.Keys;
//import java.util.Date;
//import javax.crypto.SecretKey;
//
///**
// *
// * @author Nguyen Huy Hoang - CE182102
// */
//public class JwtUtil {
//    private static final SecretKey SECRET_KEY = KeySpec.secretKeyFor(SignatureAlgorithm.HS256); // Tạo khóa bí mật
//    private static final long EXPIRATION_TIME = 1000 * 60 * 30; // JWT hết hạn sau 30 phút
//
//    // Tạo JWT
//    public static String generateToken(String username) {
//        return Jwts.builder()
//                .setSubject(username)
//                .setIssuedAt(new Date())
//                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
//                .signWith(SECRET_KEY)
//                .compact();
//    }
//
//    // Giải mã JWT
//    public static String validateToken(String token) {
//        try {
//            return Jwts.parserBuilder()
//                    .setSigningKey(SECRET_KEY)
//                    .build()
//                    .parseClaimsJws(token)
//                    .getBody()
//                    .getSubject(); // Trả về username nếu hợp lệ
//        } catch (JwtException e) {
//            return null; // Token không hợp lệ
//        }
//    }
//}