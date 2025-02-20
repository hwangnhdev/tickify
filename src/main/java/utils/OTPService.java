/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import redis.clients.jedis.Jedis;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class OTPService {

    private static final Jedis jedis = new Jedis("localhost", 6379);
    
    public static void main(String[] args) {
        System.out.println("Kết nối Redis thành công!");
        System.out.println("Kiểm tra kết nối: " + jedis.ping()); // PONG -> Thành công
    }

    // Lưu OTP với thời gian hết hạn
    public void saveOTP(String email, String otp) {
        jedis.setex("otp:" + email, 300, otp); // Lưu OTP với thời gian sống 300 giây (5 phút)
    }

    // Kiểm tra OTP hợp lệ không
    public boolean isValidOTP(String email, String otp) {
        String storedOtp = jedis.get("otp:" + email);
        return otp.equals(storedOtp);
    }

    public void deleteOTP(String email) {
        jedis.del("otp:" + email);
    }
}
