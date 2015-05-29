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
public class ProductDTO {

    private int productID;
    private String name;
    private int status;
    private String description;
    private float price;
    private String image;
    private String receivedDay;
    private int categoryID;
    private int parentCategoryID;

    public ProductDTO() {
    }

    public ProductDTO(int productID, String name, int status, String description, float price, String image, String receivedDay, int categoryID, int parentCategoryID) {
        this.productID = productID;
        this.name = name;
        this.status = status;
        this.description = description;
        this.price = price;
        this.image = image;
        this.receivedDay = receivedDay;
        this.categoryID = categoryID;
        this.parentCategoryID = parentCategoryID;
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
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
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
     * @return the receivedDay
     */
    public String getReceivedDay() {
        return receivedDay;
    }

    /**
     * @param receivedDay the receivedDay to set
     */
    public void setReceivedDay(String receivedDay) {
        this.receivedDay = receivedDay;
    }

    /**
     * @return the categoryID
     */
    public int getCategoryID() {
        return categoryID;
    }

    /**
     * @param categoryID the categoryID to set
     */
    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    /**
     * @return the parentCategoryID
     */
    public int getParentCategoryID() {
        return parentCategoryID;
    }

    /**
     * @param parentCategoryID the parentCategoryID to set
     */
    public void setParentCategoryID(int parentCategoryID) {
        this.parentCategoryID = parentCategoryID;
    }

}
