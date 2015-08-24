/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                    Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                    Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null;
    }

    public AccountDTO getInfoByProductID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        AccountDTO account = new AccountDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select a.[Address], a.Email, a.Phone, a.FullName "
                    + "from Product p, Consignment c, StoreOwner s, Account a "
                    + "where p.ProductID = c.ProductID "
                    + "and c.StoreOwnerID = s.StoreOwnerID "
                    + "and s.AccountID = a.AccountID "
                    + "and p.ProductID = ? ";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                account.setFullName(fullName);
                account.setAddress(address);
                account.setPhone(phone);
                account.setEmail(email);
                return account;
            } else {
                return null;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public List<AccountDTO> getAllAccount() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<AccountDTO> accounts = new ArrayList<AccountDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Account where Role != ?";
            stm = con.prepareStatement(query);
            stm.setString(1, GlobalVariables.ADMIN);
            rs = stm.executeQuery();
            while (rs.next()) {
                AccountDTO account = new AccountDTO();
                String accountID = rs.getString("AccountID");
                String status = rs.getString("Status");
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                String paypalAccount = rs.getString("PaypalAccount");
                String role = rs.getString("Role");
                account.setAccountID(accountID);
                account.setStatus(status);
                account.setFullName(fullName);
                account.setAddress(address);
                account.setPhone(phone);
                account.setEmail(email);
                account.setPaypalAccount(paypalAccount);
                account.setRole(role);
                accounts.add(account);
            }
            return accounts;

        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public boolean insertAccount(AccountDTO account) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into [Account] Values(?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, account.getAccountID());
            stm.setString(2, account.getPassword());
            stm.setString(3, GlobalVariables.ACTIVE);
            stm.setString(4, account.getFullName());
            stm.setString(5, account.getAddress());
            stm.setString(6, account.getPhone());
            stm.setString(7, account.getEmail());
            stm.setString(8, account.getPaypalAccount());
            stm.setString(9, account.getRole());
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean insertMember(String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into Member(AccountID) Values(?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, accountID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean insertStoreOwner(String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into StoreOwner(AccountID,Formula) Values(?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, accountID);
            stm.setFloat(2, 10);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean updateAccount(AccountDTO account) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Account"
                    + " SET FullName = ? ,"
                    + " Address = ? ,"
                    + " Phone = ? ,"
                    + " Email = ? ,"
                    + " PaypalAccount = ? "
                    + " WHERE AccountID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, account.getFullName());
            stm.setString(2, account.getAddress());
            stm.setString(3, account.getPhone());
            stm.setString(4, account.getEmail());
            stm.setString(5, account.getPaypalAccount());
            stm.setString(6, account.getAccountID());
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean deactiveAccount(String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Account"
                    + " SET Status = ? "
                    + " WHERE AccountID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, GlobalVariables.DEACTIVE);
            stm.setString(2, accountID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean activeAccount(String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Account"
                    + " SET Status = ? "
                    + " WHERE AccountID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, GlobalVariables.ACTIVE);
            stm.setString(2, accountID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public AccountDTO getStoreOwnerByID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     S.StoreOwnerID, A.FullName, A.Address, A.Phone, A.Email, S.Formula "
                    + " FROM         dbo.Account AS A INNER JOIN "
                    + "              dbo.StoreOwner AS S ON A.AccountID = S.AccountID "
                    + " WHERE     (S.StoreOwnerID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            rs = stm.executeQuery();

            if (rs.next()) {
                AccountDTO store = new AccountDTO();
                store.setRoleID(rs.getInt("StoreOwnerID"));
                store.setFullName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setPhone(rs.getString("Phone"));
                store.setEmail(rs.getString("Email"));
                store.setFormula(rs.getFloat("Formula"));
                return store;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }

    public List<AccountDTO> getListStoreOwnerByCategory(int categoryID, double basicPrice) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        JavaUltilities ultil = new JavaUltilities();
        try {
            con = DBUltilities.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     c.StoreOwnerID, a.FullName, a.Address, a.Phone, a.Email , s.Formula\n"
                    + "                     FROM         dbo.Account AS a INNER JOIN\n"
                    + "                                           dbo.StoreOwner AS s ON a.AccountID = s.AccountID INNER JOIN\n"
                    + "                                           dbo.StoreOwner_Category AS c ON s.StoreOwnerID = c.StoreOwnerID\n"
                    + "                     WHERE     (c.CategoryID = ?) ORDER BY Formula DESC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();
            List<AccountDTO> list = new ArrayList<AccountDTO>();
            while (rs.next()) {
                AccountDTO store = new AccountDTO();
                store.setRoleID(rs.getInt("StoreOwnerID"));
                store.setFullName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setPhone(rs.getString("Phone"));
                if (store.getPhone() != null) {
                    if (store.getPhone().contains("+84")) {
                        store.setPhone("0" + store.getPhone().substring(3));
                    }
                }
                store.setEmail(rs.getString("Email"));
                store.setFormula(rs.getFloat("Formula"));

                //add MinPrice & MaxPrice
                
                int percent = ultil.getPercentInPropertyFileByStoreOwnerID(store.getRoleID());
                if(percent < 0){
                    percent = 60;
                }
                store.setMinPrice(Math.round((basicPrice * percent / 100) * (1 - store.getFormula() / 100) / 1000));
                store.setMaxPrice(Math.round((basicPrice * percent / 100) * (1 + store.getFormula() / 100) / 1000));
                list.add(store);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }

    //begin merge
    //duchcdao
    public static String getGcmID(String storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String gcmID = "";
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT GcmID "
                    + " FROM Account "
                    + " WHERE AccountID = ? ";
            stm = con.prepareStatement(sql);
            stm.setString(1, storeOwnerID);

            rs = stm.executeQuery();

            if (rs.next()) {
                gcmID = rs.getString("GcmID");
            }
            return gcmID;
        } catch (SQLException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public static String getGcmIDOfStoreOwnerByConsignmentID(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String gcmID = "";
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT     A.GcmID "
                    + "FROM         dbo.Account AS A INNER JOIN "
                    + "             dbo.StoreOwner AS S ON A.AccountID = S.AccountID INNER JOIN "
                    + "             dbo.Consignment AS C ON S.StoreOwnerID = C.StoreOwnerID "
                    + "WHERE     (C.ConsignmentID =  ?) ";
            stm = con.prepareStatement(sql);
            stm.setString(1, consignmentID);

            rs = stm.executeQuery();

            if (rs.next()) {
                gcmID = rs.getString("GcmID");
            }
            return gcmID;
        } catch (SQLException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    //AccountDAO
    public AccountDTO getConsignorInforByConsignmentID(String consignmentID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String fullName = "", address = "", phone = "", email = "", paypalAccount = "";
        float consignedPrice = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                consignedPrice = rs.getFloat("ReturnedPrice") / 1000;
                paypalAccount = rs.getString("PaypalAccount");
                AccountDTO result = new AccountDTO(fullName, address, phone, email, consignedPrice);
                result.setPaypalAccount(paypalAccount);
                return result;
            }
            return null;
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private String convertPhone(String source) {
        if (source == null) {
            return "";
        }
        return "0" + source.substring(3);
    }

    private String formatDateString(String source) {
        if (source == null) {
            return "";
        }
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("HH:mm | dd-MM-yyyy");
            Date date = df.parse(source);
            String result = df2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    public AccountDTO getConsignorInforByOrderID(String orderID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        AccountDTO result = new AccountDTO();
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT DISTINCT c.* FROM [Order] o, Consignment c WHERE c.ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND o.ProductID = c.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, orderID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("FullName");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                result.setFullName(fullName);
                result.setEmail(email);
                result.setPhone(phone);
            }
            return result;
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
