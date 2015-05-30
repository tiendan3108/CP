/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.util.Date;

/**
 *
 * @author Tien Dan
 */
public class ConsignmentDTO {
    
    private String consignmentID;
    private int productID;
    private String consignorID;
    private Date eceivedDate;
    private Date fromDate;
    private Date toDate;
    private String consigneeiD;
    private int status;
    private float price;

    public ConsignmentDTO() {
    }

    public ConsignmentDTO(String consignmentID, int productID, String consignorID, Date eceivedDate, Date fromDate, Date toDate, String consigneeiD, int status, float price) {
        this.consignmentID = consignmentID;
        this.productID = productID;
        this.consignorID = consignorID;
        this.eceivedDate = eceivedDate;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.consigneeiD = consigneeiD;
        this.status = status;
        this.price = price;
    }

    /**
     * @return the consignmentID
     */
    public String getConsignmentID() {
        return consignmentID;
    }

    /**
     * @param consignmentID the consignmentID to set
     */
    public void setConsignmentID(String consignmentID) {
        this.consignmentID = consignmentID;
    }

    /**
     * @return the productID
     */
    public int getProductID() {
        return productID;
    }

    /**
     * @param productID the productID to set
     */
    public void setProductID(int productID) {
        this.productID = productID;
    }

    /**
     * @return the consignorID
     */
    public String getConsignorID() {
        return consignorID;
    }

    /**
     * @param consignorID the consignorID to set
     */
    public void setConsignorID(String consignorID) {
        this.consignorID = consignorID;
    }

    /**
     * @return the eceivedDate
     */
    public Date getEceivedDate() {
        return eceivedDate;
    }

    /**
     * @param eceivedDate the eceivedDate to set
     */
    public void setEceivedDate(Date eceivedDate) {
        this.eceivedDate = eceivedDate;
    }

    /**
     * @return the fromDate
     */
    public Date getFromDate() {
        return fromDate;
    }

    /**
     * @param fromDate the fromDate to set
     */
    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    /**
     * @return the toDate
     */
    public Date getToDate() {
        return toDate;
    }

    /**
     * @param toDate the toDate to set
     */
    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    /**
     * @return the consigneeiD
     */
    public String getConsigneeiD() {
        return consigneeiD;
    }

    /**
     * @param consigneeiD the consigneeiD to set
     */
    public void setConsigneeiD(String consigneeiD) {
        this.consigneeiD = consigneeiD;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the price
     */
    public float getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(float price) {
        this.price = price;
    }
    
}
