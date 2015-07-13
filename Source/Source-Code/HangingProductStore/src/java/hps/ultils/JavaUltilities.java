/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.MessageFactory;
import com.twilio.sdk.resource.instance.Message;
import hps.dao.DanqtDAO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

/**
 *
 * @author HoangNHSE61007
 */
public class JavaUltilities {

    //variable for sendSMS
    public static final String ACCOUNT_SID = "ACb15cb41fd57f0cd02501f2f5ec985d68";
    public static final String AUTH_TOKEN = "ab930367c08c0b1d597dd2432d8ff272";
    //variable for sendEmail
    private static String USER_NAME = "HangingProductStore@gmail.com";  // GMail user name (just the part before "@gmail.com")
    private static String PASSWORD = "hps123456"; // GMail password
    //variable for random generate
    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static Random rnd = new Random();

    public static void main(String[] args) {
        try {
            JavaUltilities a = new JavaUltilities();
//        String body = "<table >";
//        body += "<tr><th>MONHANG</th><th>MON HANG</th></tr>";
//        body += "<tr><td>123</td><td>234</td></tr>";
//        body += "<tr><td>123</td><td>234</td></tr>";
//        body += "</table>";     
//        a.sendEmail("HoangNHSE61007@fpt.edu.vn", "Test CSS", body);
            //System.out.println(a.encodeImage("././web/assets/image/tag1.jpg"));
            //a.reduceQulityImage("././web/assets/image/adidas-supercolor.jpg", "././web/assets/image/adidas-supercolor1.jpg");
            a.sendSMS("test abc", "+841689191917");
        } catch (TwilioRestException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @author HoangNHSE61007 Create random String
     */
    public String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        }
        return sb.toString();
    }

    /**
     *
     * @author HoangNHSE61007 send SMS
     */
    public void sendSMS(String content, String to) throws TwilioRestException {
        TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("To", to));
        params.add(new BasicNameValuePair("From", "+16467989980"));
        params.add(new BasicNameValuePair("Body", content));

        MessageFactory messageFactory = client.getAccount().getMessageFactory();
        Message message = messageFactory.create(params);
        System.out.println(message.getSid());
    }

    /**
     *
     * @author HoangNHSE61007 send Email
     */
    public void sendEmail(String to, String subject, String body) {
        String from = USER_NAME;
        String pass = PASSWORD;
        String[] toEmail = {to};
        Properties props = System.getProperties();
        String host = "smtp.gmail.com";
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", from);
        props.put("mail.smtp.password", pass);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        Session session = Session.getDefaultInstance(props);
        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(from));
            InternetAddress[] toAddress = new InternetAddress[toEmail.length];

            // To get the array of addresses
            for (int i = 0; i < toEmail.length; i++) {
                toAddress[i] = new InternetAddress(toEmail[i]);
            }

            for (int i = 0; i < toAddress.length; i++) {
                message.addRecipient(javax.mail.Message.RecipientType.TO, toAddress[i]);
            }

            message.setSubject(subject, "utf-8");
            //message.setText(body);
            message.setContent(body, "text/html; charset=utf-8");
            Transport transport = session.getTransport("smtp");
            transport.connect(host, from, pass);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (AddressException ae) {
            ae.printStackTrace();
        } catch (MessagingException me) {
            me.printStackTrace();
        }
    }

    /**
     *
     * @author HoangNHSE61007 encode Image for mobile service
     */
    public String encodeImage(String filePath) {
        File image = new File(filePath);
        try {
            FileInputStream imageInFile = new FileInputStream(image);
            byte imageData[] = new byte[(int) image.length()];
            imageInFile.read(imageData);
            String imageDataString = Base64.encodeBase64String(imageData);
            return imageDataString;
        } catch (FileNotFoundException e) {
            System.out.println("file not found");
            e.printStackTrace();
        } catch (IOException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @author HoangNHSE61007 reduce image Qulity
     */
    public void reduceImageQulity(String inputFile, String outputFile) {

        try {
            float quality = 0.3f;

            Iterator iter = ImageIO.getImageWritersByFormatName("jpeg");

            ImageWriter writer = (ImageWriter) iter.next();

            ImageWriteParam iwp = writer.getDefaultWriteParam();

            iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);

            iwp.setCompressionQuality(quality);
            File file = new File(outputFile);
            FileImageOutputStream output = new FileImageOutputStream(file);
            writer.setOutput(output);
            FileInputStream inputStream = new FileInputStream(inputFile);
            BufferedImage originalImage = ImageIO.read(inputStream);

            IIOImage image = new IIOImage(originalImage, null, null);
            writer.write(null, image, iwp);
            writer.dispose();

            System.out.println("DONE");
        } catch (IOException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     *
     * @author format date from yyyy-MM-dd to dd-MM-yyyy
     */
    public String formatDateString(String dateString) {
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat df2 = new SimpleDateFormat("dd-MM-yyyy");
            Date date = df.parse(dateString);
            String result = df2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void deleteProductImage(String path, int productID) {
        DanqtDAO dao = new DanqtDAO();
        ProductDTO product = dao.getProductByID(productID);
        File image = new File(path + "\\" + product.getImage());
        try {
            image.delete();
            System.out.println("deleted file " + path + "\\" + product.getImage());
        } catch (Exception e) {
            System.out.println("can not delete file " + path + "\\" + product.getImage());
        }
    }

    public void sendSMSForExpiredProduct(String storeOwnerName) {
        DanqtDAO dao = new DanqtDAO();
        List<ConsignmentDTO> result = dao.remindConsignor();
        String subject = "[HPS] Hết hạn kí gửi";
        for (Iterator<ConsignmentDTO> item = result.iterator(); item.hasNext();) {
            ConsignmentDTO next = item.next();
            String sms = "Mon hang voi ma ki gui " + next.getConsigmentID() + " da qua han ki gui. "
                    + "Vui long lien he voi " + storeOwnerName + " de gia han ki gui hoac nhan lai hang";
            String email = "Xin chào " + next.getName() + "</br> Món hàng với mã kí gửi " + next.getConsigmentID() + " của bạn đã hết hạn kí gửi.</br>"
                    + " Vui lòng liên hệ với " + storeOwnerName + " để gia hạn kí gửi hoặc nhận lại hàng.</br> Trân trọng</br> HPS System";
            if (next.getPhone() != null) {
                try {
                    sendSMS(sms, next.getPhone());
                } catch (TwilioRestException ex) {
                    Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
                }
                catch (Exception ex) {
                    Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (next.getPhone() == null && next.getEmail() != null) {
                sendEmail(next.getEmail(), subject, email);
            }
        }
    }
}
