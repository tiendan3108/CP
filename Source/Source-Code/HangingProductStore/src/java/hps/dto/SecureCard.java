/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import org.w3c.dom.Document;

/**
 *
 * @author ACER
 */
public class SecureCard {
    private boolean isDecrypted = false;
    private boolean isEncrupted = false;
    private String cardHolder;
    private String cardNumber;
    private String issueDate;
    private String expiryDate;
    private String issueNumber;
    private String cardType;
    private String encryptedData;
    private Document xmlCardData;

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardNumber() {
        return cardNumber;
    }
}
