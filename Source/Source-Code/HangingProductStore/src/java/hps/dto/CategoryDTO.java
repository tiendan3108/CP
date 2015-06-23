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
 * @author HoangNHSE61007
 */
public class CategoryDTO implements Serializable{

    private int categoryId;
    private String categoryName;
    private int parentId;

    public CategoryDTO() {
    }

    public CategoryDTO(int categoryId, String categoryName, int parentId) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.parentId = parentId;
    }

    /**
     * @return the id
     */
    public int getCategoryId() {
        return categoryId;
    }

    /**
     * @param id the id to set
     */
    public void setCategoryId(int id) {
        this.categoryId = id;
    }

    /**
     * @return the name
     */
    public String getCategoryName() {
        return categoryName;
    }

    /**
     * @param name the name to set
     */
    public void setCategoryName(String name) {
        this.categoryName = name;
    }

    /**
     * @return the parentId
     */
    public int getParentId() {
        return parentId;
    }

    /**
     * @param parentId the parentId to set
     */
    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

}
