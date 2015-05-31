/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

/**
 *
 * @author Robingios
 */
public class StoreOwnerDTO {
    private String name;
    private String address;
    private int categoryId;
    private String reliability;
    private double percent;
    
    public StoreOwnerDTO(){}

    public StoreOwnerDTO(String name, String address, int categoryId, String reliability, double percent) {
        this.name = name;
        this.address = address;
        this.categoryId = categoryId;
        this.reliability = reliability;
        this.percent = percent;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    

    public String getReliability() {
        return reliability;
    }

    public void setReliability(String reliability) {
        this.reliability = reliability;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }
    
    }
