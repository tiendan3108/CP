/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author HoangNHSE61007 modify Cong Duc
 */
public class ProductDTO implements Serializable {

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
    //danqt - begin
    private String consignmentID;// for store owner management page
    private String orderID;
    private String receivedDate;
    private String cancelDate;
    private float consignedPrice;
    private float minPrice;
    private float maxPrice;
    private String orderDate;
    private String customerPhone;
    private List<OrderDTO> orderList;
    private float negotiatedPrice;
    private List<Integer> seasonList;
    //danqt - end

//duchc - begin
    private String status; // for showing product status
    private String categoryName; // for showing category Name
    private String sellDate; // add on 25/6/2015
    private int isSpecial; // add on 22/7/2015
    //duchc - end

    public ProductDTO() {
    }

    //danqt - begin
    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int productStatusID, float sellingPrice, String orderDate, String customerPhone) {
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
        this.orderDate = orderDate;
        this.customerPhone = customerPhone;
    }

    public ProductDTO(String productName, String receivedDate, String consignmentID, float negotiatedPrice, String cancelDate) {
        this.name = productName;
        this.receivedDate = receivedDate;
        this.consignmentID = consignmentID;
        this.cancelDate = cancelDate;
        this.negotiatedPrice = negotiatedPrice;
    }

    public ProductDTO(int productID, String productName, String serialNumber, String brand, int categoryID, String description, String image, int isSpecial) {
        this.productID = productID;
        this.name = productName;
        this.serialNumber = serialNumber;
        this.brand = brand;
        this.categoryID = categoryID;
        this.description = description;
        this.image = image;
        this.isSpecial = isSpecial;
    }

    public ProductDTO(int productID, String productName, String receivedDate, String consignmentID, float price, int productStatusID) {
        this.productID = productID;
        this.name = productName;
        this.receivedDate = receivedDate;
        this.consignmentID = consignmentID;
        this.consignedPrice = price;
        this.productStatusID = productStatusID;
    }

    public ProductDTO(int productID, String productName, String receivedDate, String consignmentID, float price, String cancelDate) {
        this.productID = productID;
        this.name = productName;
        this.receivedDate = receivedDate;
        this.consignmentID = consignmentID;
        this.consignedPrice = price;
        this.cancelDate = cancelDate;

    }

    public ProductDTO(int productID, String productName, String serialNumber, int categoryID, String brand, String description, String image, float price) {
        this.productID = productID;
        this.name = productName;
        this.serialNumber = serialNumber;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.sellingPrice = price;
    }

    public ProductDTO(int productID, String productName, String serialNumber, int categoryID, String brand, String description, float price) {
        this.productID = productID;
        this.name = productName;
        this.serialNumber = serialNumber;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.sellingPrice = price;
    }
    //danqt - end

    //ban cu anh huon DanqtDAO
    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int isSpecial) {
        this.productID = productID;
        this.name = name;
        this.serialNumber = serialNumber;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.isSpecial = isSpecial;
    }
    /*
     HoangNH     
     */

    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String brand, String description, String image, int productStatusID, float sellingPrice, int parentCategoryID) {
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

//duchc product constuctor for add new product
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

    //duchc product constructor for get information of tracking product status
    public ProductDTO(int productID, String name, String serialNumber, String purchasedDate, int categoryID, String categoryName, String brand, String description, String image, int productStatusID, String status) {
        this.productID = productID;
        this.name = name;
        this.serialNumber = serialNumber;
        this.purchasedDate = purchasedDate;
        this.categoryID = categoryID;
        this.brand = brand;
        this.description = description;
        this.image = image;
        this.productStatusID = productStatusID;
        this.status = status;
        this.categoryName = categoryName;
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
        this.setConsignedPrice((float) consignedPrice);
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    /**
     * @return the cancelDate
     */
    public String getCancelDate() {
        return cancelDate;
    }

    /**
     * @param cancelDate the cancelDate to set
     */
    public void setCancelDate(String cancelDate) {
        this.cancelDate = cancelDate;
    }

    /**
     * @return the minPrice
     */
    public Float getMinPrice() {
        return minPrice;
    }

    /**
     * @param minPrice the minPrice to set
     */
    public void setMinPrice(Float minPrice) {
        this.setMinPrice((float) minPrice);
    }

    /**
     * @param consignedPrice the consignedPrice to set
     */
    public void setConsignedPrice(float consignedPrice) {
        this.consignedPrice = consignedPrice;
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
     * @return the orderDate
     */
    public String getOrderDate() {
        return orderDate;
    }

    /**
     * @param orderDate the orderDate to set
     */
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    /**
     * @return the customerPhone
     */
    public String getCustomerPhone() {
        return customerPhone;
    }

    /**
     * @param customerPhone the customerPhone to set
     */
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getSellDate() {
        return sellDate;
    }

    public void setSellDate(String sellDate) {
        this.sellDate = sellDate;
    }

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
     * @return the orderList
     */
    public List<OrderDTO> getOrderList() {
        return orderList;
    }

    /**
     * @param orderList the orderList to set
     */
    public void setOrderList(List<OrderDTO> orderList) {
        this.orderList = orderList;
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

    public int getIsSpecial() {
        return isSpecial;
    }

    public void setIsSpecial(int isSpecial) {
        this.isSpecial = isSpecial;
    }

    /**
     * @return the seasonList
     */
    public List<Integer> getSeasonList() {
        return seasonList;
    }

    /**
     * @param seasonList the seasonList to set
     */
    public void setSeasonList(List<Integer> seasonList) {
        this.seasonList = seasonList;
    }

}
