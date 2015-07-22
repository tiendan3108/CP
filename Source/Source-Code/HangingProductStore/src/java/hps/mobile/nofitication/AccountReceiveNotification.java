/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile.nofitication;

/**
 *
 * @author HoangNHSE61007
 */
public class AccountReceiveNotification {
    private String accountID;
    private String gcmID;
    private int numOfProduct;

    public AccountReceiveNotification() {
    }

    public AccountReceiveNotification(String accountID, String gcmID, int numOfProduct) {
        this.accountID = accountID;
        this.gcmID = gcmID;
        this.numOfProduct = numOfProduct;
    }

    /**
     * @return the accountID
     */
    public String getAccountID() {
        return accountID;
    }

    /**
     * @param accountID the accountID to set
     */
    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    /**
     * @return the gcmID
     */
    public String getGcmID() {
        return gcmID;
    }

    /**
     * @param gcmID the gcmID to set
     */
    public void setGcmID(String gcmID) {
        this.gcmID = gcmID;
    }

    /**
     * @return the numOfProduct
     */
    public int getNumOfProduct() {
        return numOfProduct;
    }

    /**
     * @param numOfProduct the numOfProduct to set
     */
    public void setNumOfProduct(int numOfProduct) {
        this.numOfProduct = numOfProduct;
    }
    
}
