/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

/**
 *
 * @author HoangNHSE61007 modify Cong Duc
 */
public class ProductDTO {

    private int productID;
    private String name;
    private String serialNumber;
    private String purchasedDate;
    private int categoryID;
    private String brand;
    private String description;
    private String image;
    private int productStatusID;
    private float sellingPrice;
    private int parentCategoryID;
    private int orderID;
    //danqt - begin
    private String consignmentID;// for store owner management page
    private String receivedDate;
    private Float consignedPrice;
    //danqt - end

    public ProductDTO() {
    }

    //danqt - begin
    public ProductDTO(int productID, String productName, String receivedDate, String consignmentID, Float price, int productStatusID) {
        this.productID = productID;
        this.name = productName;
        this.receivedDate = receivedDate;
        this.consignmentID = consignmentID;
        this.consignedPrice = price;
        this.productStatusID = productStatusID;
    }
    public ProductDTO(int productID, String productName, String serialNumber, int categoryID, String brand, String description, String image) {
        this.productID = productID;
        this.name = productName;
        this.serialNumber = serialNumber;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
    }
    //danqt - end

    //ban cu anh huon DanqtDAO
    public ProductDTO(int productID, String name, int status, String description, float price, String image, String purchasedDate, int categoryID, int parentCategoryID, String brand, String serialNumber) {
        this.productID = productID;
        this.name = name;
        this.productStatusID = status;
        this.description = description;
        this.sellingPrice = price;
        this.image = image;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.parentCategoryID = parentCategoryID;
        this.brand = brand;
        this.serialNumber = serialNumber;
    }
    /*
     HoangNH     
     */

    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int productStatusID, float sellingPrice, int parentCategoryID, int orderID) {
        this.productID = productID;
        this.name = name;
        this.serialNumber = serialNumber;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.productStatusID = productStatusID;
        this.sellingPrice = sellingPrice;
        this.parentCategoryID = parentCategoryID;
        this.orderID = orderID;
    }

    // constructor all tham so moi
    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int productStatusID, float sellingPrice, int parentCategoryID, String consignmentID) {
        this.productID = productID;
        this.name = name;
        this.serialNumber = serialNumber;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.productStatusID = productStatusID;
        this.sellingPrice = sellingPrice;
        this.parentCategoryID = parentCategoryID;
        this.consignmentID = consignmentID;
    }

    public ProductDTO(String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int productStatusID) {
        this.name = name;
        this.serialNumber = serialNumber;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.productStatusID = productStatusID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getPurchasedDate() {
        return purchasedDate;
    }

    public void setPurchasedDate(String purchasedDate) {
        this.purchasedDate = purchasedDate;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public float getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(float sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public int getParentCategoryID() {
        return parentCategoryID;
    }

    public void setParentCategoryID(int parentCategoryID) {
        this.parentCategoryID = parentCategoryID;
    }

    public String getConsignmentID() {
        return consignmentID;
    }

    public void setConsignmentID(String consignmentID) {
        this.consignmentID = consignmentID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    /**
     * @return the receivedDate
     */
    public String getReceivedDate() {
        return receivedDate;
    }

    /**
     * @param receivedDate the receivedDate to set
     */
    public void setReceivedDate(String receivedDate) {
        this.receivedDate = receivedDate;
    }

    /**
     * @return the consignedPrice
     */
    public Float getConsignedPrice() {
        return consignedPrice;
    }

    /**
     * @param consignedPrice the consignedPrice to set
     */
    public void setConsignedPrice(Float consignedPrice) {
        this.consignedPrice = consignedPrice;
    }

    /**
     * @return the productStatusID
     */
    public int getProductStatusID() {
        return productStatusID;
    }

    /**
     * @param productStatusID the productStatusID to set
     */
    public void setProductStatusID(int productStatusID) {
        this.productStatusID = productStatusID;
    }

}
