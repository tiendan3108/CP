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
public class MemberDTO {
    private int memberID;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String cardNumber;
    private String cardOwner;

    public MemberDTO() {
    }

    public MemberDTO(int memberID, String name, String address, String phone, String email, String cardNumber, String cardOwner) {
        this.memberID = memberID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.cardNumber = cardNumber;
        this.cardOwner = cardOwner;
    }

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardOwner() {
        return cardOwner;
    }

    public void setCardOwner(String cardOwner) {
        this.cardOwner = cardOwner;
    }
    
    
}
