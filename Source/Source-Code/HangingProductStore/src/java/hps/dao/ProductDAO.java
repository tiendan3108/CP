/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class ProductDAO {

    private SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    private Date date = new Date();
    private String newDate = df.format(date);
    static ProductDAO productDAO;

    /**
     *
     * @author HoangNHSE61007 get new product not set season
     */
    public static ProductDAO getInstance() {
        if (productDAO == null) {
            productDAO = new ProductDAO();
        }
        return productDAO;
    }

    public List<ProductDTO> getNewData() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> products = new ArrayList<ProductDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select top 12 * from Product,Category,Consignment "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.ProductID not in (select ProductID from Product_Season) "
                    + "order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setInt(2, ProductStatus.ORDERED);
            stm.setString(3, newDate);
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
                ProductDTO product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get new product information by productID
     */
    public ProductDTO getProductByID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Product,Category "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "and ProductID = ? "
                    + "and Product.ProductStatusID = in (?,?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
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
                product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get product same category
     */
    public List<ProductDTO> getSimilarProduct(int categoryID, int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductDTO> products = new ArrayList<ProductDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select top 8 * from Product,Category, Consignment "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "and Product.CategoryID = ? "
                    + "and Product.ProductID != ? "
                    + "and Product.ProductStatusID in (?,?) "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, productID);
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setString(4, newDate);
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
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get product by category and name for 1 page
     */
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
                    + "FROM Product, Category,Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ? ) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductStatusID = in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b "
                    + "   Where a.ProductStatusID = in (?,?)"
                    + "   And DATEDIFF(day,b.ReceivedDate, ?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, newDate);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, parentCategoryID);
            stm.setInt(4, ProductStatus.ON_WEB);
            stm.setInt(5, ProductStatus.ORDERED);
            stm.setInt(6, next);
            stm.setInt(7, ProductStatus.ON_WEB);
            stm.setInt(8, ProductStatus.ORDERED);
            stm.setString(9, newDate);
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
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get number of product by category and name
     */
    public int getSizeProductByParentCategoryAndName(int parentCategoryID, String name) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, newDate);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, parentCategoryID);
            stm.setInt(4, ProductStatus.ON_WEB);
            stm.setInt(5, ProductStatus.ORDERED);
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

    /**
     *
     * @author HoangNHSE61007 get product by category
     */
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
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.CategoryID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b "
                    + "   Where a.ProductStatusID in (?,?) "
                    + "   And a.ProductID = b.ProductID "
                    + "   And DATEDIFF(day,b.ReceivedDate, ?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, newDate);
            stm.setInt(2, categoryID);
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, next);
            stm.setInt(6, ProductStatus.ON_WEB);
            stm.setInt(7, ProductStatus.ORDERED);
            stm.setString(8, newDate);
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
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get number of product by category
     */
    public int getSizeProductByCategory(int categoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And Product.CategoryID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
            stm.setString(4, newDate);
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

    /**
     *
     * @author HoangNHSE61007 get product by parent category
     */
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
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) ProductID "
                    + "   FROM Product "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentCategoryID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
            stm.setInt(4, next);
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
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get number of product by parent category
     */
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
                    + "And Product.ProductStatusID in (?,?) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentcategoryID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
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

    /**
     *
     * @author HoangNHSE61007 get product by name
     */
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
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And DATEDIFF(day,Consignment.ReceivedDate,?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b "
                    + "   Where a.ProductStatusID in (?,?) "
                    + "   And DATEDIFF(day,b.ReceivedDate,?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, newDate);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, next);
            stm.setInt(6, ProductStatus.ON_WEB);
            stm.setInt(7, ProductStatus.ORDERED);
            stm.setString(8, newDate);
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
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 get number of product by name
     */
    public int getSizeProductByName(String name) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;

        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "SELECT * "
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And DATEDIFF(day,Consignment.ReceivedDate,?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setString(1, newDate);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
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

    /**
     *
     * @author HoangNHSE61007 get product by season
     */
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
                    + "And Product_Season.SeasonID = ? "
                    + "And Product.ProductStatusID in (?,?) ";
            stm = con.prepareStatement(query);
            stm.setInt(1, seasonId);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
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
                int parentCategoryID = rs.getInt("ParentID");
                ProductDTO product = new ProductDTO(id, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
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

    /**
     *
     * @author HoangNHSE61007 update product status to ordered
     */
    public boolean updateStatusToOrdered(int productId) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "update Product set ProductStatusID = ? "
                    + "where ProductID=?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, ProductStatus.ORDERED);
            stm.setInt(2, productId);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ProductDTO getProductByIDNoStatus(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        try {
            con = DBUltilities.makeConnection();
            String query = "select * from Product,Category "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "and ProductID = ? ";
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
                float sellingPrice = rs.getFloat("SellingPrice");
                int parentCategoryID = rs.getInt("ParentID");
                product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
                String sellDate = rs.getString("SellDate");
                if (sellDate != null) {
                    sellDate = df.format(rs.getDate("SellDate"));
                    product.setSellDate(sellDate);
                }
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

    public boolean makeProductAsStatus(int productId, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Product"
                    + " SET ProductStatusID = ?"
                    + " WHERE ProductID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, productId);

            int result = stm.executeUpdate();
            while (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
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
        return false;
    }

    /**
     *
     * @author HoangNHSE61007 check if product is on web
     */
    public boolean checkProduct(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Product "
                    + "Where ProductID = ? "
                    + "and Product.ProductStatusID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, ProductStatus.ON_WEB);
            rs = stm.executeQuery();
            if (rs.next()) {
                return true;
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
        return false;
    }

    public boolean updateProductWhenOrderExpired(int productId) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Product"
                    + " SET ProductStatusID = ? "
                    + " WHERE ProductID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setInt(2, productId);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
