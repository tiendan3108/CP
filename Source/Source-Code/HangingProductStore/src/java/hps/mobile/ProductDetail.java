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
public class ProductDetail {

    private int productID;
    private String productName;
    private String serialNumber;
    private String brand;
    private String description;
    private String image;
    private String customerName;
    private String address;
    private String phone;
    private float maxPrice;
    private float minPrice;
    private String appointmentDate;
    private String reason;
    private float negotiatedPrice;
    private String reviewProductDate;
    private String paypalAccountID;    

    public ProductDetail() {
    }

    public ProductDetail(int productID, String productName, String serialNumber, String brand, String description, String image, String customerName, String address, String phone, float maxPrice, float minPrice, String appointmentDate, String reviewProductDate) {
        this.productID = productID;
        this.productName = productName;
        this.serialNumber = serialNumber;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.maxPrice = maxPrice;
        this.minPrice = minPrice;
        this.appointmentDate = appointmentDate;
        this.reviewProductDate = reviewProductDate;
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
     * @return the serialNumber
     */
    public String getSerialNumber() {
        return serialNumber;
    }

    /**
     * @param serialNumber the serialNumber to set
     */
    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    /**
     * @return the brand
     */
    public String getBrand() {
        return brand;
    }

    /**
     * @param brand the brand to set
     */
    public void setBrand(String brand) {
        this.brand = brand;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the image
     */
    public String getImage() {
        return image;
    }

    /**
     * @param image the image to set
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * @return the customerName
     */
    public String getCustomerName() {
        return customerName;
    }

    /**
     * @param customerName the customerName to set
     */
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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
     * @return the minPrice
     */
    public float getMinPrice() {
        return minPrice;
    }

    /**
     * @param minPrice the minPrice to set
     */
    public void setMinPrice(float minPrice) {
        this.minPrice = minPrice;
    }

    /**
     * @return the maxPrice
     */
    public float getMaxPrice() {
        return maxPrice;
    }

    /**
     * @param maxPrice the maxPrice to set
     */
    public void setMaxPrice(float maxPrice) {
        this.maxPrice = maxPrice;
    }

    /**
     * @return the reason
     */
    public String getReason() {
        return reason;
    }

    /**
     * @param reason the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    /**
     * @return the negotiatedPrice
     */
    public float getNegotiatedPrice() {
        return negotiatedPrice;
    }

    /**
     * @param negotiatedPrice the negotiatedPrice to set
     */
    public void setNegotiatedPrice(float negotiatedPrice) {
        this.negotiatedPrice = negotiatedPrice;
    }

    /**
     * @return the appointmentDate
     */
    public String getAppointmentDate() {
        return appointmentDate;
    }

    /**
     * @param appointmentDate the appointmentDate to set
     */
    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    /**
     * @return the ReviewProductDate
     */
    public String getReviewProductDate() {
        return reviewProductDate;
    }

    /**
     * @param ReviewProductDate the ReviewProductDate to set
     */
    public void setReviewProductDate(String reviewProductDate) {
        this.reviewProductDate = reviewProductDate;
    }

}
