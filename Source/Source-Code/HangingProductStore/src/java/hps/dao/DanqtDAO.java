/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import java.util.List;
import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tien Dan
 */
public class DanqtDAO {

    public List<ProductDTO> getProductStatus() {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ProductDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.Price,c.Status "
                    + "FROM Product p ,Consignment c "
                    + "WHERE p.Status != ? AND c.ProductID = p.ProductID ORDER BY Status";
            stm = conn.prepareStatement(query);
            stm.setString(1, "" + GlobalVariables.NOT_AVAILABLE);
            rs = stm.executeQuery();
            String productName, receivedDate, consignmentID;
            float price;
            int status, productID;
            ProductDTO product;
            while (rs.next()) {
                productID = Integer.parseInt(rs.getString("ProductID"));
                productName = rs.getString("ProductName");
                receivedDate = rs.getString("ReceivedDate");
                consignmentID = rs.getString("ConsignmentID");
                price = Float.parseFloat(rs.getString("Price"));
                status = Integer.parseInt(rs.getString("Status"));
                product = new ProductDTO(productID, productName, receivedDate, consignmentID, price, status);
                result.add(product);
            }
            return result;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean publishOnWeb(String productID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        int result;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Status = ? WHERE ProductID = ? AND STATUS = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, "" + GlobalVariables.ON_WEB);
            stm.setString(2, productID);
            stm.setString(3, "" + GlobalVariables.IN_INVENTORY);
            result = stm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean payConsignor(String productID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        int result;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Status = ? WHERE ProductID = ? AND Status = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, "" + GlobalVariables.COMPLETED);
            stm.setString(2, productID);
            stm.setString(3, "" + GlobalVariables.SOLD);
            result = stm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean cancelProduct(String productID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        int result;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Status = ? WHERE ProductID = ? AND STATUS in (?,?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, "" + GlobalVariables.CANCEL);
            stm.setString(2, productID);
            stm.setString(3, "" + GlobalVariables.IN_INVENTORY);
            stm.setString(4, "" + GlobalVariables.ON_WEB);
            result = stm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
