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

    public static final String AWS_ACCESS_KEY_ID = "AKIAJQUQ7BS6CDFYFMLA";// access key id from amazon
    public static final String AWS_SECRET_KEY = "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";// secret key from amazon, pair with access key
    public static final String ENDPOINT = "ecs.amazonaws.com";// location
    public static final String ASS_TAG = "danqt-20";// account given by amazon so we can send request.
    public static final int NOT_AVAILABLE = 0;// consignor gives information about product but store owner not yet take it.
    public static final int ORDERED = 1;// some1 order this product but not yet buy it.
    public static final int SOLD = 2;// product is sold but not yet pay consignor.
    public static final int ON_WEB = 3;// product is on web and available for search function.
    public static final int OWNED = 4;// product is out of contract date and out of take back period. Now store owner own it.
    public static final int OUT_OF_DATE = 5;// product is out of contract date and still in take back period.
    public static final int CANCEL = 6;// consignor request cancel consignment and not yet take product back.
    public static final int RETURNED = 7;// product is returned to consignor.
    public static final int COMPLETED = 8;// product is sold and store owner pay consignor.
    public static final int CANCEL_ON_WEB = 9; //consignor request cancel consignment while product is on web
    public static final String MANAGERMENT_SERVLET = "ManageProductStatusServlet";
    public static final String MANAGERMENT_PAGE = "manageProductStatusPage.jsp";
    public static final String SEARCH_PRODUCT_STATUS = "SearchProductStatusServlet";
    public static final String CANCEL_PRODUCT_SERVLET = "CancelProductServlet";
    public static final String PAYMENT_PAGE = "paymentPage.jsp";
    public static final String LOAD_PAYMENT_SERVLET = "LoadPaymentPageServlet";
    public static final String PUBLISH_PAGE = "publishOnWeb.jsp";
    public static final String SESSION_TIME_OUT_PAGE = "errorPage.jsp";
    public static final String SUCCESS_ACTION_PAGE = "successPage.jsp";
}
