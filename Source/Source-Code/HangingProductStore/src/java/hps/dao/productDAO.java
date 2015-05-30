/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
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
public class productDAO {

    public List<ProductDTO> getNewData() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> products = new ArrayList<ProductDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select top 8 * from Product,Category Where Product.CategoryID = Category.CategoryID order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                float sellingPrice = rs.getFloat("SellingPrice");
                String image = rs.getString("Image");
                String receivedDay = rs.getString("ReceivedDay");
                int categoryID = rs.getInt("CategoryID");
                int parentCategoryID = rs.getInt("ParentID");
                ProductDTO product = new ProductDTO(productID, productName, status, description, sellingPrice, image, receivedDay, categoryID, parentCategoryID);
                products.add(product);
                System.out.println(product.getImage());
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public ProductDTO getProductByID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Product,Category Where Product.CategoryID = Category.CategoryID and ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("ProductName");
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                float sellingPrice = rs.getFloat("SellingPrice");
                String image = rs.getString("Image");
                String receivedDay = rs.getString("ReceivedDay");
                int categoryID = rs.getInt("CategoryID");
                int parentCategoryID = rs.getInt("ParentID");
                product = new ProductDTO(productID, productName, status, description, sellingPrice, image, receivedDay, categoryID, parentCategoryID);
            }
            return product;
        } catch (SQLException ex) {
            Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public List<ProductDTO> getSimilarProduct(int categoryID,int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> products = new ArrayList<ProductDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select top 8 * from Product,Category "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "and Product.CategoryID = ? "
                    + "and Product.ProductID != ? "
                    + "order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                float sellingPrice = rs.getFloat("SellingPrice");
                String image = rs.getString("Image");
                String receivedDay = rs.getString("ReceivedDay");
                int parentCategoryID = rs.getInt("ParentID");
                ProductDTO product = new ProductDTO(id, productName, status, description, sellingPrice, image, receivedDay, categoryID, parentCategoryID);
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
