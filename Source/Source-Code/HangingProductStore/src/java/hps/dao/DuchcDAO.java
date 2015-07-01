/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.dto.ConsignmentDTO;
import hps.ultils.AmazonService;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import hps.ultils.AmazonProduct;

/**
 *
 * @author Robingios
 */
public class DuchcDAO {

    // add new product
    public int addProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Product(ProductName, SerialNumber, PurchasedDate, CategoryID, Brand, Description, "
                    + " Image, ProductStatusID)\n"
                    + " VALUES(?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
//            stm = con.prepareStatement(query);
            stm.setString(1, product.getName());
            if (product.getSerialNumber().equals("")) {
                stm.setNull(2, java.sql.Types.VARCHAR);
            } else {
                stm.setString(2, product.getSerialNumber());
            }
            if (product.getPurchasedDate().equals("")) {
                stm.setNull(3, java.sql.Types.DATE);
            } else {
                stm.setString(3, product.getPurchasedDate());
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
            if (product.getImage().equals("")) {
                stm.setNull(7, java.sql.Types.VARCHAR);
            } else {
                stm.setString(7, product.getImage());
            }

            stm.setInt(8, product.getProductStatusID());

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
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return -1;
    }

    //add new consignment
    public boolean addConsigment(ConsignmentDTO consigment) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Consignment(ConsignmentID, ProductID, MemberID, StoreOwnerID, FullName, Address,"
                    + " Phone, Email, PaypalAccount,\n"
                    + "                     FromDate, ToDate, Period, MinPrice, MaxPrice, CreatedDate, ConsignmentStatusID)\n"
                    + "                     VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query);
            stm.setString(1, consigment.getConsigmentID());
            stm.setInt(2, consigment.getProductID());

            if (consigment.getMemberID() > 0) {
                stm.setInt(3, consigment.getMemberID());
            } else {
                stm.setNull(3, java.sql.Types.INTEGER);
            }

            stm.setInt(4, consigment.getStoreOwnerID());

            stm.setString(5, consigment.getName());

            if (consigment.getAddress().equals("")) {
                stm.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(6, consigment.getAddress());
            }
            if (consigment.getPhone().equals("")) {
                stm.setNull(7, java.sql.Types.VARCHAR);
            } else {
                stm.setString(7, consigment.getPhone());
            }
            if (consigment.getEmail().equals("")) {
                stm.setNull(8, java.sql.Types.VARCHAR);
            } else {
                stm.setString(8, consigment.getEmail());
            }

            if (consigment.getPaypalAccount().equals("")) {
                stm.setNull(9, java.sql.Types.VARCHAR);
            } else {
                stm.setString(9, consigment.getPaypalAccount());
            }
            stm.setString(10, consigment.getFromDate());
            stm.setString(11, consigment.getToDate());
            stm.setInt(12, consigment.getPeriod());

            if (consigment.getMinPrice() > 0) {
                stm.setDouble(13, consigment.getMinPrice());
            } else {
                stm.setNull(13, java.sql.Types.FLOAT);
            }
            if (consigment.getMaxPrice() > 0) {
                stm.setDouble(14, consigment.getMaxPrice());
            } else {
                stm.setNull(14, java.sql.Types.FLOAT);
            }
            Date date = new Date();
            DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            stm.setString(15, dateFormat.format(date));
            stm.setInt(16, consigment.getConsignmentStatusID());
            int result = stm.executeUpdate();
            return result > 0;
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return false;
    }

    //duchc _get all store owners based on categoryID actor choose in consign_step1
    public List<AccountDTO> getListStoreOwnerByCategory(int categoryID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     c.StoreOwnerID, a.FullName, a.Address, a.Phone, a.Email , s.Formula\n"
                    + "                     FROM         dbo.Account AS a INNER JOIN\n"
                    + "                                           dbo.StoreOwner AS s ON a.AccountID = s.AccountID INNER JOIN\n"
                    + "                                           dbo.StoreOwner_Category AS c ON s.StoreOwnerID = c.StoreOwnerID\n"
                    + "                     WHERE     (c.CategoryID = ?) ORDER BY Formula DESC";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();
            List<AccountDTO> list = new ArrayList<AccountDTO>();
            while (rs.next()) {
                AccountDTO store = new AccountDTO();
                store.setRoleID(rs.getInt("StoreOwnerID"));
                store.setFullName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setPhone(rs.getString("Phone"));
                store.setEmail(rs.getString("Email"));
                store.setFormula(rs.getFloat("Formula"));
                list.add(store);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }

    // get store owner Information
    public AccountDTO getStoreOwnerByID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // Join 3 bang Account, StoreOwner va StoreOwner_Category de lay thong tin ve storeowner ung voi category
            String query = "SELECT     S.StoreOwnerID, A.FullName, A.Address, A.Phone, A.Email, S.Formula "
                    + " FROM         dbo.Account AS A INNER JOIN "
                    + "              dbo.StoreOwner AS S ON A.AccountID = S.AccountID "
                    + " WHERE     (S.StoreOwnerID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            rs = stm.executeQuery();

            if (rs.next()) {
                AccountDTO store = new AccountDTO();
                store.setRoleID(rs.getInt("StoreOwnerID"));
                store.setFullName(rs.getString("FullName"));
                store.setAddress(rs.getString("Address"));
                store.setPhone(rs.getString("Phone"));
                store.setEmail(rs.getString("Email"));
                store.setFormula(rs.getFloat("Formula"));
                return store;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return null;
    }

    //get basic price from amazon service by calculate every amazon product we get
    public float getBasicPrice(String productName, String brand, int categoryID) {
        System.out.println("dang vao");
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        float basicPrice = -1;
        try {
            String englishName = "";
            con = DBUltilities.makeConnection();
            String query = "SELECT EnglishName FROM Category WHERE (CategoryID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();

            if (rs.next()) {
                englishName = rs.getString("EnglishName");
            }
            AmazonService amazon = new AmazonService();
            //basicPrice = amazon.getPrice(productName, brand, englishName);

            List<AmazonProduct> list = amazon.getProduct(productName, brand, englishName);
            if (list != null) {
                for (AmazonProduct product : list) {
                    basicPrice += product.getPrice();
                }
                if (list.size() > 1) {
                    basicPrice = (basicPrice / list.size());
                }

            } else {
                System.out.println("amazon list is null");
            }

            return basicPrice;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return -1;
    }
    
    public List<AmazonProduct> getListAmazonProduct(String productName, String brand, int categoryID) {
        System.out.println("dang vao");
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        float basicPrice = -1;
        try {
            String englishName = "";
            con = DBUltilities.makeConnection();
            String query = "SELECT EnglishName FROM Category WHERE (CategoryID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();

            if (rs.next()) {
                englishName = rs.getString("EnglishName");
            }
            AmazonService amazon = new AmazonService();

            List<AmazonProduct> list = amazon.getProduct(productName, brand, englishName);
            

            return list;
        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    //
    public void updateProductImage(int productID, String imageLink) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String englishName = "";
            con = DBUltilities.makeConnection();
            String query = "UPDATE Product SET Image = ? WHERE (ProductID = ?)";
            stm = con.prepareStatement(query);
            stm.setString(1, imageLink);
            stm.setInt(2, productID);
            int result = stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(DuchcDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    //autocompleteBrandName
    public static List<String> autoCompleteBrandName(String brandName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT BrandName "
                    + " FROM Brand "
                    + " WHERE BrandName LIKE ? "
                    + " ORDER BY BrandName ASC";
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + brandName + "%");

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                result.add(rs.getString("BrandName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }

    /**
     *
     * @DucHC getProduct FullInfo, copy from productDAO
     */
    public ProductDTO getProductByID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        try {
            con = DBUltilities.makeConnection();
            String query = "select * from Product, ProductStatus "
                    + "Where Product.ProductStatusID = ProductStatus.ProductStatusID "
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
                String orderID = rs.getString("OrderID");
                product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, 0, orderID);
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

}
