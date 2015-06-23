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
import hps.ultils.DBUltilities;
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

    public List<ProductDTO> getProductStatus(int storeOwnerID, int productStatus) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ProductDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT p.ProductID, p.ProductName, c.ReceivedDate, c.ConsignmentID, c.ReturnedPrice, p.ProductStatusID"
                    + " FROM Product p ,Consignment c"
                    + " WHERE c.StoreOwnerID = ? AND p.ProductStatusID = ? AND p.ProductID = c.ProductID"
                    + " ORDER BY p.ProductStatusID";
            stm = conn.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            stm.setInt(2, productStatus);
            rs = stm.executeQuery();
            String productName, receivedDate, consignmentID;
            float price;
            boolean flag = true;
            int status, productID;
            ProductDTO product;
            while (rs.next()) {
                flag = false;
                productID = rs.getInt("ProductID");
                productName = rs.getString("ProductName");
                receivedDate = convertDate(rs.getString("ReceivedDate"));
                consignmentID = rs.getString("ConsignmentID");
                price = rs.getFloat("ReturnedPrice");
                status = rs.getInt("ProductStatusID");
                product = new ProductDTO(productID, productName, receivedDate, consignmentID, price, status);
                result.add(product);
            }
            if (flag) {
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

    public boolean payConsignor(int productID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm1 = null, stm = null;
        int result1 = 0, result2 = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);

            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = ? AND ProductStatusID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, 7);
            stm.setInt(2, productID);
            stm.setInt(3, 5);
            result1 = stm.executeUpdate();

            query = "UPDATE Consignment SET ConsignmentStatusID = ? WHERE ProductID = ?";
            stm1 = conn.prepareStatement(query);
            stm1.setInt(1, 4);
            stm1.setInt(2, productID);
            result2 = stm1.executeUpdate();

            if (result1 > 0 && result2 > 0) {
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
                if (stm1 != null) {
                    stm1.close();
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

    public boolean cancelProduct(String consignmentID, int status) // trả về true nếu thành công
    // trả về false nếu không thành công
    {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmUpdateProduct = null;
        PreparedStatement stmUpdateConsignment = null;
        int resultUpdateProduct, resultUpdateConsignment;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            if (status == 7) {
                conn.setAutoCommit(false);

                query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
                stmUpdateProduct = conn.prepareStatement(query);
                stmUpdateProduct.setInt(1, ProductStatus.COMPLETED);
                stmUpdateProduct.setString(2, consignmentID);
                resultUpdateProduct = stmUpdateProduct.executeUpdate();

                query = "UPDATE Consignment SET ConsignmentStatusID = 4 WHERE ConsignmentID = ?";
                stmUpdateConsignment = conn.prepareStatement(query);
                stmUpdateConsignment.setString(1, consignmentID);
                resultUpdateConsignment = stmUpdateConsignment.executeUpdate();

                if (resultUpdateProduct > 0 && resultUpdateConsignment > 0) {
                    conn.commit();
                    return true;
                } else {
                    return false;
                }
            } else {
                query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = (SELECT c.ProductID FROM Consignment c WHERE c.ConsignmentID = ?)";
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

    public List<ProductDTO> searchProduct(String keywords, String type, int storeOwnerID) {
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
                        + "WHERE ? LIKE ? AND c.StoreOwnerID = ? AND p.ProductID = c.ProductID ORDER BY p.ProductStatusID";
                stm = conn.prepareStatement(query);
                stm.setString(1, searchType);
                stm.setString(2, "%" + keywords + "%");
                stm.setInt(3, storeOwnerID);
                rs = stm.executeQuery();
            } else {
                query = "SELECT p.ProductID,p.ProductName,c.ReceivedDate,c.ConsignmentID,c.ReturnedPrice,p.ProductStatusID "
                        + "FROM Product p ,Consignment c "
                        + "WHERE p.ProductID = c.ProductID AND (p.ProductName LIKE ? OR c.ReceivedDate LIKE ? "
                        + "OR c.ConsignmentID LIKE ? OR p.ProductStatusID LIKE ? ) AND c.StoreOwnerID = ? ORDER BY p.ProductStatusID";
                stm = conn.prepareStatement(query);
                stm.setString(1, "%" + keywords + "%");
                stm.setString(2, "%" + keywords + "%");
                stm.setString(3, "%" + keywords + "%");
                stm.setString(4, "%" + keywords + "%");
                stm.setInt(5, storeOwnerID);
                rs = stm.executeQuery();
            }
            while (rs.next()) {
                productID = Integer.parseInt(rs.getString("ProductID"));
                productName = rs.getString("ProductName");
                receivedDate = rs.getString("ReceivedDate");
                consignmentID = rs.getString("ConsignmentID");
                price = rs.getFloat("ReturnedPrice");
                status = rs.getInt("ProductStatusID");
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
                phone = rs.getString("Phone");
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
            String query = "SELECT c.Date, c.FullName, c.Address, c.Phone, c.Email, p.SellingPrice, co.ReturnedPrice from [Order] c, Product p, Consignment co WHERE c.OrderID = (SELECT p.OrderID FROM Product p WHERE ProductID = ?) AND c.OrderID = p.OrderID AND co.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                fullName = rs.getString("FullName");
                Address = rs.getString("Address");
                Phone = rs.getString("Phone");
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
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, Description = ?, ProductStatusID = 3 "
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
                        + "ProductName = ?, SerialNumber = ?, CategoryID = ?, Brand = ?, Description = ?, Image = ?, ProductStatusID = 3 "
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
                String orderID = rs.getString("OrderID");
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

    public ProductDTO getProductByConsignmentID(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT p.ProductID, p.ProductName, c.ReturnedPrice, c.ReceivedDate FROM Product p, Consignment c WHERE p.ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?) AND p.ProductID = c.ProductID";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                Float returnedPrice = rs.getFloat("ReturnedPrice");
                String receivedDate = rs.getString("ReceivedDate");
                product = new ProductDTO(productID, productName, receivedDate, consignmentID, returnedPrice, receivedDate);
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

    public ProductDTO getCancelProductInforByConsignmentID(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO product = new ProductDTO();
        int productID = -1;
        String productName, receivedDate, cancelDate;
        float returnedPrice = -1;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT p.ProductID, p.ProductName, c.ReturnedPrice, c.ReceivedDate, c.CancelDate FROM Product p, Consignment c WHERE p.ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?) AND p.ProductID = c.ProductID";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                productID = rs.getInt("ProductID");
                productName = rs.getString("ProductName");
                returnedPrice = rs.getFloat("ReturnedPrice");
                receivedDate = rs.getString("ReceivedDate");
                cancelDate = rs.getString("CancelDate");
                product = new ProductDTO(productID, productName, receivedDate, consignmentID, returnedPrice, cancelDate);
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

    public boolean completeOrderedProduct(String consignmentID, float sellingPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        int result = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "UPDATE Product SET ProductStatusID = 5, SellingPrice = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?) AND ProductStatusID = 4";
            stm = conn.prepareStatement(query);
            stm.setString(2, consignmentID);
            stm.setFloat(1, sellingPrice);
            result = stm.executeUpdate();
            return (result > 0);
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

    private String convertDate(String source) {
        StringBuilder sb = new StringBuilder();
        sb.append(source.substring(8, 10));
        sb.append("-");
        sb.append(source.substring(5, 7));
        sb.append("-");
        sb.append(source.substring(0, 4));
        return sb.toString();
    }

    public ConsignmentDTO getInforForCancelPage(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String address = "", phone = "", email = "", ReceivedDate = "", CancelDate = "";
        ConsignmentDTO result = null;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.FullName, c.Address, c.Phone, c.Email FROM Consignment c WHERE c.ConsignmentID = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("FullName");
                address = rs.getString("Address");
                phone = rs.getString("Phone");
                email = rs.getString("Email");
                result = new ConsignmentDTO(fullName, phone, address, email);
            }

            query = "SELECT p.ProductName, c.ConsignmentID, c.ReceivedDate, c.MinPrice, c.MaxPrice, c.CancelDate FROM Product p, Consignment c WHERE c.ConsignmentID = ? AND c.ProductID = p.ProductID";
            stm = con.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {
                float minPrice = 0, maxPrice = 0;
                String ProductName = rs.getString("ProductName");
                String ConsignmentID = rs.getString("ConsignmentID");
                if (rs.getString("ReceivedDate") != null) {
                    ReceivedDate = convertDate(rs.getString("ReceivedDate"));
                }
                if (rs.getString("CancelDate") != null) {
                    CancelDate = convertDate(rs.getString("CancelDate"));
                }
                minPrice = rs.getFloat("MinPrice");
                maxPrice = rs.getFloat("MaxPrice");
                ProductDTO product = new ProductDTO(ProductName, ReceivedDate, ConsignmentID, minPrice, maxPrice, CancelDate);
                if (product != null) {
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

    public ProductDTO getInforForPublishPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO result = null;
        String productName = "", serialNumber = "", purchasedDate = "", brand = "", description = "", image = "";
        int categoryID = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT ProductName, SerialNumber, PurchasedDate, CategoryID, Brand, Description, Image "
                    + "FROM Product WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                productName = rs.getString("ProductName");
                serialNumber = rs.getString("SerialNumber");
                purchasedDate = rs.getString("PurchasedDate");
                if (!purchasedDate.equals("")) {
                    purchasedDate = convertDate(purchasedDate);
                }
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

    public ConsignmentDTO getInforForOrderedPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String orderID = "", date = "", email = "", fullname = "", address = "", phone = "", productName = "";
        float minPrice = 0, maxPrice = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT OrderID, Date, Email, FullName, Address, Phone FROM [Order] WHERE OrderID = "
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
                phone = rs.getString("Phone");
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

    public boolean OrderProduct(int productID, int status, float sellingPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        int result = 0;
        String query = "";
        try {
            conn = DBUltilities.makeConnection();
            query = "UPDATE Product SET ProductStatusID = ? WHERE ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, status);
            stm.setInt(2, productID);
            result = stm.executeUpdate();
            if (sellingPrice > 0) {
                query = "UPDATE Product SET SellingPrice = ?";
                stm = conn.prepareStatement(query);
                stm.setFloat(1, sellingPrice);
                stm.executeUpdate();
            }
            return (result > 0);
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

    public ConsignmentDTO getInforForSoldPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String consignmentID = "", receivedDate = "", email = "", fullname = "", address = "", phone = "", productName = "", paypalAccount = "";
        float minPrice = 0, maxPrice = 0, sellingPrice = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.MinPrice, c.MaxPrice, c.FullName, c.Address, c.Phone, c.Email, c.PaypalAccount, c.ReceivedDate, c.ConsignmentID, p.ProductName, p.SellingPrice "
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
                phone = rs.getString("Phone");
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
            query = "UPDATE Product set ProductStatusID = ? WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.COMPLETED);
            stm.setString(2, consignmentID);
            result2 = stm.executeUpdate();
            if (result1 > 0 && result2 > 0) {
                return true;
            }
            return false;
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
}
