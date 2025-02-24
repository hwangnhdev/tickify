/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class CloudinaryConfig {

    private static final String DB_URL = "";
    private static final String DB_USER = "";
    private static final String DB_PASSWORD = "";

    private static final String CLOUD_NAME = "dnvpphtov";
    private static final String API_KEY = "361735526766643";
    private static final String API_SECRET = "tqw6jzCoHlzq4FN9Vusrbllobio";

    public static Cloudinary getInstance() {
        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", CLOUD_NAME,
                "api_key", API_KEY,
                "api_secret", API_SECRET,
                "secure", true
        ));
    }
}
