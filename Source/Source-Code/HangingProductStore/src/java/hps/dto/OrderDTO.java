/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.util.Date;

/**
 *
 * @author HoangNHSE61007
 */
public class OrderDTO {

    private String orderID;
    private int customerID;
    private Date date;
    private String email;
    private String fullName;
    private String address;
    private String phone;
    private float totalPrice;
    private int orderStatusID;
    private int productID;
    //begin danqt
    private String orderedDate;
    private float sendPrice;
    //end danqt

    public OrderDTO() {
    }

    public OrderDTO(String orderID, int customerID, Date date, String email, String fullName, String address, String phone, float totalPrice, int orderStatusID, int productID) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.date = date;
        this.email = email;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.totalPrice = totalPrice;
        this.orderStatusID = orderStatusID;
        this.productID = productID;
    }

    //danqt begin
    public OrderDTO(String orderID, String orderedDate, String email, String fullName, String address, String phone) {
        this.orderID = orderID;
        this.orderedDate = orderedDate;
        this.email = email;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
    }

    //danqt end

    /**
     * @return the orderID
     */
    public String getOrderID() {
        return orderID;
    }

    /**
     * @param orderID the orderID to set
     */
    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    /**
     * @return the customerID
     */
    public int getCustomerID() {
        return customerID;
    }

    /**
     * @param customerID the customerID to set
     */
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    /**
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the fullName
     */
    public String getFullName() {
        return fullName;
    }

    /**
     * @param fullName the fullName to set
     */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * @param phone the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * @return the totalPrice
     */
    public float getTotalPrice() {
        return totalPrice;
    }

    /**
     * @param totalPrice the totalPrice to set
     */
    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * @return the orderStatusID
     */
    public int getOrderStatusID() {
        return orderStatusID;
    }

    /**
     * @param orderStatusID the orderStatusID to set
     */
    public void setOrderStatusID(int orderStatusID) {
        this.orderStatusID = orderStatusID;
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
     * @return the orderedDate
     */
    public String getOrderedDate() {
        return orderedDate;
    }

    /**
     * @param orderedDate the orderedDate to set
     */
    public void setOrderedDate(String orderedDate) {
        this.orderedDate = orderedDate;
    }

    /**
     * @return the sendPrice
     */
    public float getSendPrice() {
        return sendPrice;
    }

    /**
     * @param sendPrice the sendPrice to set
     */
    public void setSendPrice(float sendPrice) {
        this.sendPrice = sendPrice;
    }

}
