/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.OrderDTO;
import java.util.List;
import hps.dto.ProductDTO;
import hps.dto.SeasonDTO;
import hps.dto.StatisticDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.JavaUltilities;
import hps.ultils.OrderStatus;
import hps.ultils.ProductStatus;
import hps.ultils.SpecialProduct;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
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
            String query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) ORDER BY ReviewProductDate";
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
                String fromDate = formatDateString(rsC.getString(10));
                String toDate = formatDateString(rsC.getString(11));
                String raiseWebDate = formatDateString(rsC.getString(12));
                int period = rsC.getInt(13);
                float negotiatedPrice = rsC.getFloat(24) / 1000;
                float returnPrice = rsC.getFloat(16) / 1000;
                String receivedDate = formatDateString(rsC.getString(17));
                String createdDate = formatDateString(rsC.getString(18));
                int consignmentStatusID = rsC.getInt(19);
                String cancelDate = formatDateString(rsC.getString("CancelDate"));

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
                    String purchasedDate = formatDateString(rsP.getString(4));
                    int categoryID = rsP.getInt(5);
                    String brand = rsP.getString(6);
                    String description = rsP.getString(7);
                    String image = rsP.getString(8);
                    int productStatusID = rsP.getInt(9);
                    float sellingPrice = rsP.getFloat(10) / 1000;
                    String orderDate = null;
                    String customerPhone = null;
                    String orderID = null;
                    if (productStatus == ProductStatus.ORDERED) {
                        orderID = rsP.getString(11);
                        orderDate = formatDateString(rsP.getString(12));
                        customerPhone = convertPhone(rsP.getString(13));
                    }
                    //..........
                    product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, orderDate, customerPhone);
                    product.setOrderID(orderID);
                }
                //...............
                if (product != null) {
                    item = new ConsignmentDTO(consignmentID, productID, memberID, storeOwnerID, fullName, address, phone, email, paypalAccount, fromDate, toDate, raiseWebDate, period, returnPrice, receivedDate, createdDate, consignmentStatusID, product, negotiatedPrice);
                    item.setCancelDate(cancelDate);
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

                Date tempDate = Calendar.getInstance().getTime();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
                String today = sdf.format(tempDate);

                query = "UPDATE Consignment SET AgreeCancelDate = ?, ConsignmentStatusID = ?, CancelFee = (SELECT NegotiatedPrice * 0.15 FROM Consignment WHERE ConsignmentID = ?) WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setString(1, today);
                stmUpdateConsignment.setInt(2, ConsignmentStatus.CANCEL);
                stmUpdateConsignment.setString(3, consignmentID);
                stmUpdateConsignment.setString(4, consignmentID);
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
                return resultUpdateProduct > 0;
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
                consignedPrice = rs.getFloat("ReturnedPrice") / 1000;
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
                returnPrice = rs.getFloat("ReturnedPrice") / 1000;
                sellingPrice = rs.getFloat("SellingPrice") / 1000;
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
        ResultSet rs = null;
        String query = "";
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
                        + "Description = ?, ProductStatusID = 3, IsSpecial = ? "
                        + "WHERE ProductID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setInt(6, product.getIsSpecial());
                stmProduct.setInt(7, product.getProductID());
            } else {
                query = "UPDATE Product SET "
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, "
                        + "Description = ?, Image = ?, ProductStatusID = 3 , IsSpecial = ? "
                        + "WHERE ProductID = ?";
                stmProduct = conn.prepareStatement(query);
                stmProduct.setString(1, product.getName());
                stmProduct.setString(2, product.getSerialNumber());
                stmProduct.setInt(3, product.getCategoryID());
                stmProduct.setString(4, product.getBrand());
                stmProduct.setString(5, product.getDescription());
                stmProduct.setString(6, product.getImage());
                stmProduct.setInt(7, product.getIsSpecial());
                stmProduct.setInt(8, product.getProductID());
            }
            resultProduct = stmProduct.executeUpdate();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
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
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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
    private String formatDateString(String source) {
        if (source == null) {
            return "";
        }
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("HH:mm dd-MM-yyyy");
            Date date = df.parse(source);
            String result = df2.format(date);
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

    //used
    public ConsignmentDTO getInforForCancelPage(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String address = "", phone = "", email = "", ReviewProductDate = "", CancelDate = "";
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
            if (result != null) {
                query = "SELECT p.ProductName, c.ConsignmentID, c.ReviewProductDate, c.NegotiatedPrice, "
                        + "c.CancelDate FROM Product p, Consignment c WHERE c.ConsignmentID = ? AND "
                        + "c.ProductID = p.ProductID";
                stm = con.prepareStatement(query);
                stm.setString(1, consignmentID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String ProductName = rs.getString("ProductName");
                    String ConsignmentID = rs.getString("ConsignmentID");
                    ReviewProductDate = formatDateString(rs.getString("ReviewProductDate"));
                    CancelDate = formatDateString(rs.getString("CancelDate"));
                    float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                    ProductDTO product = new ProductDTO(ProductName, ReviewProductDate, ConsignmentID, negotiatedPrice, CancelDate);
                    result.setProduct(product);
                }
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
        int categoryID = 0, isSpecial = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT ProductName, SerialNumber, PurchasedDate, "
                    + "CategoryID, Brand, Description, Image, IsSpecial "
                    + "FROM Product WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                productName = rs.getString("ProductName");
                serialNumber = rs.getString("SerialNumber");
                purchasedDate = formatDateString(rs.getString("PurchasedDate"));
                brand = rs.getString("Brand");
                description = rs.getString("Description");
                image = rs.getString("Image");
                categoryID = rs.getInt("CategoryID");
                isSpecial = rs.getInt("IsSpecial");
                result = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, isSpecial);
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

    //used
    public ConsignmentDTO getInforForSoldPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String consignmentID = "", receivedDate = "", email = "", fullname = "", address = "", phone = "", productName = "", paypalAccount = "";
        float negotiatedPrice = 0, sellingPrice = 0;
        int period = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.NegotiatedPrice, c.FullName, c.Address, c.Phone, c.Email, c.Period, "
                    + "c.PaypalAccount, c.ReviewProductDate, c.ConsignmentID, p.ProductName, p.SellingPrice "
                    + "FROM Consignment c, Product p WHERE c.ProductID = ? AND p.ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                consignmentID = rs.getString("ConsignmentID");
                receivedDate = formatDateString(rs.getString("ReviewProductDate"));
                fullname = rs.getString("FullName");
                email = rs.getString("Email");
                phone = convertPhone(rs.getString("Phone"));
                address = rs.getString("Address");
                productName = rs.getString("ProductName");
                paypalAccount = rs.getString("PaypalAccount");
                sellingPrice = rs.getFloat("SellingPrice") / 1000;
                negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                period = rs.getInt("Period");
            }
            result.setConsigmentID(consignmentID);
            result.setName(fullname);
            result.setPaypalAccount(paypalAccount);
            result.setNegotiatedPrice(negotiatedPrice);
            result.setReturnPrice(sellingPrice);
            result.setAddress(address);
            result.setPhone(phone);
            result.setEmail(email);
            result.setReviewProductDate(receivedDate);
            result.setPeriod(period);
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

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            String today = sdf.format(tempDate);

            query = "UPDATE Consignment SET ReturnedPrice = ?, ReturnDate = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setFloat(1, returnPrice);
            stm.setString(2, today);
            stm.setString(3, consignmentID);
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
            System.out.println("Today : " + today);
            query = "SELECT c.ConsignmentID, c.FullName, c.Phone, c.Email FROM Consignment c, Product p WHERE "
                    + "DATEDIFF(day,[ReviewProductDate],?) > Period AND p.ProductID = c.ProductID AND "
                    + "p.ProductStatusID > 1 AND p.ProductStatusID < 4 AND c.isExpiredMessage is NULL";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            rs = stm.executeQuery();
            while (rs.next()) {
                System.out.println("ConsignmentID");
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
                    System.out.println("ConsignmentID : " + consignmentID);
                    query = "UPDATE Consignment SET ConsignmentStatusID = ?, isExpiredMessage = 1 WHERE ConsignmentID = ?";
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
                    query = "UPDATE [Order] SET OrderStatusID = ? WHERE ProductID = "
                            + "(SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                    stm = conn.prepareStatement(query);
                    stm.setInt(1, OrderStatus.CANCELED);
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
        float negotiatedPrice = 0, returnPrice = 0;
        String productName = null, serialNumber = null, purchasedDate = null, brand = null;
        String description = null, image = null, orderDate = null, customerPhone = null;
        float sellingPrice = 0;
        int categoryID = 0, productStatusID = 0;
        try {
            conn = DBUltilities.makeConnection();
            String query = "";
            if (productStatus == ProductStatus.ORDERED) {
                query = "SELECT DISTINCT c.* FROM Consignment c, Product p, [Order] o WHERE c.StoreOwnerID = ? AND "
                        + "c.ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) AND "
                        + "(lower(c.ConsignmentID) LIKE ? OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR "
                        + "lower(c.Phone) LIKE ? OR lower(o.OrderID) = ?) AND c.ProductID = p.ProductID AND p.ProductID = o.ProductID ORDER BY c.ReviewProductDate";
            } else {
                query = "SELECT DISTINCT c.* FROM Consignment c, Product p WHERE c.StoreOwnerID = ? AND "
                        + "c.ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) AND "
                        + "(lower(c.ConsignmentID) LIKE ? OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR "
                        + "lower(c.Phone) LIKE ?) AND c.ProductID = p.ProductID ORDER BY c.ReviewProductDate";
            }
            stmC = conn.prepareStatement(query);
            stmC.setInt(1, storeOwnerID);
            stmC.setInt(2, productStatus);
            stmC.setString(3, "%" + keywork + "%");
            stmC.setString(4, "%" + keywork + "%");
            stmC.setString(5, "%" + keywork + "%");
            stmC.setString(6, "%" + keywork + "%");
            if (productStatus == ProductStatus.ORDERED) {
                stmC.setString(7, "%" + keywork + "%");
            }
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
                fromDate = formatDateString(rsC.getString(10));
                toDate = formatDateString(rsC.getString(11));
                raiseWebDate = formatDateString(rsC.getString(12));
                period = rsC.getInt(13);
                negotiatedPrice = rsC.getFloat(24) / 1000;
                returnPrice = rsC.getFloat(16) / 1000;
                receivedDate = formatDateString(rsC.getString(17));
                createdDate = formatDateString(rsC.getString(18));
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
                            + "p.SellingPrice FROM Product p "
                            + "WHERE p.ProductID = ?";
                }

                stmP = conn.prepareStatement(query);
                stmP.setInt(1, productID);
                rsP = stmP.executeQuery();
                while (rsP.next()) {
                    productName = rsP.getString(2);
                    serialNumber = rsP.getString(3);
                    purchasedDate = formatDateString(rsP.getString(4));
                    categoryID = rsP.getInt(5);
                    brand = rsP.getString(6);
                    description = rsP.getString(7);
                    image = rsP.getString(8);
                    productStatusID = rsP.getInt(9);
                    sellingPrice = rsP.getFloat(10) / 1000;
                    if (productStatus == ProductStatus.ORDERED) {
                        orderDate = formatDateString(rsP.getString(12));
                        customerPhone = convertPhone(rsP.getString(13));
                    }
                    //..........
                    product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, orderDate, customerPhone);
                }
                //...............
                ConsignmentDTO item = new ConsignmentDTO(consignmentID, productID, memberID, storeOwnerID, fullName, address, phone, email, paypalAccount, fromDate, toDate, raiseWebDate, period, returnPrice, receivedDate, createdDate, consignmentStatusID, product, negotiatedPrice);
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

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            String today = sdf.format(tempDate);

            String query = "UPDATE Consignment SET ReceivedDate = ?, ConsignmentStatusID = ?, ExpiredFee = ? WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            stm.setInt(2, ConsignmentStatus.EXPIRED);
            stm.setFloat(3, expiredFee);
            stm.setString(4, consignmentID);
            int i = stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.COMPLETED);
            stm.setString(2, consignmentID);
            i = stm.executeUpdate();

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

            String query = "UPDATE Consignment SET isExpiredMessage = null, ConsignmentStatusID = ?, Period = ((SELECT Period FROM Consignment WHERE ConsignmentID = ?) + ? ) WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ConsignmentStatus.RECEIVED);
            stm.setString(2, consignmentID);
            stm.setInt(3, period);
            stm.setString(4, consignmentID);
            int i = stm.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.ON_WEB);
            stm.setString(2, consignmentID);
            i = stm.executeUpdate();

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

            String query = "SELECT c.*, p.ProductName, DATEDIFF(day,c.ReviewProductDate,?) AS DiffDate "
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
                String receivedDate = formatDateString(rs.getString("ReviewProductDate"));
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                String productName = rs.getString("ProductName");
                int period = rs.getInt("Period");
                result.setName(fullName);
                result.setEmail(email);
                result.setAddress(address);
                result.setPhone(phone);
                result.setReviewProductDate(receivedDate);
                result.setNegotiatedPrice(negotiatedPrice);
                result.setPeriod(period);
                product.setName(productName);
                result.setProduct(product);
                result.setExpiredDays(diffDate - period);
                if (negotiatedPrice > 1000) {
                    result.setExpiredFee((diffDate - period) * 10);
                } else {
                    result.setExpiredFee((diffDate - period) * 5);
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
                    + "c.ConsignmentStatusID = ? AND c.ProductID = p.ProductID AND p.ProductStatusID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ConsignmentStatus.EXPIRED);
            stm.setInt(3, ProductStatus.NOT_AVAILABLE);
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                String receivedDate = formatDateString(rs.getString("ReviewProductDate"));
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                String fullName = rs.getString("FullName");
                item = new ConsignmentDTO();
                item.setProductID(productID);
                item.setConsigmentID(consignmentID);
                item.setReviewProductDate(receivedDate);
                item.setNegotiatedPrice(negotiatedPrice);
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
            String query = "SELECT c.*, p.ProductName FROM Consignment c, Product p, [Order] o WHERE c.StoreOwnerID = ? AND p.ProductStatusID = ? AND "
                    + "c.ConsignmentStatusID = ? AND c.ProductID = p.ProductID AND o.ProductID = p.ProductID ( lower(c.ConsignmentID) LIKE ? "
                    + "OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR lower(c.Phone) LIKE ? OR "
                    + "lower(o.OrderID) = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ProductStatus.NOT_AVAILABLE);
            stm.setInt(3, ConsignmentStatus.EXPIRED);
            stm.setString(4, "%" + keywork + "%");
            stm.setString(5, "%" + keywork + "%");
            stm.setString(6, "%" + keywork + "%");
            stm.setString(7, "%" + keywork + "%");
            stm.setString(8, "%" + keywork + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                String receivedDate = formatDateString(rs.getString("ReviewProductDate"));
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                String fullName = rs.getString("FullName");
                item = new ConsignmentDTO();
                item.setProductID(productID);
                item.setConsigmentID(consignmentID);
                item.setReviewProductDate(receivedDate);
                item.setNegotiatedPrice(negotiatedPrice);
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

    public List<ConsignmentDTO> getOrderedProduct(int roleID, int ORDERED, String keywork) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        List<ProductDTO> productList = new ArrayList<>();
        keywork = keywork.toLowerCase();
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT DISTINCT p.ProductName, p.ProductID, c.NegotiatedPrice, c.ConsignmentID FROM Product p, Consignment c, [Order] o "
                    + "WHERE p.ProductID in (SELECT ProductID FROM Consignment WHERE StoreOwnerID = ?) "
                    + "AND p.ProductStatusID = ? AND p.ProductID = c.ProductID AND o.ProductID = p.ProductID AND "
                    + "(lower(c.ConsignmentID) LIKE ? OR lower(p.ProductName) LIKE ? OR lower(c.FullName) LIKE ? OR "
                    + "lower(c.Phone) LIKE ? OR lower(o.OrderID) = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ORDERED);
            stm.setString(3, "%" + keywork + "%");
            stm.setString(4, "%" + keywork + "%");
            stm.setString(5, "%" + keywork + "%");
            stm.setString(6, "%" + keywork + "%");
            stm.setString(7, "%" + keywork + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                int productID = rs.getInt("ProductID");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                ProductDTO item = new ProductDTO();
                item.setName(productName);
                item.setProductID(productID);
                item.setConsignmentID(consignmentID);
                item.setNegotiatedPrice(negotiatedPrice);
                productList.add(item);
            }
            for (ProductDTO productList1 : productList) {
                query = "SELECT COUNT(*) as NumberOfOrders FROM [Order] WHERE ProductID = ? AND OrderStatusID = ?";
                stm = conn.prepareStatement(query);
                stm.setInt(1, productList1.getProductID());
                stm.setInt(2, OrderStatus.WAITING);
                rs = stm.executeQuery();
                while (rs.next()) {
                    ConsignmentDTO cons = new ConsignmentDTO();
                    cons.setProduct(productList1);
                    cons.setQuantity(rs.getInt("NumberOfOrders"));
                    result.add(cons);
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

    public List<ConsignmentDTO> getOrderedProduct(int roleID, int ORDERED) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        List<ProductDTO> productList = new ArrayList<>();
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT DISTINCT p.ProductName, p.ProductID, c.NegotiatedPrice, c.ConsignmentID FROM Product p, Consignment c, [Order] o "
                    + "WHERE p.ProductID in (SELECT ProductID FROM Consignment WHERE StoreOwnerID = ?) "
                    + "AND p.ProductStatusID = ? AND p.ProductID = c.ProductID AND o.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            stm.setInt(2, ORDERED);
//            stm.setInt(3, SpecialProduct.NOT_SPECIAL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                String consignmentID = rs.getString("ConsignmentID");
                int productID = rs.getInt("ProductID");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                ProductDTO item = new ProductDTO();
                item.setName(productName);
                item.setConsignmentID(consignmentID);
                item.setProductID(productID);
                item.setNegotiatedPrice(negotiatedPrice);
                productList.add(item);
            }
            for (ProductDTO productList1 : productList) {
                query = "SELECT COUNT(*) as NumberOfOrders FROM [Order] WHERE ProductID = ? AND OrderStatusID = ?";
                stm = conn.prepareStatement(query);
                stm.setInt(1, productList1.getProductID());
                stm.setInt(2, OrderStatus.WAITING);
                rs = stm.executeQuery();
                while (rs.next()) {
                    ConsignmentDTO cons = new ConsignmentDTO();
                    cons.setProduct(productList1);
                    cons.setQuantity(rs.getInt("NumberOfOrders"));
                    result.add(cons);
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

    public void changeProductStatus(String orderID, float sellingPrice) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            String sellingDate = sdf.format(tempDate);

            query = "UPDATE Product SET SellDate = ?, SellingPrice = ?, ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, sellingDate);
            stm.setFloat(2, sellingPrice);
            stm.setInt(3, ProductStatus.SOLD);
            stm.setString(4, orderID);
            stm.executeUpdate();
            query = "UPDATE [Order] SET OrderStatusID = ? WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, OrderStatus.COMPLETED);
            stm.setString(2, orderID);
            stm.executeUpdate();
            query = "UPDATE [Order] SET OrderStatusID = ? WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND OrderID != ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, OrderStatus.CANCELED);
            stm.setString(2, orderID);
            stm.setString(3, orderID);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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

    public AccountDTO getConsignorInforByOrderID(String orderID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        AccountDTO result = new AccountDTO();
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT DISTINCT c.* FROM [Order] o, Consignment c WHERE c.ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND o.ProductID = c.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, orderID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("FullName");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                result.setFullName(fullName);
                result.setEmail(email);
                result.setPhone(phone);
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

    public List<OrderDTO> getListOrderedCustomer(String orderID, boolean flag) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<OrderDTO> result = new ArrayList<>();
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            if (flag) {// sell to 1 customer
                query = "SELECT * FROM [Order] WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND OrderID != ?";
            } else {// cancel all orders
                query = "SELECT * FROM [Order] WHERE ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?)";
            }
            stm = conn.prepareStatement(query);
            stm.setString(1, orderID);
            if (flag) {
                stm.setString(2, orderID);
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("FullName");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                String item_orderID = rs.getString("OrderID");
                OrderDTO item = new OrderDTO();
                item.setEmail(email);
                item.setPhone(phone);
                item.setFullName(fullName);
                item.setOrderID(item_orderID);
                result.add(item);
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

    public String getConsignmentIDByOrderID(String orderID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT DISTINCT c.ConsignmentID FROM [Order] o, Consignment c WHERE c.ProductID = (SELECT ProductID FROM [Order] WHERE OrderID = ?) AND o.ProductID = c.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, orderID);
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

    public ConsignmentDTO getInforForOnWebPage(String consignmentID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        ProductDTO product = new ProductDTO();
        List<Integer> season = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();

            String query = "SELECT c.*, p.ProductName FROM Consignment c, Product p "
                    + "WHERE ConsignmentID = ? AND c.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("ProductName");
                String receivedDate = formatDateString(rs.getString("ReviewProductDate"));
                float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                product.setName(productName);
                result.setReviewProductDate(receivedDate);
                result.setNegotiatedPrice(negotiatedPrice);
            }
            query = "SELECT SeasonID FROM Product_Season WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                season.add(rs.getInt("SeasonID"));
            }
            product.setSeasonList(season);
            result.setProduct(product);
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

    public void cancelAllOrders(String orderID) {
        Connection conn = null;
        PreparedStatement stmO = null, stmP = null;
        String query = "";
        try {

            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);
            query = "UPDATE [Order] SET OrderStatusID = ? WHERE ProductID = "
                    + "(SELECT ProductID FROM [Order] WHERE OrderID = ?)";
            stmO = conn.prepareStatement(query);
            stmO.setInt(1, OrderStatus.EXPIRED);
            stmO.setString(2, orderID);
            stmO.executeUpdate();

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = "
                    + "(SELECT ProductID FROM [Order] WHERE OrderID = ?)";
            stmP = conn.prepareStatement(query);
            stmP.setInt(1, ProductStatus.ON_WEB);
            stmP.setString(2, orderID);
            stmP.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (stmO != null) {
                    stmO.close();
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

    public String getCustomerInforByOrderID(String _orderID, float sendPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        try {

            conn = DBUltilities.makeConnection();
            query = "UPDATE [Order] SET SendPrice = ? WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setFloat(1, sendPrice);
            stm.setString(2, _orderID);
            stm.executeUpdate();

            query = "SELECT * FROM [Order] WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, _orderID);
            rs = stm.executeQuery();
            if (rs.next()) {
                return convertPhone(rs.getString("Phone"));
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

    public List<StatisticDTO> getProductInforForStatisticPage(int roleID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        List<StatisticDTO> result = new ArrayList<>();
        try {

            conn = DBUltilities.makeConnection();
            query = "SELECT c.ExpiredFee, p.ProductName, c.FullName, c.NegotiatedPrice, c.ReturnedPrice, "
                    + "p.SellingPrice, c.CancelFee, c.AgreeCancelDate, c.ReturnDate, c.ReceivedDate, "
                    + "CASE WHEN c.AgreeCancelDate IS NOT NULL THEN c.AgreeCancelDate "
                    + "WHEN c.ReturnDate IS NOT NULL THEN c.ReturnDate "
                    + "WHEN c.ReceivedDate IS NOT NULL THEN c.ReceivedDate "
                    + "END AS ActionDate "
                    + "FROM Product p, Consignment c WHERE "
                    + "p.ProductID = c.ProductID AND c.StoreOWnerID = ? AND "
                    + "((c.ConsignmentStatusID = 6 AND p.ProductStatusID = 7) OR "
                    + "(c.ConsignmentStatusID = 5 AND p.ProductStatusID = 7) OR "
                    + "(c.ConsignmentStatusID = 7 AND p.ProductStatusID = 7)) "
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
                float fee = 0;
                float revenue = 0;
                if (cancelFee > expiredFee) {
                    fee = cancelFee;
                } else {
                    fee = expiredFee;
                }
                String actionDate = formatDateString(rs.getString("ActionDate"));
                if (fee != 0) {
                    revenue = fee;
                } else {
                    revenue = sellingPrice - returnPrice;
                }
                StatisticDTO item = new StatisticDTO(productName, consignorName, negotiatedPrice, returnPrice, fee, revenue, sellingPrice, actionDate);
                result.add(item);
            }
            if (result.isEmpty()) {
                return null;
            } else {
                return result;
            }
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

    public List<ConsignmentDTO> getConsignmentInforForStatisticPage(int roleID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        List<ConsignmentDTO> result = new ArrayList<>();
        ConsignmentDTO item = null;
        try {
            conn = DBUltilities.makeConnection();

            query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ReviewRequestDate IS NOT NULL ORDER BY ReviewRequestDate";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                item = new ConsignmentDTO();
                item.setName(rs.getString("FullName"));
                item.setConsigmentID(rs.getString("ConsignmentID"));
                item.setReviewRequestDate(formatDateString(rs.getString("ReviewRequestDate")));
                item.setPhone(convertPhone(rs.getString("Phone")));
                item.setConsignmentStatusID(rs.getInt("ConsignmentStatusID"));
                result.add(item);
            }

            query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ReviewProductDate IS NOT NULL ORDER BY ReviewProductDate";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                item = new ConsignmentDTO();
                item.setName(rs.getString("FullName"));
                item.setConsigmentID(rs.getString("ConsignmentID"));
                item.setReviewProductDate(formatDateString(rs.getString("ReviewProductDate")));
                item.setPhone(convertPhone(rs.getString("Phone")));
                item.setConsignmentStatusID(rs.getInt("ConsignmentStatusID"));
                result.add(item);
            }

            if (result.isEmpty()) {
                return null;
            } else {
                return result;
            }
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
            Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
