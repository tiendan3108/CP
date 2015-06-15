/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile;

/**
 *
 * @author HoangNHSE61007
 */
public class Account {

    private String accountID;
    private String password;

    public Account() {
    }

    public Account(String accountID, String password) {
        this.accountID = accountID;
        this.password = password;
    }

    /**
     * @return the username
     */
    public String getAccountID() {
        return accountID;
    }

    /**
     * @param username the username to set
     */
    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

}
