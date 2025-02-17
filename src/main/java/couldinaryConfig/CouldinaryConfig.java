/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package couldinaryConfig;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class CouldinaryConfig {

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
