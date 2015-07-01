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
public class AmazonProduct {
    private String name;
    private String ASIN;
    private float price;
    private float newPrice;
    private String image;

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
     * @return the ASIN
     */
    public String getASIN() {
        return ASIN;
    }

    /**
     * @param ASIN the ASIN to set
     */
    public void setASIN(String ASIN) {
        this.ASIN = ASIN;
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
     * @return the newPrice
     */
    public float getNewPrice() {
        return newPrice;
    }

    /**
     * @param newPrice the newPrice to set
     */
    public void setNewPrice(float newPrice) {
        this.newPrice = newPrice;
    }
    
}
