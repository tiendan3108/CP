/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.StoreOwnerDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Robingios
 */
public class DuchcDAO {

    // add new product
    public int addProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Product(ProductName, SerialNumber, PurchasedDate, CategoryID, Brand, Description, "
                    + " Image, ProductStatusID)\n"
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
                stm.setNull(7, java.sql.Types.VARCHAR);
            } else {
                stm.setString(7, product.getImage());
            }

            stm.setInt(8, product.getProductStatusID());

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

    //add new consignment
    public boolean addConsigment(ConsignmentDTO consigment) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Consignment(ConsignmentID, ProductID, MemberID, StoreOwnerID, FullName, Address,"
                    + " Phone, Email, PaypalAccount,\n"
                    + "                     FromDate, ToDate, Period, MinPrice, MaxPrice, CreatedDate, ConsignmentStatusID)\n"
                    + "                     VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
            if (consigment.getEmail().equals("")) {
                stm.setNull(8, java.sql.Types.VARCHAR);
            } else {
                stm.setString(8, consigment.getEmail());
            }

            if (consigment.getPaypalAccount().equals("")) {
                stm.setNull(9, java.sql.Types.VARCHAR);
            } else {
                stm.setString(9, consigment.getPaypalAccount());
            }
            stm.setString(10, consigment.getFromDate());
            stm.setString(11, consigment.getToDate());
            stm.setInt(12, consigment.getPeriod());

            if (consigment.getMinPrice() > 0) {
                stm.setDouble(13, consigment.getMinPrice());
            } else {
                stm.setNull(13, java.sql.Types.FLOAT);
            }
            if (consigment.getMaxPrice() > 0) {
                stm.setDouble(14, consigment.getMaxPrice());
            } else {
                stm.setNull(14, java.sql.Types.FLOAT);
            }
            Date date = new Date();
            DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            stm.setString(15, dateFormat.format(date));
            stm.setInt(16, consigment.getConsignmentStatusID());
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

    //duchc _get all store owners based on categoryID actor choose in consign_step1
    public List<StoreOwnerDTO> getListStoreOwnerByCategory(int categoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     c.StoreOwnerID, a.FullName, a.Address, s.Formula\n"
                    + "                     FROM         dbo.Account AS a INNER JOIN\n"
                    + "                                           dbo.StoreOwner AS s ON a.AccountID = s.AccountID INNER JOIN\n"
                    + "                                           dbo.StoreOwner_Category AS c ON s.StoreOwnerID = c.StoreOwnerID\n"
                    + "                     WHERE     (c.CategoryID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();
            List<StoreOwnerDTO> list = new ArrayList<StoreOwnerDTO>();
            while (rs.next()) {
                StoreOwnerDTO store = new StoreOwnerDTO();
                store.setStoreOwnerID(rs.getInt("StoreOwnerID"));
                store.setName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setFormula(rs.getDouble("Formula"));
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

    // get store owner for calculating
    public AccountDTO getStoreOwnerByID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     s.StoreOwnerID, a.FullName, a.Address, s.Formula\n"
                    + "FROM         dbo.Account AS a INNER JOIN\n"
                    + "                      dbo.StoreOwner AS s ON a.AccountID = s.AccountID\n"
                    + "WHERE     (s.StoreOwnerID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            rs = stm.executeQuery();

            if (rs.next()) {
                AccountDTO store = new AccountDTO();
                store.setRoleID(rs.getInt("StoreOwnerID"));
                store.setFullName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setFormula(rs.getFloat("Formula"));
                return store;
            }
            return null;
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

    // duchc
    public String generateConsignmentID(String productName, String consignorName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = "";
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT COUNT(*) as Number FROM Consignment WHERE CreatedDate = GETDATE()";
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

    public ConsignmentDTO getConsigmentbyID(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT      PERCENT c.ConsignmentID, c.ProductID, c.MemberID, c.StoreOwnerID, a.FullName AS StoreOwnerName, c.FullName, c.Address, c.Phone, c.Email, c.PaypalAccount, c.FromDate, c.ToDate, \n"
                    + "                      c.RaiseWebDate, c.Period, c.MinPrice, c.MaxPrice, c.CreatedDate, c.ConsignmentStatusID, cs.ConsignmentStatusName\n"
                    + "FROM         dbo.Consignment AS c INNER JOIN\n"
                    + "                      dbo.ConsignmentStatus AS cs ON c.ConsignmentStatusID = cs.ConsignmentStatusID INNER JOIN\n"
                    + "                      dbo.StoreOwner AS s ON c.StoreOwnerID = s.StoreOwnerID INNER JOIN\n"
                    + "                      dbo.Account AS a ON s.AccountID = a.AccountID\n"
                    + "ORDER BY c.CreatedDate\n"
                    + " WHERE (c.ConsignmentID = ?)";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();

            if (rs.next()) {
                ConsignmentDTO consignment = new ConsignmentDTO();
                consignment.setConsigmentID(rs.getString("ConsignmentID"));
                consignment.setProductID(rs.getInt("ProductID"));
                consignment.setMemberID(rs.getInt("MemberID"));
                consignment.setStoreOwnerID(rs.getInt("StoreOwnerID"));
                consignment.setStoreOwnerID(rs.getInt("StoreOwnerID"));
                consignment.setStoreOwnerName(rs.getString("StoreOwnerName"));
                consignment.setName(rs.getString("FullName"));
                consignment.setAddress(rs.getString("Address"));
                consignment.setPhone(rs.getString("Phone"));
                consignment.setEmail(rs.getString("Email"));
                consignment.setPaypalAccount(rs.getString("PayapalAccount"));
                consignment.setFromDate(rs.getString("FromDate"));
                consignment.setToDate(rs.getString("ToDate"));
                consignment.setRaiseWebDate(rs.getString("RaiseWebDate"));
                consignment.setMinPrice(rs.getDouble("MinPrice"));
                consignment.setMaxPrice(rs.getDouble("MaxPrice"));
                consignment.setCreatedDate(rs.getString("CreatedDate"));
                consignment.setConsignmentStatusID(rs.getInt("ConsignmentStatusID"));
                consignment.setStatus(rs.getString("ConsignmentStatusName"));
                return consignment;
            }
            return null;
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

    public List<ConsignmentDTO> getListConsigmentbyMemberID(int MemberID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT      PERCENT c.ConsignmentID, c.ProductID, c.StoreOwnerID, a.FullName AS StoreOwnerName, c.FullName, c.Address, c.Phone, c.Email, c.PaypalAccount, c.FromDate, c.ToDate, \n"
                    + "                      c.RaiseWebDate, c.Period, c.MinPrice, c.MaxPrice, c.CreatedDate, c.ConsignmentStatusID, cs.ConsignmentStatusName\n"
                    + "FROM         dbo.Consignment AS c INNER JOIN\n"
                    + "                      dbo.ConsignmentStatus AS cs ON c.ConsignmentStatusID = cs.ConsignmentStatusID INNER JOIN\n"
                    + "                      dbo.StoreOwner AS s ON c.StoreOwnerID = s.StoreOwnerID INNER JOIN\n"
                    + "                      dbo.Account AS a ON s.AccountID = a.AccountID\n"
                    + "ORDER BY c.CreatedDate\n"
                    + " WHERE (c.MemberID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, MemberID);
            rs = stm.executeQuery();
            List<ConsignmentDTO> list = new ArrayList<ConsignmentDTO>();
            while (rs.next()) {
                ConsignmentDTO consigment = new ConsignmentDTO();
                consigment.setConsigmentID(rs.getString("ConsignmentID"));
                consigment.setProductID(rs.getInt("ProductID"));
                consigment.setStoreOwnerID(rs.getInt("ProductID"));
                consigment.setProductID(rs.getInt("ProductID"));
            }
//            return store;
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

    public ProductDTO getProductbyID() {
        return null;
    }

    public boolean cancelProductStatus(int consignmentID) {
        return false;
    }

    public AccountDTO login(String username, String password) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT     AccountID, Password, Status, FullName, Address, Phone, Email, PaypalAccount, Role\n"
                    + "FROM dbo.Account"
                    + " WHERE (AccountID = ?) AND (Password = ?)";
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next()) {
                AccountDTO account = new AccountDTO();
                account.setAccountID(rs.getString("AccountID"));
                account.setPassword(rs.getString("Password"));
                account.setStatus(rs.getString("Status"));
                account.setFullName(rs.getString("FullName"));
                account.setAddress(rs.getString("Address"));
                account.setPhone(rs.getString("Phone"));
                account.setEmail(rs.getString("Email"));
                account.setPaypalAccount(rs.getString("PaypalAccount"));
                account.setRole(rs.getString("Role"));
                
                if(account.getRole() == GlobalVariables.MEMBER){
                    query = "SELECT MemberID FROM Member WHERE (AccountID = ?) ";
                    stm = con.prepareStatement(query);
                    stm.setString(1, account.getAccountID());
                    rs = stm.executeQuery();
                    if(rs.next()){
                        account.setRoleID(rs.getInt("MemberID"));
                    }
                }
                else if(account.getRole() == GlobalVariables.STORE_OWNER){
                    query = "SELECT StoreOwnerID, Formula FROM StoreOwner WHERE (AccountID = ?) ";
                    stm = con.prepareStatement(query);
                    stm.setString(1, account.getAccountID());
                    rs = stm.executeQuery();
                    if(rs.next()){
                        account.setRoleID(rs.getInt("StoreOwnerID"));
                        account.setFormula(rs.getFloat("Formula"));
                    }
                }
                return account;
            }
            return null;
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
