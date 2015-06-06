/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HoangNHSE61007
 */
public class Cart {

    private List<Integer> items;

    public Cart() {
        this.items = new ArrayList<Integer>();
    }

    public boolean addToCart(int productId) {
        if (items.size() > 0) {
            for (int i = 0; i < getItems().size(); i++) {
                int currentProductId = getItems().get(i);
                if (currentProductId == productId) {
                    return false;
                }
            }
        }
        items.add(productId);
        return true;
    }

    /**
     * @return the items
     */
    public List<Integer> getItems() {
        return items;
    }

    /**
     * @param items the items to set
     */
    public void setItems(List<Integer> items) {
        this.items = items;
    }
}
