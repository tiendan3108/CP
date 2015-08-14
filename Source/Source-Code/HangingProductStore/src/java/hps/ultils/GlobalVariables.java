/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

/**
 *
 * @author Tien Dan
 */
public class GlobalVariables {

    public static final String LOGIN_PAGE = "login.jsp";
    public static final String MANAGE_AVAILABLE_PRODUCT_PAGE = "manageAvailableProduct.jsp";
    public static final String MANAGE_SOLD_PRODUCT_PAGE = "manageSoldProduct.jsp";

    public static final String AWS_ACCESS_KEY_ID = "AKIAJQUQ7BS6CDFYFMLA";// access key id from amazon
    public static final String AWS_SECRET_KEY = "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";// secret key from amazon, pair with access key
    public static final String ENDPOINT = "ecs.amazonaws.com";// location
    public static final String ASS_TAG = "danqt-20";// account given by amazon so we can send request.
    //role in account
    public static final String MEMBER = "member";
    public static final String STORE_OWNER = "storeOwner";
    public static final String ADMIN = "admin";
    public static final String GUEST = "guest";
    //status in account
    public static final String ACTIVE = "active";
    public static final String DEACTIVE = "deactive";
    //
    public static final String MANAGERMENT_PAGE = "manageProductStatus.jsp";
    public static final String STATISTIC_PAGE = "manageProductStatistic.jsp";
    public static final String SESSION_TIME_OUT_PAGE = "HomeServlet";

    public static final String MANAGERMENT_SERVLET = "ManageProduct";

    public static final int CONSIGNMENT_WAITING = 1;
    public static final int CONSIGNMENT_REFUSE = 2;
    public static final int CONSIGNMENT_ACCEPTED = 3;
    public static final int CONSIGNMENT_COMPLETED = 4;
    public static final int CONSIGNMENT_RECEIVED = 5;

    /*
     Servlet and jsp
     HoangNH  
     */
    //servlet
    public static final String LOGIN_SERVLET = "LoginServlet";
    public static final String LOGOUT_SERVLET = "LogoutServlet";
    public static final String HOME_SERVLET = "HomeServlet";
    public static final String VIEW_DETAIL_SERVLET = "ViewProductDetailServlet";
    public static final String PRODUCT_SERVLET = "ProductServlet";
    public static final String CONFIRM_ODER_SERVLET = "ConfirmOrderServlet";
    public static final String COMPLETE_ODER_SERVLET = "CompleteOrderServlet";
    //jsp
    public static final String HOME_PAGE = "home.jsp";
    public static final String VIEW_DETAIL_PAGE = "viewDetail.jsp";
    public static final String PRODUCT_PAGE = "product.jsp";
    public static final String CONFIRM_ORDER_PAGE = "confirmOrder.jsp";
    public static final String COMPLETE_ODER_PAGE = "completeOrder.jsp";
    public static final int VND_CURRENCY = 22000;

}
