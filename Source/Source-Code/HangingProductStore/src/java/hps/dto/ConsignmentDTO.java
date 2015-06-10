/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

/**
 *
 * @author Tien Dan
 * modify Cong Duc
 */
public class ConsignmentDTO {
    private String consigmentID;
    private int productID;
    private int memberID;
    private int storeOwnerID;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String paypalAccount;
    private String cardNumber;
    private String cardOwner;
    private String fromDate;
    private String toDate;
    private String raiseWebDate;
    private int period;
    private double maxPrice;
    private double returnPrice;
    private String receivedDate;
    private String createdDate;
    private int consignmentStatusID;
    private String status;
    
    private ProductDTO product;

    public ConsignmentDTO() {
    }

    public ConsignmentDTO(String consigmentID, int productID, int memberID, int storeOwnerID, String name, String address, String phone, String email, String cardNumber, String cardOwner, String fromDate, String status, int period, double maxPrice) {
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
    
    //duchc - contructor dùng cho Consign Servlet
    public ConsignmentDTO(String consigmentID, int productID, int memberID, int storeOwnerID, String name, String address, String phone, String email, String cardNumber, String cardOwner, String fromDate, String toDate, String status, int period, double maxPrice) {
        this.consigmentID = consigmentID;
        this.productID = productID;
        this.memberID = memberID;
        this.storeOwnerID = storeOwnerID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.period = period;
        this.maxPrice = maxPrice;
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

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardOwner() {
        return cardOwner;
    }

    public void setCardOwner(String cardOwner) {
        this.cardOwner = cardOwner;
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

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public double getReturnPrice() {
        return returnPrice;
    }

    public void setReturnPrice(double returnPrice) {
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
}
