/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

import java.io.Serializable;

/**
 *
 * @author Tien Dan
 */
public class AccountDTO implements Serializable{

    //default attributes for account table

    private String accountID;
    private String password;
    private String status;
    private String fullName;
    private String address;
    private String phone;
    private String email;
    private String paypalAccount;
    private String role;
    private int roleID;
    private float formula;

    //danqt - begin
    private float consignedPrice;
    private float sellingPrice;
    private String orderedDate;

    //danqt - end

//duchc - begin
    //duchc - end

    //constructor with no parameter
    public AccountDTO() {
    }
    //constructor all parameter

    public AccountDTO(String accountID, String password, String status, String fullName, String address, String phone, String email, String paypalAccount, String role, int roleID, float formula) {
        this.accountID = accountID;
        this.password = password;
        this.status = status;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.role = role;
        this.roleID = roleID;
        this.formula = formula;
    }

    // danqt - begin
    public AccountDTO(String accountID, String password, String status, String fullName, String address, String phone, String email, String paypalAccount, String role, float consignedPrice) {
        this.accountID = accountID;
        this.password = password;
        this.status = status;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.role = role;
        this.consignedPrice = consignedPrice;
    }

    public AccountDTO(String fullName, String address, String phone, String email, float consignedPrice) {
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.consignedPrice = consignedPrice;
    }
    public AccountDTO(String fullName, String address, String phone, String email, float consignedPrice, float sellingPrice, String orderedDate) {
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.consignedPrice = consignedPrice;
        this.sellingPrice = sellingPrice;
        this.orderedDate = orderedDate;
    }

    public AccountDTO(String fullName, String address, String phone, String email, String paypalAccount) {
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
    }
    // danqt - end

    //danqt - accountDTO for errof in DAnqtDAO

    public AccountDTO(String accountID, String password, String status, String fullName, String address, String phone, String email, String paypalAccount, String role) {
        this.accountID = accountID;
        this.password = password;
        this.status = status;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.role = role;
    }
    
    

//duchc account contructor for login as member
    public AccountDTO(String accountID, String password, String status, String fullName, String address, String phone, String email, String paypalAccount, String role, int roleID) {
        this.accountID = accountID;
        this.password = password;
        this.status = status;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paypalAccount = paypalAccount;
        this.role = role;
        this.roleID = roleID;
    }

    /**
     * @return the accountID
     */
    public String getAccountID() {
        return accountID;
    }

    /**
     * @param accountID the accountID to set
     */
    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the fullName
     */
    public String getFullName() {
        return fullName;
    }

    /**
     * @param fullName the fullName to set
     */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * @param phone the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the paypalAccount
     */
    public String getPaypalAccount() {
        return paypalAccount;
    }

    /**
     * @param paypalAccount the paypalAccount to set
     */
    public void setPaypalAccount(String paypalAccount) {
        this.paypalAccount = paypalAccount;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @param role the role to set
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * @return the consignedPrice
     */
    public float getConsignedPrice() {
        return consignedPrice;
    }

    /**
     * @param consignedPrice the consignedPrice to set
     */
    public void setConsignedPrice(float consignedPrice) {
        this.consignedPrice = consignedPrice;
    }

    /**
     * @return the roleID
     */
    public int getRoleID() {
        return roleID;
    }

    /**
     * @param roleID the roleID to set
     */
    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    /**
     * @return the formula
     */
    public float getFormula() {
        return formula;
    }

    /**
     * @param formula the formula to set
     */
    public void setFormula(float formula) {
        this.formula = formula;
    }

    /**
     * @return the sellingPrice
     */
    public float getSellingPrice() {
        return sellingPrice;
    }

    /**
     * @param sellingPrice the sellingPrice to set
     */
    public void setSellingPrice(float sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    /**
     * @return the orderedDate
     */
    public String getOrderedDate() {
        return orderedDate;
    }

    /**
     * @param orderedDate the orderedDate to set
     */
    public void setOrderedDate(String orderedDate) {
        this.orderedDate = orderedDate;
    }



}
