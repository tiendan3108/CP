/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile;

import com.google.gson.Gson;
import hps.ultils.JavaUltilities;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author HoangNHSE61007
 */
@Path("/MobileService")
public class MobileService {

    @Path("/login")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public String login(String input) {
        Gson gson = new Gson();
        Account account;
        account = gson.fromJson(input, Account.class);
        ProductDetailDAO dao = new ProductDetailDAO();
        int memberID = dao.checkLogin(account.getAccountID(), account.getPassword());
        if (memberID > 0) {
            //return dao.getData(memberID);
            return account.getAccountID();
        }
        return null;
    }

    @Path("/getData")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public List<ProductDetail> getData(String input) {
        Gson gson = new Gson();
        Account account;
        account = gson.fromJson(input, Account.class);
        ProductDetailDAO dao = new ProductDetailDAO();
        JavaUltilities lib = new JavaUltilities();
        int memberID = dao.getMemberID(account.getAccountID());
        if (memberID > 0) {
            List<ProductDetail> data = dao.getData(memberID);
            for (int i = 0; i < data.size(); i++) {
                ProductDetail productItem = data.get(i);
                String imagePath = productItem.getImage();
                String toDate = productItem.getToDate();
                String fromDate = productItem.getFromDate();
                String formatToDate = lib.formatDateString(toDate);
                String formatFromDate = lib.formatDateString(fromDate);
                if (imagePath != null) {
                    String path = "";
                    try {
                        path = java.net.URLDecoder.decode(getClass().getResource("/../../").getPath(), "UTF-8");
                    } catch (UnsupportedEncodingException ex) {
                        Logger.getLogger(MobileService.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    String imageCode = lib.encodeImage(path + imagePath);
                    productItem.setImage(imageCode);
                }
                productItem.setToDate(formatToDate);
                productItem.setFromDate(formatFromDate);
                data.set(i, productItem);
            }

            return data;
        }
        return null;
    }

    @Path("/updateData")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public String updateData(String input) {
        Gson gson = new Gson();
        ProductDetail product;
        product = gson.fromJson(input, ProductDetail.class);
        ProductDetailDAO dao = new ProductDetailDAO();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String newDate = df.format(date);
        dao.updateConsignment(product.getProductID(), newDate, product.getMinPrice(), product.getMaxPrice());
        dao.receiveProduct(product.getProductID());
        return "ok";
    }

    @Path("/cancelConsignment")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public String cancleConsignment(String input) {
        Gson gson = new Gson();
        ProductDetail product;
        product = gson.fromJson(input, ProductDetail.class);
        ProductDetailDAO dao = new ProductDetailDAO();
        dao.cancelConsignment(product.getProductID());
        return "ok";
    }
}
