/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import java.util.List;
import hps.dto.ProductDTO;
import hps.dto.SeasonDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.OrderStatus;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tien Dan
 */
public class DanqtDAO {

    static DanqtDAO dao;

    public static DanqtDAO getInstance() {
        if (dao == null) {
            dao = new DanqtDAO();
        }
        return dao;
    }

    // used

    public List<ConsignmentDTO> getProductStatus(int storeOwnerID, int productStatus) {
        Connection conn = null;
        ResultSet rsC = null, rsP = null;
        PreparedStatement stmC = null, stmP = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        ProductDTO product = null;
        ConsignmentDTO item = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) ORDER BY ReceivedDate";
            stmC = conn.prepareStatement(query);
            stmC.setInt(1, storeOwnerID);
            stmC.setInt(2, productStatus);
            rsC = stmC.executeQuery();
            while (rsC.next()) {

                String consignmentID = rsC.getString(1);
                int productID = rsC.getInt(2);
                int memberID = rsC.getInt(3);
                String fullName = rsC.getString(5);
                String address = rsC.getString(6);
                String phone = convertPhone(rsC.getString(7));
                String email = rsC.getString(8);
                String paypalAccount = rsC.getString(9);
                String fromDate = convertDate(rsC.getString(10));
                String toDate = convertDate(rsC.getString(11));
                String raiseWebDate = convertDate(rsC.getString(12));
                int period = rsC.getInt(13);
                float maxPrice = rsC.getFloat(14);
                float minPrice = rsC.getFloat(15);
                float returnPrice = rsC.getFloat(16);
                String receivedDate = convertDate(rsC.getString(17));
                String createdDate = convertDate(rsC.getString(18));
                int consignmentStatusID = rsC.getInt(19);

                //...............
                if (productStatus == ProductStatus.ORDERED) {
                    query = "SELECT p.ProductID, p.ProductName, p.SerialNumber, p.PurchasedDate, p.CategoryID, p.Brand, "
                            + "p.Description, p.Image, p.ProductStatusID, p.SellingPrice, o.OrderID, o.Date, o.Phone FROM Product p, [Order] o "
                            + "WHERE p.ProductID = ? AND p.ProductID = o.ProductID AND o.OrderStatusID = 1";
                } else {
                    query = "SELECT p.ProductID, p.ProductName, p.SerialNumber, p.PurchasedDate, p.CategoryID, p.Brand, "
                            + "p.Description, p.Image, p.ProductStatusID, p.SellingPrice FROM Product p "
                            + "WHERE p.ProductID = ?";
                }

                stmP = conn.prepareStatement(query);
                stmP.setInt(1, productID);
                rsP = stmP.executeQuery();
                while (rsP.next()) {
                    product = null;
                    String productName = rsP.getString(2);
                    String serialNumber = rsP.getString(3);
                    String purchasedDate = convertDate(rsP.getString(4));
                    int categoryID = rsP.getInt(5);
                    String brand = rsP.getString(6);
                    String description = rsP.getString(7);
                    String image = rsP.getString(8);
                    int productStatusID = rsP.getInt(9);
                    float sellingPrice = rsP.getFloat(10);
                    String orderDate = null;
                    String customerPhone = null;
                    String orderID = null;
                    if (productStatus == ProductStatus.ORDERED) {
                        orderID = rsP.getString(11);
                        orderDate = convertDate(rsP.getString(12));
                        customerPhone = convertPhone(rsP.getString(13));
                    }
                    //..........
                    product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, orderDate, customerPhone);
                    product.setOrderID(orderID);
                }
                //...............
                if (product != null) {
                    item = new ConsignmentDTO(consignmentID, productID, memberID, storeOwnerID, fullName, address, phone, email, paypalAccount, fromDate, toDate, raiseWebDate, period, maxPrice, minPrice, returnPrice, receivedDate, createdDate, consignmentStatusID, product);
                    result.add(item);
                }
            }
            if (result.isEmpty()) {
                return null;
            }
            return result;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
        } finally {
            try {
                if (rsC != null) {
                    rsC.close();
                }
                if (rsP != null) {
                    rsP.close();
                }
                if (stmC != null) {
                    stmC.close();
                }
                if (stmP != null) {
                    stmP.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    //used
    public boolean cancelProduct(String consignmentID, int status) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        PreparedStatement stmUpdateConsignment = null;
        int resultUpdateProduct, resultUpdateConsignment;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            if (status == ProductStatus.COMPLETED) {
                conn.setAutoCommit(false);

                query = "UPDATE Product SET ProductStatusID = ? WHERE "
                        + "ProductID = (SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.COMPLETED);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();

                query = "UPDATE Consignment SET ConsignmentStatusID = ? WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setInt(1, ConsignmentStatus.CANCEL);
                stmUpdateConsignment.setString(2, consignmentID);
                resultUpdateConsignment = stmUpdateConsignment.executeUpdate();

                if (resultUpdateProduct > 0 && resultUpdateConsignment > 0) {
                    conn.commit();
                    return true;
                } else {
                    return false;
                }
            } else {
                query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = "
                        + "(SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.ON_WEB);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();
                if (resultUpdateProduct > 0) {
                    return true;
                } else {
                    return false;
                }
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

    public AccountDTO getConsignorInforByConsignmentID(String consignmentID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String fullName = "", address = "", phone = "", email = "", paypalAccount = "";
        float consignedPrice = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT * FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = convertPhone(rs.getString("Phone"));
                email = rs.getString("Email");
                consignedPrice = rs.getFloat("ReturnedPrice");
                paypalAccount = rs.getString("PaypalAccount");
                AccountDTO result = new AccountDTO(fullName, address, phone, email, consignedPrice);
                result.setPaypalAccount(paypalAccount);
                return result;
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

    public AccountDTO getCustomerInforByProductID(int id) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String fullName = "", Address = "", Phone = "", Email = "", Date = "";
        float returnPrice = 0, sellingPrice = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT o.*, p.SellingPrice, c.ReturnedPrice FROM [Order] o, Product p, Consignment c "
                    + "WHERE o.ProductID = p.ProductID AND p.ProductID = c.ProductID AND p.ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                fullName = rs.getString("FullName");
                Address = rs.getString("Address");
                Phone = convertPhone(rs.getString("Phone"));
                Email = rs.getString("Email");
                returnPrice = rs.getFloat("ReturnedPrice");
                sellingPrice = rs.getFloat("SellingPrice");
                Date = rs.getString("Date");
                return new AccountDTO(fullName, Address, Phone, Email, returnPrice, sellingPrice, Date);
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

    public boolean publishOnWeb(ProductDTO product, List<String> season) {
        Connection conn = null;
        PreparedStatement stmProduct = null;
        PreparedStatement stmConsignment = null;
        int resultProduct = 0;
        int resultConsignment = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);

            if (product.getImage() == null) {
                query = "UPDATE Product SET "
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, "
                        + "Description = ?, ProductStatusID = 3 "
                        + "WHERE ProductID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setInt(6, product.getProductID());
            } else {
                query = "UPDATE Product SET "
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, "
                        + "Description = ?, Image = ?, ProductStatusID = 3 "
                        + "WHERE ProductID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setString(6, product.getImage());
                stmProduct.setInt(7, product.getProductID());
            }
            resultProduct = stmProduct.executeUpdate();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String raiseWebDate = sdf.format(tempDate);

            query = "UPDATE Consignment SET RaiseWebDate = ? WHERE ProductID = ?";
            stmConsignment = conn.prepareStatement(query);
            stmConsignment.setString(1, raiseWebDate);
            stmConsignment.setInt(2, product.getProductID());
            resultConsignment = stmConsignment.executeUpdate();
            for (String item : season) {
                query = "INSERT INTO Product_Season VALUES (?,?)";
                stmProduct = conn.prepareCall(query);
                stmProduct.setInt(1, product.getProductID());
                stmProduct.setInt(2, Integer.parseInt(item));
                stmProduct.execute();
            }
            if (resultProduct > 0 && resultConsignment > 0) {
                conn.commit();
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ProductDTO getProductByID(int productID) {
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

    public String getConsignmentIDByProductID(int productID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT ConsignmentID FROM Consignment WHERE ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getString("ConsignmentID");
            }
            return null;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
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

    //used
    private String convertDate(String source) {
        if (source == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.append(source.substring(8, 10));
        sb.append("-");
        sb.append(source.substring(5, 7));
        sb.append("-");
        sb.append(source.substring(0, 4));
        return sb.toString();
    }

    //used
    private String convertPhone(String source) {
        if (source == null) {
            return "";
        }
        return "0" + source.substring(3);
    }

    //used
    public ConsignmentDTO getInforForCancelPage(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String address = "", phone = "", email = "", ReceivedDate = "", CancelDate = "";
        ConsignmentDTO result = null;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.FullName, c.Address, c.Phone, c.Email FROM Consignment c "
                    + "WHERE c.ConsignmentID = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = convertPhone(rs.getString("Phone"));
                email = rs.getString("Email");
                result = new ConsignmentDTO(fullName, phone, address, email);
            }

            query = "SELECT p.ProductName, c.ConsignmentID, c.ReceivedDate, c.MinPrice, c.MaxPrice, "
                    + "c.CancelDate FROM Product p, Consignment c WHERE c.ConsignmentID = ? AND "
                    + "c.ProductID = p.ProductID";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                float minPrice = 0, maxPrice = 0;
                String ProductName = rs.getString("ProductName");
                String ConsignmentID = rs.getString("ConsignmentID");
                ReceivedDate = convertDate(rs.getString("ReceivedDate"));
                CancelDate = convertDate(rs.getString("CancelDate"));
                minPrice = rs.getFloat("MinPrice");
                maxPrice = rs.getFloat("MaxPrice");
                ProductDTO product = new ProductDTO(ProductName, ReceivedDate, ConsignmentID, minPrice, maxPrice, CancelDate);
                result.setProduct(product);
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

    //used
    public ProductDTO getInforForPublishPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO result = null;
        String productName = "", serialNumber = "", purchasedDate = "", brand = "", description = "", image = "";
        int categoryID = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT ProductName, SerialNumber, PurchasedDate, "
                    + "CategoryID, Brand, Description, Image "
                    + "FROM Product WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                productName = rs.getString("ProductName");
                serialNumber = rs.getString("SerialNumber");
                purchasedDate = convertDate(rs.getString("PurchasedDate"));
                brand = rs.getString("Brand");
                description = rs.getString("Description");
                image = rs.getString("Image");
                categoryID = rs.getInt("CategoryID");
                result = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image);
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

    //used
    public List<SeasonDTO> getSeason() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<SeasonDTO> result = new ArrayList();
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT * FROM Season";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("SeasonID");
                String name = rs.getString("SeasonName");
                result.add(new SeasonDTO(id, name));
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
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

    //used
    public ConsignmentDTO getInforForOrderedPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String orderID = "", date = "", email = "", fullname = "", address = "", phone = "", productName = "";
        float minPrice = 0, maxPrice = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT OrderID, Date, Email, FullName, Address, Phone "
                    + "FROM [Order] WHERE OrderID = "
                    + "(SELECT OrderID FROM Product WHERE ProductID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                orderID = rs.getString("OrderID");
                date = convertDate(rs.getString("Date"));
                email = rs.getString("Email");
                fullname = rs.getString("FullName");
                address = rs.getString("Address");
                phone = convertPhone(rs.getString("Phone"));
            }
            query = "SELECT c.MinPrice, c.MaxPrice, p.ProductName FROM Consignment c, Product p WHERE "
                    + "p.ProductID = ? AND c.ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                minPrice = rs.getFloat("MinPrice");
                maxPrice = rs.getFloat("MaxPrice");
                productName = rs.getString("ProductName");
            }
            ProductDTO product = new ProductDTO();
            product.setMinPrice(minPrice);
            product.setMaxPrice(maxPrice);
            product.setName(productName);
            result.setName(fullname);
            result.setConsigmentID(orderID);
            result.setReceivedDate(date);
            result.setEmail(email);
            result.setAddress(address);
            result.setPhone(phone);
            result.setProduct(product);
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

    //used
    public boolean orderProduct(int productID, int status, float sellingPrice) {
        Connection conn = null;
        PreparedStatement stmP = null, stmO = null;
        int resultP, resultO = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            if (sellingPrice > 0) {
                conn.setAutoCommit(false);
                query = "UPDATE Product SET SellingPrice = ?, ProductStatusID = ? WHERE ProductID = ?";
                stmP = conn.prepareStatement(query);
                stmP.setFloat(1, sellingPrice);
                stmP.setInt(2, status);
                stmP.setInt(3, productID);
                resultP = stmP.executeUpdate();

                query = "UPDATE [Order] SET OrderStatusID = ? WHERE OrderID = "
                        + "(SELECT OrderID FROM Product WHERE ProductID = ?)";
                stmO = conn.prepareStatement(query);
                stmO.setInt(1, OrderStatus.COMPLETED);
                stmO.setInt(2, productID);
                resultO = stmO.executeUpdate();
                if (resultO > 0 && resultP > 0) {
                    conn.commit();
                    return true;
                }
            } else {
                conn.setAutoCommit(false);
                query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = ?";
                stmP = conn.prepareStatement(query);
                stmP.setInt(1, status);
                stmP.setInt(2, productID);
                resultP = stmP.executeUpdate();

                query = "UPDATE [Order] SET OrderStatusID = ? WHERE OrderID = "
                        + "(SELECT OrderID FROM Product WHERE ProductID = ?)";
                stmO = conn.prepareStatement(query);
                stmO.setInt(1, OrderStatus.CANCELED);
                stmO.setInt(2, productID);
                resultO = stmO.executeUpdate();
                if (resultO > 0 && resultP > 0) {
                    conn.commit();
                    return true;
                }
            }
            return false;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
                if (stmP != null) {
                    stmP.close();
                }
                if (stmO != null) {
                    stmO.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    //used
    public ConsignmentDTO getInforForSoldPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String consignmentID = "", receivedDate = "", email = "", fullname = "", address = "", phone = "", productName = "", paypalAccount = "";
        float minPrice = 0, maxPrice = 0, sellingPrice = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.MinPrice, c.MaxPrice, c.FullName, c.Address, c.Phone, c.Email, "
                    + "c.PaypalAccount, c.ReceivedDate, c.ConsignmentID, p.ProductName, p.SellingPrice "
                    + "FROM Consignment c, Product p WHERE c.ProductID = ? AND p.ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                consignmentID = rs.getString("ConsignmentID");
                receivedDate = convertDate(rs.getString("ReceivedDate"));
                fullname = rs.getString("FullName");
                email = rs.getString("Email");
                phone = convertPhone(rs.getString("Phone"));
                address = rs.getString("Address");
                productName = rs.getString("ProductName");
                minPrice = rs.getFloat("MinPrice");
                maxPrice = rs.getFloat("MaxPrice");
                paypalAccount = rs.getString("PaypalAccount");
                sellingPrice = rs.getFloat("SellingPrice");
            }
            result.setConsigmentID(consignmentID);
            result.setName(fullname);
            result.setPaypalAccount(paypalAccount);
            result.setMinPrice(minPrice);
            result.setMaxPrice(maxPrice);
            result.setReturnPrice(sellingPrice);
            result.setAddress(address);
            result.setPhone(phone);
            result.setEmail(email);
            result.setReceivedDate(receivedDate);
            ProductDTO product = new ProductDTO();
            product.setName(productName);
            result.setProduct(product);
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

    //used
    public boolean soldProduct(String consignmentID, float returnPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        int result1 = 0, result2 = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "UPDATE Consignment SET ReturnedPrice = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setFloat(1, returnPrice);
            stm.setString(2, consignmentID);
            result1 = stm.executeUpdate();
            query = "UPDATE Product set ProductStatusID = ? WHERE ProductID = "
                    + "(SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.COMPLETED);
            stm.setString(2, consignmentID);
            result2 = stm.executeUpdate();
            return result1 > 0 && result2 > 0;
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

    //remind consignor their consignment is out of date
    public List<ConsignmentDTO> remindConsignor() {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = null;
        List<String> consignmentList = new ArrayList<>();
        List<ConsignmentDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String today = sdf.format(tempDate);
            query = "SELECT c.ConsignmentID, c.FullName, c.Phone, c.Email FROM Consignment c, Product p WHERE "
                    + "DATEDIFF(day,[ReceivedDate],?) > Period AND p.ProductID = c.ProductID AND "
                    + "p.ProductStatusID > 1 AND p.ProductStatusID < 4 AND c.isExpiredMessaage = NULL";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            rs = stm.executeQuery();
            while (rs.next()) {
                consignmentList.add(rs.getString("ConsignmentID"));
                String consignmentID = rs.getString("ConsignmentID");
                String fullName = rs.getString("FullName");
                String phone = convertPhone(rs.getString("Phone"));
                String email = rs.getString("Email");
                ConsignmentDTO item = new ConsignmentDTO();
                item.setConsigmentID(consignmentID);
                item.setName(fullName);
                item.setPhone(phone);
                item.setEmail(email);
                result.add(item);
            }
            if (!consignmentList.isEmpty()) {
                for (String consignmentID : consignmentList) {
                    query = "UPDATE Consignment SET ConsignmentStatusID = ?, isExpiredMessaage = 1 WHERE ConsignmentID = ?";
                    stm = conn.prepareStatement(query);
                    stm.setInt(1, ConsignmentStatus.EXPIRED);
                    stm.setString(2, consignmentID);
                    stm.executeUpdate();
                    query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = "
                            + "(SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                    stm = conn.prepareStatement(query);
                    stm.setInt(1, ProductStatus.NOT_AVAILABLE);
                    stm.setString(2, consignmentID);
                    stm.executeUpdate();
                }
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

    public List<ConsignmentDTO> getProductStatus(int storeOwnerID, int productStatus, String keywork) {
        keywork = keywork.toLowerCase();
        Connection conn = null;
        ResultSet rsC = null, rsP = null;
        PreparedStatement stmC = null, stmP = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        ProductDTO product = null;
        String consignmentID = null, fullName = null;
        String address = null, phone = null;
        String email = null, paypalAccount = null;
        String fromDate = null, toDate = null;
        String raiseWebDate = null, receivedDate = null;
        String createdDate = null;
        int productID = 0, memberID = 0, period = 0, consignmentStatusID = 0;
        float maxPrice = 0, minPrice = 0, returnPrice = 0;
        String productName = null, serialNumber = null, purchasedDate = null, brand = null;
        String description = null, image = null, orderID = null, orderDate = null, customerPhone = null;
        float sellingPrice = 0;
        int categoryID = 0, productStatusID = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT DISTINCT c.* FROM Consignment c, Product p, [Order] o WHERE c.StoreOwnerID = ? AND "
                    + "c.ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) AND "
                    + "(lower(c.ConsignmentID) LIKE ? OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR "
                    + "lower(c.Phone) LIKE ? OR lower(o.OrderID) = ?) AND c.ProductID = p.ProductID AND p.ProductID = o.ProductID ORDER BY c.ReceivedDate";
            stmC = conn.prepareStatement(query);
            stmC.setInt(1, storeOwnerID);
            stmC.setInt(2, productStatus);
            stmC.setString(3, "%" + keywork + "%");
            stmC.setString(4, "%" + keywork + "%");
            stmC.setString(5, "%" + keywork + "%");
            stmC.setString(6, "%" + keywork + "%");
            stmC.setString(7, "%" + keywork + "%");
            rsC = stmC.executeQuery();
            while (rsC.next()) {

                consignmentID = rsC.getString(1);
                productID = rsC.getInt(2);
                memberID = rsC.getInt(3);
                fullName = rsC.getString(5);
                address = rsC.getString(6);
                phone = convertPhone(rsC.getString(7));
                email = rsC.getString(8);
                paypalAccount = rsC.getString(9);
                fromDate = convertDate(rsC.getString(10));
                toDate = convertDate(rsC.getString(11));
                raiseWebDate = convertDate(rsC.getString(12));
                period = rsC.getInt(13);
                maxPrice = rsC.getFloat(14);
                minPrice = rsC.getFloat(15);
                returnPrice = rsC.getFloat(16);
                receivedDate = convertDate(rsC.getString(17));
                createdDate = convertDate(rsC.getString(18));
                consignmentStatusID = rsC.getInt(19);

                //...............
                if (productStatus == ProductStatus.ORDERED) {
                    query = "SELECT p.ProductID, p.ProductName, p.SerialNumber, p.PurchasedDate, "
                            + "p.CategoryID, p.Brand, p.Description, p.Image, p.ProductStatusID, "
                            + "p.SellingPrice, o.OrderID, o.Date, o.Phone FROM Product p, [Order] o "
                            + "WHERE p.ProductID = ? AND p.ProductID = o.ProductID AND o.OrderStatusID = 1";
                } else {
                    query = "SELECT p.ProductID, p.ProductName, p.SerialNumber, p.PurchasedDate, "
                            + "p.CategoryID, p.Brand, p.Description, p.Image, p.ProductStatusID, "
                            + "p.SellingPrice, o.OrderID FROM Product p, [Order] o "
                            + "WHERE p.ProductID = ? AND p.ProductID = o.ProductID";
                }

                stmP = conn.prepareStatement(query);
                stmP.setInt(1, productID);
                rsP = stmP.executeQuery();
                while (rsP.next()) {
                    productName = rsP.getString(2);
                    serialNumber = rsP.getString(3);
                    purchasedDate = convertDate(rsP.getString(4));
                    categoryID = rsP.getInt(5);
                    brand = rsP.getString(6);
                    description = rsP.getString(7);
                    image = rsP.getString(8);
                    productStatusID = rsP.getInt(9);
                    sellingPrice = rsP.getFloat(10);
                    if (productStatus == ProductStatus.ORDERED) {
                        orderDate = convertDate(rsP.getString(12));
                        customerPhone = convertPhone(rsP.getString(13));
                    }
                    //..........
                    product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, orderDate, customerPhone);
                }
                //...............
                ConsignmentDTO item = new ConsignmentDTO(consignmentID, productID, memberID, storeOwnerID, fullName, address, phone, email, paypalAccount, fromDate, toDate, raiseWebDate, period, maxPrice, minPrice, returnPrice, receivedDate, createdDate, consignmentStatusID, product);
                result.add(item);
            }
            if (result.isEmpty()) {
                return null;
            }
            return result;
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
        } finally {
            try {
                if (rsC != null) {
                    rsC.close();
                }
                if (rsP != null) {
                    rsP.close();
                }
                if (stmC != null) {
                    stmC.close();
                }
                if (stmP != null) {
                    stmP.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    //return product and receive fee
    public void ExtendProduct(String consignmentID, float expiredFee) {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();

            String query = "UPDATE Consignment SET ConsignmentStatusID = ?, ExpiredFee = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ConsignmentStatus.EXPIRED);
            stm.setFloat(2, expiredFee);
            stm.setString(3, consignmentID);
            stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.NOT_AVAILABLE);
            stm.setString(2, consignmentID);
            stm.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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

    //extend consignment period
    public void ExtendProduct(String consignmentID, int period) {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();

            String query = "UPDATE Consignment SET Period = ((SELECT Period FROM Consignment WHERE ConsignmentID = ?) + ? ) WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            stm.setInt(2, period);
            stm.setString(3, consignmentID);
            stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setString(2, consignmentID);
            stm.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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

    public ConsignmentDTO getInforForExpiredPage(String consignmentID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        ProductDTO product = new ProductDTO();
        try {
            conn = DBUltilities.makeConnection();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String today = sdf.format(tempDate);

            String query = "SELECT c.*, p.ProductName, DATEDIFF(day,c.ReceivedDate,?) AS DiffDate "
                    + "FROM Consignment c, Product p WHERE ConsignmentID = ? AND c.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            stm.setString(2, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int diffDate = rs.getInt("DiffDate");
                String fullName = rs.getString("FullName");
                String email = rs.getString("Email");
                String address = rs.getString("Address");
                String phone = convertPhone(rs.getString("Phone"));
                String receivedDate = convertDate(rs.getString("ReceivedDate"));
                float maxPrice = rs.getFloat("MaxPrice");
                float minPrice = rs.getFloat("MinPrice");
                String productName = rs.getString("ProductName");
                int period = rs.getInt("Period");
                result.setName(fullName);
                result.setEmail(email);
                result.setAddress(address);
                result.setPhone(phone);
                result.setReceivedDate(receivedDate);
                result.setMaxPrice(maxPrice);
                result.setMinPrice(minPrice);
                result.setPeriod(period);
                product.setName(productName);
                result.setProduct(product);
                result.setExpiredDays(diffDate - period);
                result.setExpiredFee((diffDate - period) / period * minPrice);
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

    public List<ConsignmentDTO> getExpiredProduct(int roleID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        ProductDTO product = null;
        ConsignmentDTO item = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT c.*, p.ProductName FROM Consignment c, Product p WHERE c.StoreOwnerID = ? AND "
                    + "c.ConsignmentStatusID = ? AND c.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ConsignmentStatus.EXPIRED);
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                String receivedDate = convertDate(rs.getString("ReceivedDate"));
                float minPrice = rs.getFloat("MinPrice");
                float maxPrice = rs.getFloat("MaxPrice");
                String fullName = rs.getString("FullName");
                item = new ConsignmentDTO();
                item.setProductID(productID);
                item.setConsigmentID(consignmentID);
                item.setReceivedDate(receivedDate);
                item.setMaxPrice(maxPrice);
                item.setMinPrice(minPrice);
                item.setName(fullName);
                product = new ProductDTO();
                product.setName(productName);
                item.setProduct(product);
                result.add(item);
            }
            if (!result.isEmpty()) {
                return result;
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

    public List<ConsignmentDTO> getExpiredProduct(int roleID, String keywork) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        ProductDTO product = null;
        ConsignmentDTO item = null;
        keywork = keywork.toLowerCase();
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT c.*, p.ProductName FROM Consignment c, Product p, [Order] o WHERE c.StoreOwnerID = ? AND "
                    + "c.ConsignmentStatusID = ? AND c.ProductID = p.ProductID AND o.ProductID = p.ProductID ( lower(c.ConsignmentID) LIKE ? "
                    + "OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR lower(c.Phone) LIKE ? OR "
                    + "lower(o.OrderID) = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ConsignmentStatus.EXPIRED);
            stm.setString(3, "%" + keywork + "%");
            stm.setString(4, "%" + keywork + "%");
            stm.setString(5, "%" + keywork + "%");
            stm.setString(6, "%" + keywork + "%");
            stm.setString(7, "%" + keywork + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                String receivedDate = convertDate(rs.getString("ReceivedDate"));
                float minPrice = rs.getFloat("MinPrice");
                float maxPrice = rs.getFloat("MaxPrice");
                String fullName = rs.getString("FullName");
                item = new ConsignmentDTO();
                item.setProductID(productID);
                item.setConsigmentID(consignmentID);
                item.setReceivedDate(receivedDate);
                item.setMaxPrice(maxPrice);
                item.setMinPrice(minPrice);
                item.setName(fullName);
                product = new ProductDTO();
                product.setName(productName);
                item.setProduct(product);
                result.add(item);
            }
            if (result.isEmpty()) {
                return null;
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
}
