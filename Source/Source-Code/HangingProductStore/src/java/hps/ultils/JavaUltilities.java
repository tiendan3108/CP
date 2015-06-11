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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

/**
 *
 * @author HoangNHSE61007
 */
public class JavaUltilities {

    //variable for sendSMS
    public static final String ACCOUNT_SID = "AC7bdbf5d4a7def7c808c8a2d90c49b490";
    public static final String AUTH_TOKEN = "5d878616bcd974db726aeff3f85d912c";
    //variable for sendEmail
    private static String USER_NAME = "HangingProductStore@gmail.com";  // GMail user name (just the part before "@gmail.com")
    private static String PASSWORD = "hps123456"; // GMail password
    //variable for random generate
    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static Random rnd = new Random();

    public static void main(String[] args) {
        String body = "<table >";
        body += "<tr><th>MONHANG</th><th>MON HANG</th></tr>";
        body += "<tr><td>123</td><td>234</td></tr>";
        body += "<tr><td>123</td><td>234</td></tr>";
        body += "</table>";
        JavaUltilities a = new JavaUltilities();
        a.sendEmail("HoangNHSE61007@fpt.edu.vn", "Test CSS", body);
    }
    public String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        }
        return sb.toString();
    }

    public void sendSMS(String content, String to) throws TwilioRestException {
        TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("To", to));
        params.add(new BasicNameValuePair("From", "+12568417673"));
        params.add(new BasicNameValuePair("Body", content));

        MessageFactory messageFactory = client.getAccount().getMessageFactory();
        Message message = messageFactory.create(params);
        System.out.println(message.getSid());
    }

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

            message.setSubject(subject,"utf-8");
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
}
