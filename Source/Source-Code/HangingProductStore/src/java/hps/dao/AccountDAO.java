/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNHSE61007
 */
public class AccountDAO {

    public AccountDTO checkLogin(String username, String password) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        AccountDTO account = new AccountDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Account where AccountID = ? and Password = ? and Status = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setString(3, GlobalVariables.ACTIVE);
            rs = stm.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                String paypalAccount = rs.getString("PaypalAccount");
                String role = rs.getString("Role");
                account.setAccountID(username);
                account.setPassword(password);
                account.setStatus(GlobalVariables.ACTIVE);
                account.setFullName(fullName);
                account.setAddress(address);
                account.setPhone(phone);
                account.setEmail(email);
                account.setPaypalAccount(paypalAccount);
                account.setRole(role);
                return account;
            } else {
                return null;
            }

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public AccountDTO getRoleInfo(String role, String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        AccountDTO account = new AccountDTO();
        if (role.equals(GlobalVariables.STORE_OWNER)) {
            try {
                DBUltilities db = new DBUltilities();
                con = db.makeConnection();
                String query = "select * from StoreOwner where AccountID = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, accountID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int roleID = rs.getInt("StoreOwnerID");
                    float formula = rs.getFloat("Formula");
                    account.setRoleID(roleID);
                    account.setFormula(formula);
                }
                return account;
            } catch (SQLException ex) {
                Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stm != null) {
                        stm.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else if (role.equals(GlobalVariables.MEMBER)) {
            try {
                DBUltilities db = new DBUltilities();
                con = db.makeConnection();
                String query = "select * from Member where AccountID = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, accountID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int roleID = rs.getInt("MemberID");
                    account.setRoleID(roleID);
                }
                return account;
            } catch (SQLException ex) {
                Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stm != null) {
                        stm.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null;
    }
}
