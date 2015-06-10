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
    
    public static final String MANAGERMENT_PAGE = "manageProductStatusPage.jsp";
    public static final String PAYMENT_PAGE = "paymentPage.jsp";
    public static final String CANCEL_PAGE = "cancelProductPage.jsp";
    public static final String ORDERED_PAGE = "viewOrderedCustomerPage.jsp";
    
    public static final String SEARCH_PRODUCT_STATUS_SERVLET = "SearchProductStatusServlet";
    public static final String CANCEL_PRODUCT_SERVLET = "CancelProductServlet";
    public static final String MANAGERMENT_SERVLET = "LoadManageProductPageServlet";
    public static final String LOAD_PAYMENT_SERVLET = "LoadPaymentPageServlet";
    public static final String SESSION_TIME_OUT_PAGE = "errorPage.jsp";
    public static final String SUCCESS_ACTION_PAGE = "successPage.jsp";
}
