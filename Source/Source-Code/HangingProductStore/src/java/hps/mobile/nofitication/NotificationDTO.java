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
public class NotificationDTO {
    private String token;
    private String accountID;

    public NotificationDTO() {
    }

    public NotificationDTO(String token, String accountID) {
        this.token = token;
        this.accountID = accountID;
    }

    /**
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * @param token the token to set
     */
    public void setToken(String token) {
        this.token = token;
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
    
}
