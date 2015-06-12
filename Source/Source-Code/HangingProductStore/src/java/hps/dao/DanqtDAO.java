/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import java.util.List;
import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
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

    public List<ProductDTO> getProductStatus(int storeOwnerID) {
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
            stm.setInt(1, storeOwnerID);
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

    public boolean payConsignor(int productID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        int result;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = ? AND ProductStatusID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, 7);
            stm.setInt(2, productID);
            stm.setInt(3, 5);
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

    public boolean cancelProduct(int productID) // trả về true nếu thành công
    // trả về false nếu không thành công
    {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        int resultUpdateProduct;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = ? and ProductStatusID = ?";
            stmUpdateProduct = conn.prepareStatement(query);
            stmUpdateProduct.setInt(1, 6);
            stmUpdateProduct.setInt(2, productID);
            stmUpdateProduct.setInt(2, 7);
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
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.ReturnedPrice,p.ProductStatusID "
                        + "FROM Product p ,Consignment c "
                        + "WHERE ? LIKE ? AND c.StoreOwnerID = ? AND p.ProductID = c.ProductID";
                stm = conn.prepareStatement(query);
                stm.setString(1, searchType);
                stm.setString(2, "%" + keywords + "%");
                stm.setInt(3, Integer.parseInt(storeOwnerID));
                rs = stm.executeQuery();
            } else {
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.ReturnedPrice,p.ProductStatusID "
                        + "FROM Product p ,Consignment c "
                        + "WHERE p.ProductID = c.ProductID AND (p.ProductName LIKE ? OR c.ReceivedDate LIKE ? "
                        + "OR c.ConsignmentID LIKE ? OR p.ProductStatusID LIKE ? ) AND c.StoreOwnerID = ?";
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

    private String getType(String type) {
        switch (type) {
            case "Tên sản phẩm":
                return "p.ProductName";
            case "Ngày nhận hàng":
                return "c.ReceivedDate";
            case "Mã kí gửi":
                return "c.ConsignmentID";
            case "Trạng thái":
                return "p.ProductStatusID";
            default:
                return "";
        }
    }

    public AccountDTO getConsignorInforByConsignmentID(String consignmentID) {
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
                String fullName, address, phone, email, paypalAccount;
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                paypalAccount = rs.getString("PaypalAccount");
                float consignedPrice = rs.getFloat("ReturnedPrice");
                return new AccountDTO(fullName, address, phone, email, paypalAccount, consignedPrice);
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

    public AccountDTO getConsigneeInforByConsignmentID(String id) {
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
                String fullName, address, phone, email, paypalAccount;
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                paypalAccount = rs.getString("PaypalAccount");
                return new AccountDTO(fullName, address, phone, email, paypalAccount);
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

    public AccountDTO getCustomerInforByProductID(int id) {
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
                String paypalAccount = rs.getString("CardNumber");
                return new AccountDTO(fullName, Address, Phone, Email, paypalAccount);
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

//    public AccountDTO checkLogin(String username, String password) {
//        Connection conn = null;
//        ResultSet rs = null;
//        PreparedStatement stm = null;
//        try {
//            conn = DBUltilities.makeConnection();
//            String query = "SELECT * from Account WHERE AccountID = ? and Password = ?";
//            stm = conn.prepareStatement(query);
//            stm.setString(1, username);
//            stm.setString(2, password);
//            rs = stm.executeQuery();
//            while (rs.next()) {
//                String AccountID = rs.getString("AccountID");
//                String Password = rs.getString("Password");
//                String Status = rs.getString("Status");
//                String FullName = rs.getString("FullName");
//                String Address = rs.getString("Address");
//                String Phone = rs.getString("Phone");
//                String Email = rs.getString("Email");
//                String PaypalAccount = rs.getString("PaypalAccount");
//                String Role = rs.getString("Role");
//                return new AccountDTO(AccountID, Password, Status, FullName, Address, Phone, Email, PaypalAccount, Role);
//            }
//            return null;
//        } catch (SQLException e) {
//            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
//            return null;
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (stm != null) {
//                    stm.close();
//                }
//                if (conn != null) {
//                    conn.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//    }
    public boolean publishOnWeb(ProductDTO product) {
        Connection conn = null;
        PreparedStatement stm = null;
        int result = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "UPDATE Product SET "
                    + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, Description = ?, ProductStatusID = 3 "
                    + "WHERE ProductID = ? AND ProductStatusID = 2";
            stm = conn.prepareStatement(query);
            stm.setString(1, product.getName());
            stm.setString(2, product.getSerialNumber());
            stm.setInt(3, product.getCategoryID());
            stm.setString(4, product.getBrand());
            stm.setString(5, product.getDescription());
            stm.setInt(6, product.getProductID());
            result = stm.executeUpdate();
            if (result > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
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

    public int getCategoryIDByCategoryNameAndParentCategoryName(String parentCat, String childCat) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT CategoryID FROM Category WHERE CategoryName = ? AND ParentID = (SELECT CategoryID FROM Category WHERE CategoryName = ?)";
            stm = con.prepareStatement(query);
            stm.setString(1, childCat);
            stm.setString(2, parentCat);
            System.out.println(stm.toString());
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("CategoryID");
            }
            return -1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
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

    public boolean updateProductImage(String image, int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Image = ? WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, "assets/image/" + image);
            stm.setInt(2, productID);
            return (stm.executeUpdate() > 0);
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
