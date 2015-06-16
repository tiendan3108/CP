/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile;

import com.google.gson.Gson;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
        int memberID = dao.getMemberID(account.getAccountID());
        if (memberID > 0) {
            return dao.getData(memberID);
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
