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

    public List<ProductDTO> getProductStatus(String storeOwnerID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ProductDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT p.ProductID, p.ProductName, c.ReceivedDate, c.ConsignmentID, c.ReturnedPrice, p.ProductStatusID"
                    + " FROM Product p ,Consignment c"
                    + " WHERE c.StoreOwnerID = ? AND p.ProductStatusID != ? AND p.ProductID = c.ProductID"
                    + " ORDER BY p.ProductStatusID";
            stm = conn.prepareStatement(query);
            stm.setInt(1,Integer.parseInt(storeOwnerID));
            stm.setInt(2, 0);
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
                price = Float.parseFloat(rs.getString("ReturnedPrice"));
                status = Integer.parseInt(rs.getString("ProductStatusID"));
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

    public boolean cancelProduct(String productID) // trả về true nếu thành công
    // trả về false nếu không thành công
    {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        int resultUpdateProduct;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Status = ? WHERE ProductID = ?";
            stmUpdateProduct = conn.prepareStatement(query);
            stmUpdateProduct.setInt(1, GlobalVariables.CANCEL);
            stmUpdateProduct.setInt(2, Integer.parseInt(productID));
            resultUpdateProduct = stmUpdateProduct.executeUpdate();
            if (resultUpdateProduct > 0) {
                return true;
            } else {
                return false;
            }
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
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public List<ProductDTO> searchProduct(String keywords, String type, String storeOwnerID) {
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
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.ReturnedPrice,p.Status "
                        + "FROM Product p ,Consignment c "
                        + "WHERE ? LIKE ? AND c.StoreOwnerID = ? AND p.ProductID = c.ProductID";
                stm = conn.prepareStatement(query);
                stm.setString(1, searchType);
                stm.setString(2, "%" + keywords + "%");
                stm.setInt(3, Integer.parseInt(storeOwnerID));
                rs = stm.executeQuery();
            } else {
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.ReturnedPrice,p.Status "
                        + "FROM Product p ,Consignment c "
                        + "WHERE p.ProductID = c.ProductID AND (p.ProductName LIKE ? OR c.ReceivedDate LIKE ? "
                        + "OR c.ConsignmentID LIKE ? OR p.Status LIKE ? ) AND c.StoreOwnerID = ?";
                stm = conn.prepareStatement(query);
                stm.setString(1, "%" + keywords + "%");
                stm.setString(2, "%" + keywords + "%");
                stm.setString(3, "%" + keywords + "%");
                stm.setString(4, "%" + keywords + "%");
                stm.setInt(5, Integer.parseInt(storeOwnerID));
                rs = stm.executeQuery();
            }
            while (rs.next()) {
                productID = Integer.parseInt(rs.getString("ProductID"));
                productName = rs.getString("ProductName");
                receivedDate = rs.getString("ReceivedDate");
                consignmentID = rs.getString("ConsignmentID");
                price = Float.parseFloat(rs.getString("ReturnedPrice"));
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
                return "p.ProductName";
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

    public UsersDTO getConsignorInforByConsignmentID(String consignmentID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName, address, phone, email, creditCardNumber, creditCardOnwer;
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                creditCardNumber = rs.getString("CardNumber");
                creditCardOnwer = rs.getString("CardOwner");
                float consignedPrice = rs.getFloat("ReturnedPrice");
                return new UsersDTO(fullName, address, phone, email, creditCardNumber, creditCardOnwer, consignedPrice);
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
            String query = "SELECT * FROM Account a WHERE a.AccountID = "
                    + "(SELECT s.AccountID FROM StoreOwner s WHERE s.StoreOwnerID = "
                    + "(SELECT c.StoreOwnerID FROM Consignment c WHERE c.ConsignmentID = ?))";
            stm = conn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName, address, phone, email, creditCardNumber, creditCardOnwer;
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                creditCardNumber = rs.getString("CardNumber");
                creditCardOnwer = rs.getString("CardOwner");
                return new UsersDTO(fullName, address, phone, email, creditCardNumber, creditCardOnwer);
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
                return rs.getFloat("ReturnedPrice");
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

    public UsersDTO getCustomerInforByProductID(int id) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * from [Order] c WHERE c.OrderID = (SELECT p.OrderID FROM Product p WHERE ProductID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("FullName");
                String Address = rs.getString("Address");
                String Phone = rs.getString("Phone");
                String Email = rs.getString("Email");
                String CardNumber = rs.getString("CardNumber");
                String CardOwner = rs.getString("CardOwner");
                return new UsersDTO(fullName, Address, Phone, Email, CardNumber, CardOwner);
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
}
