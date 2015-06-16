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
    private float price;
    private String ASIN;
    private String url;
    private String currency;

    public AmazonProduct(String name, float price, String ASIN, String url, String currency) {
        this.name = name;
        this.price = price;
        this.ASIN = ASIN;
        this.url = url;
        this.currency = currency;
    }

    public AmazonProduct(float price, String ASIN, String currency) {
        this.price = price;
        this.ASIN = ASIN;
        this.currency = currency;
    }

    public AmazonProduct() {
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
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the currency
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * @param currency the currency to set
     */
    public void setCurrency(String currency) {
        this.currency = currency;
    }

}
