/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import hps.ultils.OrderStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}
