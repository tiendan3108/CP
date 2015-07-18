/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.io.Serializable;

/**
 *
 * @author Tien Dan modify Cong Duc
 */
public class ConsignmentDTO implements Serializable {

    private String consigmentID;
    private int productID;
    private int memberID;
    private int storeOwnerID;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String paypalAccount;
    private String fromDate;
    private String toDate;
    private String raiseWebDate;
    private int period;
    private float maxPrice;
    private float minPrice;
    private float returnPrice;
    private String receivedDate;
    private String createdDate;

    private int consignmentStatusID;
    private String status;

    private ProductDTO product;

    //danqt - begin
    private float expiredFee;
    private int expiredDays;
    private int quantity;
    //danqt - end
    //duchc - begin 
    private AccountDTO storeOwner;
    private String cancelDate; // add on 25/6/2015
    private String reason;
    private float negotiatedPrice;
    private String appointmentDate;
    private String hour;
    // duchc - end

    // No Argument Constructor
    public ConsignmentDTO() {
    }

    // danqt
    public ConsignmentDTO(String consigmentID, int productID, int memberID, int storeOwnerID, String name, String address, String phone, String email, String paypalAccount, String fromDate, String toDate, String raiseWebDate, int period, double returnPrice, String receivedDate, String createdDate, int consignmentStatusID, ProductDTO product, float negotiatedPrice) {
        this.consigmentID = consigmentID;
        this.productID = productID;
        this.memberID = memberID;
        this.storeOwnerID = storeOwnerID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.raiseWebDate = raiseWebDate;
        this.period = period;
        this.negotiatedPrice = negotiatedPrice;
        this.receivedDate = receivedDate;
        this.createdDate = createdDate;
        this.consignmentStatusID = consignmentStatusID;
        this.product = product;
    }

    public ConsignmentDTO(String consigmentID, int productID, int memberID, int storeOwnerID, String name, String address, String phone, String email, String cardNumber, String cardOwner, String fromDate, String status, int period, float maxPrice) {
        this.consigmentID = consigmentID;
        this.productID = productID;
        this.memberID = memberID;
        this.storeOwnerID = storeOwnerID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.fromDate = fromDate;
        this.period = period;
        this.maxPrice = maxPrice;
    }

    //danqt - begin
    public ConsignmentDTO(String fullName, String phone, String address, String email) {
        this.name = fullName;
        this.phone = phone;
        this.address = address;
        this.email = email;
    }

    //danqt - end
    // duchc Consignment new constructor for consign step 11/6/2015
    public ConsignmentDTO(String consigmentID, int productID, int memberID, int storeOwnerID, String name, String address, String phone, String email, String paypalAccount, String fromDate, String toDate, int period, float minPrice, float maxPrice, String createdDate, int consignmentStatusID) {
        this.consigmentID = consigmentID;
        this.productID = productID;
        this.memberID = memberID;
        this.storeOwnerID = storeOwnerID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.period = period;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
        this.createdDate = createdDate;
        this.consignmentStatusID = consignmentStatusID;
    }

    public String getConsigmentID() {
        return consigmentID;
    }

    public void setConsigmentID(String consigmentID) {
        this.consigmentID = consigmentID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public int getStoreOwnerID() {
        return storeOwnerID;
    }

    public void setStoreOwnerID(int storeOwnerID) {
        this.storeOwnerID = storeOwnerID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPaypalAccount() {
        return paypalAccount;
    }

    public void setPaypalAccount(String paypalAccount) {
        this.paypalAccount = paypalAccount;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getRaiseWebDate() {
        return raiseWebDate;
    }

    public void setRaiseWebDate(String raiseWebDate) {
        this.raiseWebDate = raiseWebDate;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(float maxPrice) {
        this.maxPrice = maxPrice;
    }

    public double getReturnPrice() {
        return returnPrice;
    }

    public void setReturnPrice(float returnPrice) {
        this.returnPrice = returnPrice;
    }

    public String getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(String receivedDate) {
        this.receivedDate = receivedDate;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(String cancelDate) {
        this.cancelDate = cancelDate;
    }

    public int getConsignmentStatusID() {
        return consignmentStatusID;
    }

    public void setConsignmentStatusID(int consignmentStatusID) {
        this.consignmentStatusID = consignmentStatusID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(float minPrice) {
        this.minPrice = minPrice;
    }

    public AccountDTO getStoreOwner() {
        return storeOwner;
    }

    public void setStoreOwner(AccountDTO storeOwner) {
        this.storeOwner = storeOwner;
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
     * @return the expiredDays
     */
    public int getExpiredDays() {
        return expiredDays;
    }

    /**
     * @param expiredDays the expiredDays to set
     */
    public void setExpiredDays(int expiredDays) {
        this.expiredDays = expiredDays;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public float getNegotiatedPrice() {
        return negotiatedPrice;
    }

    public void setNegotiatedPrice(float negotiatedPrice) {
        this.negotiatedPrice = negotiatedPrice;
    }

    public String getHour() {
        return hour;
    }

    public void setHour(String hour) {
        this.hour = hour;
    }

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
    
    
}
