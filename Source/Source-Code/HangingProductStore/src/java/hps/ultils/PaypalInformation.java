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
public class PaypalInformation {

    private final String cmd = "_xclick";
    private final String business = "tien_dan2006-facilitator@yahoo.com";
    private final String returnURL = "http://localhost:8084/HangingProductStore/SoldProduct";
    private final int rm = 2;
    private final String item_name = "Thanh toan hang ki gui voi ma ";
    private final int item_number = 1;
    private final String currency_code = "USD";
    private final int exchangeRate = 22000;

    public PaypalInformation() {
    }

    /**
     * @return the cmd
     */
    public String getCmd() {
        return cmd;
    }

    /**
     * @return the business
     */
    public String getBusiness() {
        return business;
    }

    /**
     * @return the returnURL
     */
    public String getReturnURL() {
        return returnURL;
    }

    /**
     * @return the rm
     */
    public int getRm() {
        return rm;
    }

    /**
     * @return the item_name
     */
    public String getItem_name() {
        return item_name;
    }

    /**
     * @return the item_number
     */
    public int getItem_number() {
        return item_number;
    }

    /**
     * @return the currency_code
     */
    public String getCurrency_code() {
        return currency_code;
    }

    /**
     * @return the exchangeRate
     */
    public int getExchangeRate() {
        return exchangeRate;
    }
    
}
