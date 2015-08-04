/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.io.Serializable;

/**
 *
 * @author Tien Dan
 */
public class StatisticDTO implements Serializable {

    private String productName;
    private String consignorName;
    private float consignPrice;
    private float sellingPrice;
    private float returnPrice;
    private float cancelFee;
    private float expiredFee;
    private String actionDate;
    private float revenue;

    public StatisticDTO(String productName, String consignorName, float consignPrice, float returnPrice, float cancelFee, float expiredFee, float sellingPrice, String actionDate, float revenue) {
        this.productName = productName;
        this.consignorName = consignorName;
        this.consignPrice = consignPrice;
        this.returnPrice = returnPrice;
        this.cancelFee = cancelFee;
        this.expiredFee = expiredFee;
        this.sellingPrice = sellingPrice;
        this.actionDate = actionDate;
        this.revenue = revenue;
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the consignorName
     */
    public String getConsignorName() {
        return consignorName;
    }

    /**
     * @param consignorName the consignorName to set
     */
    public void setConsignorName(String consignorName) {
        this.consignorName = consignorName;
    }

    /**
     * @return the consignPrice
     */
    public float getConsignPrice() {
        return consignPrice;
    }

    /**
     * @param consignPrice the consignPrice to set
     */
    public void setConsignPrice(float consignPrice) {
        this.consignPrice = consignPrice;
    }

    /**
     * @return the returnPrice
     */
    public float getReturnPrice() {
        return returnPrice;
    }

    /**
     * @param returnPrice the returnPrice to set
     */
    public void setReturnPrice(float returnPrice) {
        this.returnPrice = returnPrice;
    }

    /**
     * @return the sellingPrice
     */
    public float getSellingPrice() {
        return sellingPrice;
    }

    /**
     * @param sellingPrice the sellingPrice to set
     */
    public void setSellingPrice(float sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    /**
     * @return the actionDate
     */
    public String getActionDate() {
        return actionDate;
    }

    /**
     * @param actionDate the receivedDate to set
     */
    public void setActionDate(String actionDate) {
        this.actionDate = actionDate;
    }

    /**
     * @return the cancelFee
     */
    public float getCancelFee() {
        return cancelFee;
    }

    /**
     * @param cancelFee the cancelFee to set
     */
    public void setCancelFee(float cancelFee) {
        this.cancelFee = cancelFee;
    }

    /**
     * @return the expiredFee
     */
    public float getExpiredFee() {
        return expiredFee;
    }

    /**
     * @param expiredFee the expiredFee to set
     */
    public void setExpiredFee(float expiredFee) {
        this.expiredFee = expiredFee;
    }

    /**
     * @return the revenue
     */
    public float getRevenue() {
        return revenue;
    }

    /**
     * @param revenue the revenue to set
     */
    public void setRevenue(float revenue) {
        this.revenue = revenue;
    }

}
