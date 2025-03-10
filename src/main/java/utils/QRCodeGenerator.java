/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class QRCodeGenerator {
    public static String generateQRCode(String data, String filePath) throws WriterException, IOException {
        int width = 300;
        int height = 300;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();

        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");

        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, width, height, hints);
        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

        return filePath;
    }
    
    public static byte[] generateQRCodeAsBytes(String data) throws WriterException, IOException {
        int width = 300;
        int height = 300;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, width, height);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);

        return outputStream.toByteArray(); // Trả về QR dưới dạng byte[]
    }

    public static void main(String[] args) {
        try {
            String qrData = "ticketId=123456;eventId=E001;userName=Nguyen Van C";
            String filePath = "D:/qrcode.png";
//            generateQRCode(qrData, filePath);
//            System.out.println(generateQRCodeAsBytes(qrData));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
