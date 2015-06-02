/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import java.util.List;
import hps.dto.ProductDTO;
import hps.dto.UsersDTO;
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

    public boolean publishOnWeb(String productID, float sellingPrice) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        int result;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Status = ?, SellingPrice = ? WHERE ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, GlobalVariables.ON_WEB);
            stm.setFloat(2, sellingPrice);
            stm.setInt(3, Integer.parseInt(productID));
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

    public boolean cancelProduct(String productID, String consignmentID) // trả về true nếu thành công
    // trả về false nếu không thành công
    {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        PreparedStatement stmUpdateConsignment = null;
        int resultUpdateProduct, resultUpdateConsignment;
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);

            String query = "UPDATE Product SET Status = ? WHERE ProductID = ?";
            stmUpdateProduct = conn.prepareStatement(query);
            stmUpdateProduct.setInt(1, GlobalVariables.CANCEL);
            stmUpdateProduct.setInt(2, Integer.parseInt(productID));
            resultUpdateProduct = stmUpdateProduct.executeUpdate();

            query = "UPDATE Consignment SET Status = ? WHERE ConsignmentID = ?";
            stmUpdateConsignment = conn.prepareStatement(query);
            stmUpdateConsignment.setInt(1, GlobalVariables.CANCEL);
            stmUpdateConsignment.setString(2, consignmentID);
            resultUpdateConsignment = stmUpdateConsignment.executeUpdate();
            if (resultUpdateConsignment > 0 && resultUpdateProduct > 0) {
                conn.commit();
                return true;
            }
            return false;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmUpdateProduct != null) {
                    stmUpdateProduct.close();
                }
                if (stmUpdateConsignment != null) {
                    stmUpdateConsignment.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public List<ProductDTO> searchProduct(String keywords, String type) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ProductDTO> result = new ArrayList<ProductDTO>();
        String searchType = getType(type);
        String productName, receivedDate, consignmentID;
        float price;
        int status, productID;
        ProductDTO product;
        try {
            conn = DBUltilities.makeConnection();
            String query = "";
            if (!searchType.equals("")) {
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.Price,p.Status "
                        + "FROM Product p ,Consignment c "
                        + "WHERE ? LIKE ? ";
                stm = conn.prepareStatement(query);
                stm.setString(1, searchType);
                stm.setString(2, "%" + keywords + "%");
                rs = stm.executeQuery();
            } else {
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.Price,p.Status "
                        + "FROM Product p ,Consignment c "
                        + "WHERE p.ProductName LIKE ? OR c.ReceivedDate LIKE ? "
                        + "OR c.ConsignmentID LIKE ? OR p.Status LIKE ?";
                stm = conn.prepareStatement(query);
                stm.setString(1, "%" + keywords + "%");
                stm.setString(2, "%" + keywords + "%");
                stm.setString(3, "%" + keywords + "%");
                stm.setString(4, "%" + keywords + "%");
                rs = stm.executeQuery();
            }
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

    private String getType(String type) {
        switch (type) {
            case "Product Name":
                return "c.ProductName";
            case "Received Date":
                return "c.ReceivedDate";
            case "Order ID":
                return "c.ConsignmentID";
            case "Status":
                return "p.Status";
            default:
                return "";
        }
    }

    public UsersDTO getConsignorInforByConsignmentID(String id) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Users u WHERE u.UserID = (SELECT c.ConsignorID FROM Consignment c WHERE c.ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                String userID, password, fullName, address, phone, email, creditCardNumber, creditCardOnwer, role;
                userID = rs.getString(1);
                password = rs.getString(2);
                fullName = rs.getString(3);
                address = rs.getString(4);
                phone = rs.getString(5);
                email = rs.getString(6);
                creditCardNumber = rs.getString(7);
                creditCardOnwer = rs.getString(8);
                role = rs.getString(9);
                return new UsersDTO(userID, password, fullName, address, phone, email, creditCardNumber, creditCardOnwer, role);
            }
            return null;
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

    public UsersDTO getConsigneeInforByConsignmentID(String id) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Users u WHERE u.UserID = (SELECT c.ConsigneeID FROM Consignment c WHERE c.ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                String userID, password, fullName, address, phone, email, creditCardNumber, creditCardOnwer, role;
                userID = rs.getString(1);
                password = rs.getString(2);
                fullName = rs.getString(3);
                address = rs.getString(4);
                phone = rs.getString(5);
                email = rs.getString(6);
                creditCardNumber = rs.getString(7);
                creditCardOnwer = rs.getString(8);
                role = rs.getString(9);
                return new UsersDTO(userID, password, fullName, address, phone, email, creditCardNumber, creditCardOnwer, role);
            }
            return null;
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

    public float getConsignmentPrice(String consignmentID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * from Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getFloat("Price");
            }
            return -1;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return -1;
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
