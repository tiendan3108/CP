/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.ProductDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.StoreOwnerDTO;
import hps.ultils.DBUltilities;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

//    public boolean addConsigment(String consignmentID, int productID, int memberID, int storeOwnerID, String fullName, String address,
//            String phone, String email, String cardNumber, String cardOwner, String fromDate, String toDate) {
    public boolean addConsigment(ConsignmentDTO consigment) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Consignment(ConsignmentID, ProductID, MemberID, StoreOwnerID, FullName, Address, "
                    + " Phone, Email, CardNumber, CardOwner, FromDate, ToDate, Status, Period, MaxPrice) "
                    + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query);
            stm.setString(1, consigment.getConsigmentID());
            stm.setInt(2, consigment.getProductID());
            if (consigment.getMemberID() > 0) {
                stm.setInt(3, consigment.getMemberID());
            } else {
                stm.setNull(3, java.sql.Types.INTEGER);
            }

            stm.setInt(4, consigment.getStoreOwnerID());
            stm.setString(5, consigment.getName());
            
            if (consigment.getAddress().equals("")) {
                stm.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(6, consigment.getAddress());
            }
            if (consigment.getPhone().equals("")) {
                stm.setNull(7, java.sql.Types.VARCHAR);
            } else {
                stm.setString(7, consigment.getPhone());
            }
            if(consigment.getEmail().equals("")){
                stm.setNull(8, java.sql.Types.VARCHAR);
            }else{
                stm.setString(8, consigment.getEmail());
            }
            if(consigment.getCardNumber().equals("")){
                stm.setNull(9, java.sql.Types.VARCHAR);
            }else{
                stm.setString(9, consigment.getCardNumber());
            }
            if(consigment.getCardOwner().equals("")){
                stm.setNull(10, java.sql.Types.VARCHAR);
            }else{
                stm.setString(10, consigment.getCardOwner());
            }
            stm.setString(11, consigment.getFromDate());
            stm.setString(12, consigment.getToDate());
            stm.setString(13, consigment.getStatus());
            stm.setInt(14, consigment.getPeriod());
            if(consigment.getMaxPrice() > 0){
                stm.setDouble(15, consigment.getMaxPrice());
            }else{
                stm.setNull(15, java.sql.Types.FLOAT);
            }
            
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
            stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
//            stm = con.prepareStatement(query);
            stm.setString(1, product.getName());
            if (product.getSerialNumber().equals("")) {
                stm.setNull(2, java.sql.Types.VARCHAR);
            } else {
                stm.setString(2, product.getSerialNumber());
            }
            if (product.getPurchasedDate().equals("")) {
                stm.setNull(3, java.sql.Types.DATE);
            } else {
                stm.setString(3, product.getPurchasedDate());
            }
            
            stm.setInt(4, product.getCategoryID());
            
            if (product.getBrand().equals("")) {
                stm.setNull(5, java.sql.Types.VARCHAR);
            } else {
                stm.setString(5, product.getBrand());
            }
            if (product.getDescription().equals("")) {
                stm.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(6, product.getDescription());
            }
            if (product.getImage().equals("")) {
                stm.setNull(6, java.sql.Types.VARCHAR);
            } else {
                stm.setString(7, product.getImage());
            }

            stm.setInt(8, 0);

            int result = stm.executeUpdate();
            if (result > 0) {
                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    return id;
                }
            }
            return -1;
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
    public List<StoreOwnerDTO> getListStoreOwnerByCategory(int categoryID) {
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
    
    public StoreOwnerDTO getStoreOwnerByID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     s.StoreOwnerID, a.FullName, a.Address, s.Formular\n"
                    + "FROM         dbo.Account AS a INNER JOIN\n"
                    + "                      dbo.StoreOwner AS s ON a.AccountID = s.AccountID\n"
                    + "WHERE     (s.StoreOwnerID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            rs = stm.executeQuery();
            StoreOwnerDTO store = new StoreOwnerDTO();
            if (rs.next()) {
                
                store.setStoreOwnerID(rs.getInt("StoreOwnerID"));
                store.setName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setFormula(rs.getDouble("Formular"));
                
            }
            return store;
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
    
    

    public String generateConsignmentID(String productName, String consignorName) {

        //String sql = "SELECT COUNT(*) as Number FROM Consignment WHERE ReceivedDate = GETDATE()";
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = "";
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
//            String query = "SELECT COUNT(*) as Number FROM Consignment WHERE ReceivedDate = GETDATE()";
            String query = "SELECT COUNT(*) as Number FROM Consignment";
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
