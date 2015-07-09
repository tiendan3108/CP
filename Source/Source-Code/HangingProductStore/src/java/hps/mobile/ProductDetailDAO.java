/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile;

import hps.dao.CategoryDAO;
import hps.dao.ProductDAO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNHSE61007
 */
public class ProductDetailDAO {

    public int checkLogin(String username, String password) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Account, StoreOwner "
                    + "where Account.AccountID = StoreOwner.AccountID "
                    + "And Account.AccountID = ? and Account.Password = ? and Account.Status = ? "
                    + "and Role = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setString(3, GlobalVariables.ACTIVE);
            stm.setString(4, "storeOwner");
            rs = stm.executeQuery();
            if (rs.next()) {
                int memberID = rs.getInt("StoreOwnerID");
                return memberID;
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
        return 0;
    }

    public int getMemberID(String accountID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from StoreOwner "
                    + "Where AccountID = ? ";
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            rs = stm.executeQuery();
            if (rs.next()) {
                int memberID = rs.getInt("StoreOwnerID");
                return memberID;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return 0;
    }

    public List<ProductDetail> getData(int memberID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDetail> products = new ArrayList<ProductDetail>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Product, Consignment "
                    + "Where Product.ProductID = Consignment.ProductID "
                    + "And Consignment.StoreOwnerID = ? "
                    + "And Consignment.ConsignmentStatusID = ? "
                    + "order by Consignment.ToDate asc";
            stm = con.prepareStatement(query);
            stm.setInt(1, memberID);
            stm.setInt(2, ConsignmentStatus.ACCEPTED);
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                String customerName = rs.getString("FullName");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String fromDate = rs.getString("FromDate");
                String toDate = rs.getString("ToDate");
                float maxPrice = rs.getFloat("MaxPrice");
                float minPrice = rs.getFloat("MinPrice");
                ProductDetail product = new ProductDetail(productID, productName, serialNumber, brand, description, image, customerName, address, phone, maxPrice, minPrice, fromDate, toDate);
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public boolean updateConsignment(int productID, String receivedDate, float negotiatedPrice) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "update Consignment "
                    + "Set ReceivedDate = ?, "
                    + "NegotiatedPrice = ?, "
                    + "ConsignmentStatusID = ? "
                    + "where ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, receivedDate);
            stm.setFloat(2, negotiatedPrice);;
            stm.setInt(3, ConsignmentStatus.RECEIVED);
            stm.setInt(4, productID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public boolean receiveProduct(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "update Product "
                    + "Set ProductStatusID = ? "
                    + "where ProductID = ? ";
            stm = con.prepareStatement(query);
            stm.setInt(1, ProductStatus.AVAILABLE);
            stm.setInt(2, productID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public void cancelConsignment(int productID, String reason) {
        updateConsignmentStatus(productID, reason);
        updateProductStatus(productID);
    }

    public void updateConsignmentStatus(int productID, String reason) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "update Consignment "
                    + "Set ConsignmentStatusId = ? , "
                    + "Reason = ? "
                    + "where ProductId = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, ConsignmentStatus.REFUSE);
            stm.setString(2, reason);
            stm.setInt(3, productID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void updateProductStatus(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "update Product "
                    + "Set ProductStatusId = ? "
                    + "where ProductId = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, ProductStatus.NOT_AVAILABLE);
            stm.setInt(2, productID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
