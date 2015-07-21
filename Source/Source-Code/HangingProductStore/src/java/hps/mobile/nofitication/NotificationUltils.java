/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile.nofitication;

import com.google.gson.Gson;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNHSE61007
 */
public class NotificationUltils {

    private static final String API_KEY = "AIzaSyAW0ZHDAJJ8_hKBz37EeHdqdumYxtZrxME";
    private static final String TO = "fsiENlf0Ir4:APA91bGjplwivH0lYdBm0CXvu8554MhpvSV-Had54_VMiDYICw5aD6duAfSiv7RqV4ZtxgVhaR0qqPTZGHDtyuX1qzavyBhlJ1_yhNZTiTV6n4FJEx5e51vO92xJI6ZJf9Wwj4VClaDl";

    public static void sendNotification(Notification nof) {
        Gson gson = new Gson();
        nof.setTo(TO);
        String result = gson.toJson(nof, Notification.class);
        try {
            URL url;
            url = new URL("https://android.googleapis.com/gcm/send");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Authorization", "key=" + API_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
//            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            // Send GCM message content.
            OutputStream outputStream = conn.getOutputStream();
            outputStream.write(result.getBytes());

            // Read GCM response.
            InputStream inputStream = conn.getInputStream();
            //System.out.println(inputStream.toString());
            
        } catch (Exception ex) {
            Logger.getLogger(NotificationUltils.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }
}
