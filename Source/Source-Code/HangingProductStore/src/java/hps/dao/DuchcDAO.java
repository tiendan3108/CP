/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.ProductDTO;
import hps.dto.StoreOwnerDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Robingios
 */
public class DuchcDAO {

    public boolean addConsigment(String consignmentID, int productID, int memberID, int storeOwnerID, String fullName, String address,
            String phone, String email, String cardNumber, String cardOwner, String fromDate, String toDate) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Consignment VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            stm.setInt(2, productID);
            if (memberID > 0) {
                stm.setInt(3, memberID);
            }
            stm.setInt(4, storeOwnerID);
            stm.setString(5, fullName);
            stm.setString(6, address);
            stm.setString(7, phone);
            stm.setString(8, email);
            stm.setString(9, cardNumber);
            stm.setString(10, cardOwner);
            stm.setString(11, fromDate);
            stm.setString(12, toDate);

            //set cung status
            stm.setString(14, "NOT AVAILABLE");
            //set cung period
            stm.setInt(15, 10);

            int result = stm.executeUpdate();
            return result > 0;
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return false;
    }

    public int addProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Product(ProductName, SerialNumber, PurchasedDate, CategoryID, Brand, Description, Image, Status) "
                    + " VALUES(?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query);
            stm.setString(1, product.getName());
            stm.setString(2, product.getSerialNumber());
            stm.setString(3, product.getPurchasedDate());
            stm.setInt(4, product.getCategoryID());
            stm.setString(5, product.getBrand());
            stm.setString(6, product.getDescription());
            stm.setString(7, product.getImage());
            stm.setInt(8, GlobalVariables.NOT_AVAILABLE);
            stm.executeUpdate();
            ResultSet generatedKeys = stm.getGeneratedKeys();
            int result = -1;
            if (rs.next()) {
                result = generatedKeys.getInt(1);
            }

            return result;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return -1;
    }

    //duchc _ Lay tat ca store owner dua tren categoryID ma actor chon trong consign_step1
    public List<StoreOwnerDTO> getStoreOwnerByCategory(int categoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     c.StoreOwnerID, a.FullName, a.Address, s.Formular\n"
                    + "FROM         dbo.Account AS a INNER JOIN\n"
                    + "                      dbo.StoreOwner AS s ON a.AccountID = s.AccountID INNER JOIN\n"
                    + "                      dbo.StoreOwner_Category AS c ON s.StoreOwnerID = c.StoreOwnerID\n"
                    + "WHERE     (c.CategoryID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();
            List<StoreOwnerDTO> list = new ArrayList<StoreOwnerDTO>();
            while (rs.next()) {
                StoreOwnerDTO store = new StoreOwnerDTO();
                store.setStoreOwnerID(rs.getInt("StoreOwnerID"));
                store.setName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setFormula(rs.getDouble("Formular"));
                list.add(store);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }

    public static String generateConsignmentID(String productName, String consignorName) {

        //String sql = "SELECT COUNT(*) as Number FROM Consignment WHERE ReceivedDate = GETDATE()";
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = "";
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT COUNT(*) as Number FROM Consignment WHERE ReceivedDate = GETDATE()";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                String count = String.format("%02d", rs.getInt("Number"));
                name += productName.substring(0, 1);
                name += consignorName.substring(0, 1);
                name += count;
                Calendar now = Calendar.getInstance();
                name += String.format("%02d", now.get(Calendar.DAY_OF_MONTH));
                name += String.format("%02d", now.get(Calendar.MONTH));
                name += String.format("%02d", (now.get(Calendar.YEAR) % 100));
            }
            return name;
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }
}
