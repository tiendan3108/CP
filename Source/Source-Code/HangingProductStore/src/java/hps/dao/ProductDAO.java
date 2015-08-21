/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.OrderDTO;
import hps.dto.ProductDTO;
import hps.dto.StatisticDTO;
import hps.dto.productDetailDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.JavaUltilities;
import hps.ultils.OrderStatus;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
            String query = "select top 15 * from Product,Category,Consignment "
                    + "Where Product.CategoryID = Category.CategoryID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And Product.ProductStatusID in (?,?) "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.ProductID not in (select ProductID from Product_Season) "
                    + "And Consignment.ConsignmentStatusID = ? "
                    + "order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setInt(2, ProductStatus.ORDERED);
            stm.setInt(3, ConsignmentStatus.RECEIVED);
            //stm.setString(3, newDate);
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
                    + "and Product.ProductStatusID in (?,?)";
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
                int newStatus = rs.getInt("NewStatus");
                product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, parentCategoryID);
                product.setNewStatus(newStatus);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    // + "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, productID);
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, ConsignmentStatus.RECEIVED);
            //stm.setString(5, newDate);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate, ? ) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b, Category c "
                    + "   Where a.CategoryID = c.CategoryID "
                    + "   And a.ProductID = b.ProductID "
                    + "   And a.ProductStatusID in (?,?) "
                    + "   And b.ConsignmentStatusID = ? "
                    + "   And a.ProductName like ? "
                    + "   And c.ParentID = ? "
                    //+ "   And DATEDIFF(day,b.ReceivedDate, ?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            //stm.setString(1, newDate);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, parentCategoryID);
            stm.setInt(4, ProductStatus.ON_WEB);
            stm.setInt(5, ProductStatus.ORDERED);
            stm.setInt(6, next);
            stm.setInt(7, ProductStatus.ON_WEB);
            stm.setInt(8, ProductStatus.ORDERED);
            //stm.setString(9, newDate);
            stm.setInt(9, ConsignmentStatus.RECEIVED);
            stm.setString(10, "%" + name + "%");
            stm.setInt(11, parentCategoryID);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            //stm.setString(1, newDate);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "And Product.CategoryID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b, Category c"
                    + "   Where a.CategoryID = c.CategoryID "
                    + "   And a.ProductID = b.ProductID "
                    + "   And a.ProductStatusID in (?,?) "
                    + "   And a.ProductID = b.ProductID "
                    + "   And b.ConsignmentStatusID = ? "
                    + "   And a.CategoryID = ? "
                    //+ "   And DATEDIFF(day,b.ReceivedDate, ?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            //stm.setString(1, newDate);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
            stm.setInt(2, categoryID);
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, next);
            stm.setInt(6, ProductStatus.ON_WEB);
            stm.setInt(7, ProductStatus.ORDERED);
            //stm.setString(8, newDate);
            stm.setInt(8, ConsignmentStatus.RECEIVED);
            stm.setInt(9, categoryID);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate, ?) < Consignment.Period "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
            stm.setInt(4, ConsignmentStatus.RECEIVED);
            //stm.setString(4, newDate);
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
                    + "FROM Product, Category, Consignment "
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Consignment.ProductID = Product.ProductID "
                    + "And Category.ParentID = ? "
                    + "And Consignment.ConsignmentStatusID = ?"
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) p.ProductID "
                    + "   FROM Product p, Category c, Consignment co "
                    + "   Where p.CategoryID = c.CategoryID "
                    + "   and p.ProductID = co.ProductID "
                    + "   and p.ProductStatusID in (?,?) "
                    + "   And co.ConsignmentStatusID = ? "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentCategoryID);
            stm.setInt(2, ConsignmentStatus.RECEIVED);
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, next);
            stm.setInt(6, ProductStatus.ON_WEB);
            stm.setInt(7, ProductStatus.ORDERED);
            stm.setInt(8, ConsignmentStatus.RECEIVED);
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
                    + "FROM Product, Category, Consignment"
                    + "WHERE Product.CategoryID = Category.CategoryID "
                    + "And Consignment.ProductID = Product.ProductID "
                    + "And Category.ParentID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Consignment.ConsignmentStatusID = ? "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            stm.setInt(1, parentcategoryID);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
            stm.setInt(4, ConsignmentStatus.RECEIVED);
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate,?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Product.ProductID NOT IN "
                    + "  (SELECT TOP (?) a.ProductID "
                    + "   FROM Product a, Consignment b, Category c "
                    + "   Where a.CategoryID = c.CategoryID "
                    + "   And a.ProductID = b.ProductID "
                    + "   And a.ProductStatusID in (?,?) "
                    + "   And b.ConsignmentStatusID = ? "
                    + "   And a.ProductName like ? "
                    //+ "   And DATEDIFF(day,b.ReceivedDate,?) < b.Period "
                    + "   ORDER BY ProductID ASC) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            //stm.setString(1, newDate);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
            stm.setString(2, "%" + name + "%");
            stm.setInt(3, ProductStatus.ON_WEB);
            stm.setInt(4, ProductStatus.ORDERED);
            stm.setInt(5, next);
            stm.setInt(6, ProductStatus.ON_WEB);
            stm.setInt(7, ProductStatus.ORDERED);
            //stm.setString(8, newDate);
            stm.setInt(8, ConsignmentStatus.RECEIVED);
            stm.setString(9, "%" + name + "%");
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
                    + "And Consignment.ConsignmentStatusID = ? "
                    //+ "And DATEDIFF(day,Consignment.ReceivedDate,?) < Consignment.Period "
                    + "And Product.ProductName like ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "ORDER BY Product.ProductID ASC";
            stm = con.prepareStatement(query);
            //stm.setString(1, newDate);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
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
                    + "FROM Product, Product_Season, Category,Consignment "
                    + "WHERE Product.ProductID = Product_Season.ProductID "
                    + "And Product.ProductID = Consignment.ProductID "
                    + "And Product.CategoryID = Category.CategoryID "
                    + "And Product_Season.SeasonID = ? "
                    + "And Product.ProductStatusID in (?,?) "
                    + "And Consignment.ConsignmentStatusID = ? "
                    + "Order by Product.ProductID desc";
            stm = con.prepareStatement(query);
            stm.setInt(1, seasonId);
            stm.setInt(2, ProductStatus.ON_WEB);
            stm.setInt(3, ProductStatus.ORDERED);
            stm.setInt(4, ConsignmentStatus.RECEIVED);
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
                int isSpecial = rs.getInt("IsSpecial");
                product.setIsSpecial(isSpecial);
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
            stm.setInt(2, ProductStatus.ORDERED);
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

    public productDetailDTO getProductAndStoreDetailByID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        productDetailDTO product = new productDetailDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select Product.Brand, Product.ProductName, Account.Address, Account.FullName, Account.Phone, Account.Email "
                    + "from Product, Consignment,StoreOwner,Account "
                    + "where Product.ProductID = Consignment.ProductID "
                    + "and Consignment.StoreOwnerID = StoreOwner.StoreOwnerID "
                    + "and StoreOwner.AccountID = Account.AccountID "
                    + "and Product.ProductID = ? ";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("ProductName");
                String brand = rs.getString("Brand");
                String address = rs.getString("Address");
                String fullName = rs.getString("FullName");
                String phone = rs.getString("phone");
                String email = rs.getString("Email");
                product = new productDetailDTO(productID, brand, productName, address, fullName, phone, email);
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

    public ProductDTO getDetailByID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Product, Consignment "
                    + "where Product.ProductID = ? "
                    + "And Product.ProductID = Consignment.ProductID";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("ProductName");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice");
                int isSpecial = rs.getInt("IsSpecial");
                product.setName(productName);
                product.setNegotiatedPrice(negotiatedPrice);
                product.setIsSpecial(isSpecial);
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

    //start merge
    //duchcDAO
    public int addProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Product(ProductName, SerialNumber, NewStatus, CategoryID, Brand, "
                    + "Description, Image, ProductStatusID, IsSpecial) "
                    + " VALUES(?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
//            stm = con.prepareStatement(query);
            stm.setString(1, product.getName());
            if (product.getSerialNumber().equals("")) {
                stm.setNull(2, java.sql.Types.VARCHAR);
            } else {
                stm.setString(2, product.getSerialNumber());
            }
            if (product.getNewStatus() > 0) {
                stm.setInt(3, product.getNewStatus());

            } else {
                stm.setNull(3, java.sql.Types.INTEGER);
            }

            stm.setInt(4, product.getCategoryID());
            if (product.getBrand().equals("")) {
                stm.setNull(5, java.sql.Types.VARCHAR);
            } else {
                stm.setString(5, product.getBrand());
            }
            if (product.getDescription().equals("")) {
                stm.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(6, product.getDescription());
            }

            stm.setString(7, product.getImage());

            stm.setInt(8, product.getProductStatusID());

            stm.setInt(9, product.getIsSpecial());

            int result = stm.executeUpdate();
            if (result > 0) {
                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    return id;
                }
            }
            return -1;
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
        return -1;
    }

    //ProductDAO
    public boolean cancelProduct(String consignmentID, int status, float cancelFee) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        PreparedStatement stmUpdateConsignment = null;
        cancelFee = cancelFee * 1000;
        int resultUpdateProduct, resultUpdateConsignment;
        String query = "";
        Date tempDate = Calendar.getInstance().getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String today = sdf.format(tempDate);
        try {
            conn = DBUltilities.makeConnection();
            if (status == ProductStatus.NOT_YET_RECEIVE) {// agree cancel product 
                conn.setAutoCommit(false);
                //update set product to agree cancel but not yet receive by consignor
                query = "UPDATE Product SET ProductStatusID = ? WHERE "
                        + "ProductID = (SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.NOT_YET_RECEIVE);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();

                //update set consignment status
                query = "UPDATE Consignment SET ConsignmentStatusID = ?, CancelFee = ? WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setInt(1, ConsignmentStatus.CANCEL);
                stmUpdateConsignment.setFloat(2, cancelFee);
                stmUpdateConsignment.setString(3, consignmentID);
                resultUpdateConsignment = stmUpdateConsignment.executeUpdate();

                if (resultUpdateProduct > 0 && resultUpdateConsignment > 0) {
                    conn.commit();
                    return true;
                } else {
                    return false;
                }
            } else if (status == ProductStatus.NOT_AVAILABLE) {// consignor come and take back product
                conn.setAutoCommit(false);
                //update set product to not available after consignor take it back
                query = "UPDATE Product SET ProductStatusID = ? WHERE "
                        + "ProductID = (SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.NOT_AVAILABLE);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();

                //update consignment set cancel date, cancel fee
                query = "UPDATE Consignment SET AgreeCancelDate = ?, CancelFee = ?, ConsignmentStatusID = ? WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setString(1, today);
                stmUpdateConsignment.setFloat(2, cancelFee);
                stmUpdateConsignment.setInt(3, ConsignmentStatus.CANCEL);
                stmUpdateConsignment.setString(4, consignmentID);
                resultUpdateConsignment = stmUpdateConsignment.executeUpdate();

                if (resultUpdateProduct > 0 && resultUpdateConsignment > 0) {
                    conn.commit();
                    return true;
                } else {
                    return false;
                }
            } else {//decline cancel request
                conn.setAutoCommit(false);
                //update product to on web
                query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = "
                        + "(SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.ON_WEB);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();
                //update consignment back to received
                query = "UPDATE Consignment SET CancelDate = NULL, ConsignmentStatusID = ? WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setInt(1, ConsignmentStatus.RECEIVED);
                stmUpdateConsignment.setString(2, consignmentID);
                resultUpdateConsignment = stmUpdateConsignment.executeUpdate();
                query = "UPDATE Consignment SET RaiseWebDate = ? WHERE ConsignmentID = ? AND RaiseWebDate IS NULL";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setString(1, today);
                stmUpdateConsignment.setString(2, consignmentID);
                stmUpdateConsignment.executeUpdate();
                if (resultUpdateProduct > 0 && resultUpdateConsignment > 0) {
                    conn.commit();
                    return true;
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean soldProduct(String consignmentID, float returnPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        int result1 = 0, result2 = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String today = sdf.format(tempDate);

            query = "UPDATE Consignment SET ReturnedPrice = ?, ReturnDate = ?, ConsignmentStatusID = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setFloat(1, returnPrice);
            stm.setString(2, today);
            stm.setInt(3, ConsignmentStatus.COMPLETED);
            stm.setString(4, consignmentID);
            result1 = stm.executeUpdate();
            query = "UPDATE Product set ProductStatusID = ? WHERE ProductID = "
                    + "(SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.COMPLETED);
            stm.setString(2, consignmentID);
            result2 = stm.executeUpdate();
            return (result1 > 0 && result2 > 0);
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean publishOnWeb(ProductDTO product, List<String> season, boolean flag) {
        Connection conn = null;
        PreparedStatement stmProduct = null;
        PreparedStatement stmConsignment = null;
        int resultProduct = 0;
        int resultConsignment = 0;
        ResultSet rs = null;
        String query = "";
        int status = 0;
        if (flag) {
            status = 2;
        } else {
            status = 3;
        }
        List<String> existSeason = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);

            if (product.getIsSpecial() == 2) {
                query = "SELECT IsSpecial FROM Product WHERE ProductID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setInt(1, product.getProductID());
                rs = stmProduct.executeQuery();
                while (rs.next()) {
                    product.setIsSpecial(rs.getInt("IsSpecial"));
                }
            }

            if (product.getImage() == null) {
                query = "UPDATE Product SET "
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, "
                        + "Description = ?, ProductStatusID = 3, IsSpecial = ?, NewStatus = ? "
                        + "WHERE ProductID = ? AND ProductStatusID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setInt(6, product.getIsSpecial());
                stmProduct.setInt(7, product.getNewStatus());
                stmProduct.setInt(8, product.getProductID());
                stmProduct.setInt(9, status);
            } else {
                query = "UPDATE Product SET "
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, "
                        + "Description = ?, Image = ?, ProductStatusID = 3 , IsSpecial = ?, NewStatus = ? "
                        + "WHERE ProductID = ? AND ProductStatusID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setString(6, product.getImage());
                stmProduct.setInt(7, product.getIsSpecial());
                stmProduct.setInt(8, product.getNewStatus());
                stmProduct.setInt(9, product.getProductID());
                stmProduct.setInt(10, status);
            }
            resultProduct = stmProduct.executeUpdate();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String raiseWebDate = sdf.format(tempDate);

            query = "UPDATE Consignment SET RaiseWebDate = ? WHERE ProductID = ?";
            stmConsignment = conn.prepareStatement(query);
            stmConsignment.setString(1, raiseWebDate);
            stmConsignment.setInt(2, product.getProductID());
            resultConsignment = stmConsignment.executeUpdate();
            //get exist season of product
            query = "SELECT SeasonID FROM Product_Season WHERE ProductID = ?";
            stmProduct = conn.prepareStatement(query);
            stmProduct.setInt(1, product.getProductID());
            rs = stmProduct.executeQuery();
            while (rs.next()) {
                existSeason.add(rs.getInt("SeasonID") + "");
            }
            // insert if not exist
            for (String item : season) {
                if (!existSeason.contains(item)) {
                    query = "INSERT INTO Product_Season VALUES (?,?)";
                    stmProduct = conn.prepareCall(query);
                    stmProduct.setInt(1, product.getProductID());
                    stmProduct.setInt(2, Integer.parseInt(item));
                    stmProduct.execute();
                }
            }
            //detele if no more remain
            for (String item : existSeason) {
                if (!season.contains(item)) {
                    query = "DELETE Product_Season WHERE ProductID = ? AND SeasonID = ?";
                    stmProduct = conn.prepareCall(query);
                    stmProduct.setInt(1, product.getProductID());
                    stmProduct.setInt(2, Integer.parseInt(item));
                    stmProduct.execute();
                }
            }
            if (resultProduct > 0 && resultConsignment > 0) {
                conn.commit();
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmProduct != null) {
                    stmProduct.close();
                }
                if (stmConsignment != null) {
                    stmConsignment.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ProductDTO getProductByProductID(int productID) {
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
                float sellingPrice = rs.getFloat("SellingPrice") / 1000;
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

    public ProductDTO getInforForPublishPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO result = null;
        String productName = "", serialNumber = "", brand = "", description = "", image = "";
        int categoryID = 0, isSpecial = 0, newstatus = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT ProductName, SerialNumber, NewStatus, "
                    + "CategoryID, Brand, Description, Image, IsSpecial "
                    + "FROM Product WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                productName = rs.getString("ProductName");
                serialNumber = rs.getString("SerialNumber");
                newstatus = rs.getInt("NewStatus");
                brand = rs.getString("Brand");
                newstatus = rs.getInt("NewStatus");
                description = rs.getString("Description");
                image = rs.getString("Image");
                categoryID = rs.getInt("CategoryID");
                isSpecial = rs.getInt("IsSpecial");
                result = new ProductDTO(productID, productName, serialNumber, newstatus, categoryID, brand, description, image, isSpecial);
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return result;
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
    }

    public int getProductIDByConsignmentID(String consignmentID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();

            query = "SELECT ProductID FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("ProductID");
            }
            return 0;
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            return 0;
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private String formatDateString(String source) {
        if (source == null) {
            return "";
        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm | dd-MM-yyyy");
            Date date = sdf.parse(source);
            String result = sdf2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    //used
    private String convertPhone(String source) {
        if (source == null) {
            return "";
        }
        return "0" + source.substring(3);
    }

    public ProductDTO getInforForOrderedPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO result = new ProductDTO();
        String query = "";
        List<OrderDTO> listOrder = new ArrayList<>();
        try {
            con = DBUltilities.makeConnection();
            query = "SELECT * FROM [Order] WHERE ProductID = ? AND OrderStatusID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, OrderStatus.WAITING);
            rs = stm.executeQuery();
            while (rs.next()) {
                String orderID = rs.getString("OrderID");
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String email = rs.getString("Email");
                String phone = convertPhone(rs.getString("Phone"));
                String orderDate = formatDateString(rs.getString("Date"));
                float sendPrice = rs.getFloat("SendPrice") / 1000;
                OrderDTO item = new OrderDTO(orderID, orderDate, email, fullName, address, phone);
                item.setSendPrice(sendPrice);
                listOrder.add(item);
            }
            if (!listOrder.isEmpty()) {
                result.setOrderList(listOrder);
            }
            query = "SELECT * FROM Product p , Consignment c WHERE p.ProductID = ? AND p.ProductID = c.ProductID";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                String serialNumber = rs.getString("SerialNumber");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                int isSpecial = rs.getInt("IsSpecial");
                result.setIsSpecial(isSpecial);
                result.setConsignmentID(consignmentID);
                result.setName(productName);
                result.setSerialNumber(serialNumber);
                result.setNegotiatedPrice(negotiatedPrice);
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return result;
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
    }

    public boolean ExtendProduct(String consignmentID, float expiredFee) {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);
            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String today = sdf.format(tempDate);

            String query = "UPDATE Consignment SET ReceivedDate = ?, ConsignmentStatusID = ?, ExpiredFee = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            stm.setInt(2, ConsignmentStatus.COMPLETED);
            stm.setFloat(3, expiredFee);
            stm.setString(4, consignmentID);
            int i = stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.NOT_AVAILABLE);
            stm.setString(2, consignmentID);
            int j = stm.executeUpdate();
            if (i > 0 && j > 0) {
                conn.commit();
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    //extend consignment period
    public boolean ExtendProducts(String consignmentID, float expiredFee, float negotiatedPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int dateFromNow = 0;
        if (negotiatedPrice == 0) {
            return false;
        }
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String today = sdf.format(tempDate);

            String query = "SELECT DATEDIFF(day,[RaiseWebDate],?) as DayFromNow FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            stm.setString(2, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                dateFromNow = rs.getInt("DayFromNow");
            }

            query = "UPDATE Consignment SET RemainExtendFee = 0 WHERE ConsignmentID = ? AND RemainExtendFee IS NULL";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            stm.executeUpdate();

            query = "UPDATE Consignment SET RemainExtendFee = (SELECT RemainExtendFee FROM Consignment WHERE ConsignmentID = ?) + ?, isExpiredMessage = null, ConsignmentStatusID = ?, Period = ?, NegotiatedPrice = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            stm.setFloat(2, expiredFee);
            stm.setInt(3, ConsignmentStatus.RECEIVED);
            stm.setInt(4, 30 + dateFromNow);
            stm.setFloat(5, negotiatedPrice * 1000);
            stm.setString(6, consignmentID);
            int i = stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setString(2, consignmentID);
            int j = stm.executeUpdate();
            if (i > 0 && j > 0) {
                conn.commit();
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean changeProductStatus(String orderID, float sellingPrice) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);
            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sellingDate = sdf.format(tempDate);

            query = "UPDATE Product SET SellDate = ?, SellingPrice = ?, ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, sellingDate);
            stm.setFloat(2, sellingPrice);
            stm.setInt(3, ProductStatus.SOLD);
            stm.setString(4, orderID);
            int i = stm.executeUpdate();
            query = "UPDATE [Order] SET OrderStatusID = ? WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, OrderStatus.COMPLETED);
            stm.setString(2, orderID);
            int j = stm.executeUpdate();
            query = "UPDATE [Order] SET OrderStatusID = ? WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND OrderID != ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, OrderStatus.CANCELED);
            stm.setString(2, orderID);
            stm.setString(3, orderID);
            stm.executeUpdate();
            if (i > 0 && j > 0) {
                conn.commit();
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public List<StatisticDTO> getProductInforForStatisticPage(int roleID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        List<StatisticDTO> result = new ArrayList<>();
        try {

            conn = DBUltilities.makeConnection();
            query = "SELECT c.RemainExtendFee, c.ExpiredFee, p.ProductName, c.FullName, c.NegotiatedPrice, c.ReturnedPrice, "
                    + "p.SellingPrice, c.CancelFee, c.AgreeCancelDate, c.ReturnDate, c.ReceivedDate, "
                    + "CASE WHEN c.AgreeCancelDate IS NOT NULL THEN c.AgreeCancelDate "
                    + "WHEN c.ReturnDate IS NOT NULL THEN c.ReturnDate "
                    + "WHEN c.ReceivedDate IS NOT NULL THEN c.ReceivedDate "
                    + "END AS ActionDate "
                    + "FROM Product p, Consignment c WHERE "
                    + "p.ProductID = c.ProductID AND c.StoreOWnerID = ? AND "
                    + "((c.ConsignmentStatusID = 4 AND p.ProductStatusID = 7 AND c.ReturnDate IS NOT NULL) OR "
                    + "(c.ConsignmentStatusID = 7 AND p.ProductStatusID = 1 AND (c.ReceivedDate IS NOT NULL OR c.AgreeCancelDate IS NOT NULL))) "
                    + "ORDER BY ActionDate";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                String consignorName = rs.getString("FullName");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                float returnPrice = rs.getFloat("ReturnedPrice") / 1000;
                float sellingPrice = rs.getFloat("SellingPrice") / 1000;
                float cancelFee = rs.getFloat("CancelFee") / 1000;
                float expiredFee = rs.getFloat("ExpiredFee") / 1000;
                float remainExtendFee = rs.getFloat("RemainExtendFee") / 1000;
                String actionDate = formatDateString(rs.getString("ActionDate"));
                float revenue = sellingPrice - returnPrice + cancelFee + expiredFee + remainExtendFee;
                StatisticDTO item = new StatisticDTO(productName, consignorName, negotiatedPrice, returnPrice, cancelFee, expiredFee + remainExtendFee, sellingPrice, actionDate, revenue);
                result.add(item);
            }
            if (result.isEmpty()) {
                return null;
            } else {
                return result;
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
