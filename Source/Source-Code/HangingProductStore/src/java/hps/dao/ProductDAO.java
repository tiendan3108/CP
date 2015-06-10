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
public class ProductDAO {

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
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                int categoryID = rs.getInt("CategoryID");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int parentCategoryID = rs.getInt("ParentID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                int categoryID = rs.getInt("CategoryID");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int parentCategoryID = rs.getInt("ParentID");
                int orderID = rs.getInt("OrderID");
                product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
            }
            return product;
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

    public List<ProductDTO> getSimilarProduct(int categoryID, int productID) {
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
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int parentCategoryID = rs.getInt("ParentID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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

    public List<ProductDTO> getProductByParentCategoryAndName(int parentCategoryID, String name, int page) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int next = (page - 1) * 6;
        List<ProductDTO> products = new ArrayList<ProductDTO>();

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT TOP 6 * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) ProductID "
                    + "   FROM Product "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setInt(2, parentCategoryID);
            stm.setInt(3, next);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int categoryID = rs.getInt("CategoryID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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

    public int getSizeProductByParentCategoryAndName(int parentCategoryID, String name) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setInt(2, parentCategoryID);
            rs = stm.executeQuery();
            while (rs.next()) {
                total++;
            }
            return total;
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

    public List<ProductDTO> getProductByCategory(int categoryID, int page) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int next = (page - 1) * 6;
        List<ProductDTO> products = new ArrayList<ProductDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT Top 6 * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.CategoryID = ? "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) ProductID "
                    + "   FROM Product "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, next);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int parentCategoryID = rs.getInt("ParentID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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

    public int getSizeProductByCategory(int categoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.CategoryID = ? "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();
            while (rs.next()) {
                total++;
            }
            return total;
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

    public List<ProductDTO> getProductByParentCategory(int parentCategoryID, int page) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int next = (page - 1) * 6;
        List<ProductDTO> products = new ArrayList<ProductDTO>();

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT TOP 6 * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) ProductID "
                    + "   FROM Product "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentCategoryID);
            stm.setInt(2, next);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int categoryID = rs.getInt("CategoryID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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

    public int getSizeProductByParentCategory(int parentcategoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Category.ParentID = ? "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentcategoryID);
            rs = stm.executeQuery();
            while (rs.next()) {
                total++;
            }
            return total;
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

    public List<ProductDTO> getProductByName(String name, int page) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int next = (page - 1) * 6;
        List<ProductDTO> products = new ArrayList<ProductDTO>();

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT TOP 6 * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductName like ? "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) ProductID "
                    + "   FROM Product "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setInt(2, next);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int categoryID = rs.getInt("CategoryID");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int parentCategoryID = rs.getInt("ParentID");
                int orderID = rs.getInt("OrderID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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

    public int getSizeProductByName(String name) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductName like ? "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, name);
            rs = stm.executeQuery();
            while (rs.next()) {
                total++;
            }
            return total;
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
public List<ProductDTO> getProductBySeason(int seasonId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> products = new ArrayList<ProductDTO>();

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT TOP 15 * "
                    + "FROM Product, Product_Season, Category "
                    + "WHERE Product.ProductID = Product_Season.ProductID "
                    + "And Product.CategoryID = Category.CategoryID "
                    + "And Product_Season.SeasonID = ? ";
            stm = con.prepareStatement(query);
            stm.setInt(1, seasonId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("SerialNumber");
                String purchasedDate = rs.getString("PurchasedDate");
                String brand = rs.getString("Brand");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                int productStatusID = rs.getInt("ProductStatusID");
                float sellingPrice = rs.getFloat("SellingPrice");;
                int categoryID = rs.getInt("CategoryID");
                int orderID = rs.getInt("OrderID");
                int parentCategoryID = rs.getInt("ParentID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID, orderID);
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
}
