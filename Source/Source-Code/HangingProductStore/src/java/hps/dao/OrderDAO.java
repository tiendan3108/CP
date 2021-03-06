/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.OrderDTO;
import hps.ultils.DBUltilities;
import hps.ultils.OrderStatus;
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
public class OrderDAO {

    static OrderDAO orderDAO;

    /**
     *
     * @author HoangNHSE61007 insert order
     */
    public static OrderDAO getInstance() {
        if (orderDAO == null) {
            orderDAO = new OrderDAO();
        }
        return orderDAO;
    }

    public boolean insertOrder(String orderID, int customerID, String email, String phone, String fullname, String address) {
        Connection con = null;
        PreparedStatement stm = null;
        Date date = new Date();
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into [Order] (OrderID, CustomerID,[Date],Email,Phone) "
                    + "Values(?,?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, orderID);
            stm.setInt(2, customerID);
            stm.setDate(3, new java.sql.Date(date.getTime()));
            stm.setString(4, email);
            stm.setString(5, phone);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     *
     * @author HoangNHSE61007 insert order
     */
    public boolean insertOrderWithMemberInfo(OrderDTO order) {
        Connection con = null;
        PreparedStatement stm = null;
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDateTime = format.format(date);
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into [Order] Values(?,?,?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, order.getOrderID());
            stm.setInt(2, order.getCustomerID());
            stm.setString(3, currentDateTime);
            stm.setString(4, order.getEmail());
            stm.setString(5, order.getFullName());
            stm.setString(6, order.getAddress());
            stm.setString(7, order.getPhone());
            stm.setFloat(8, order.getTotalPrice());
            stm.setInt(9, OrderStatus.WAITING);
            stm.setInt(10, order.getProductID());
            stm.setNull(11, java.sql.Types.FLOAT);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public List<OrderDTO> checkOrderExpired() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date date = new Date();
        List<OrderDTO> orders = new ArrayList<OrderDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from [Order] "
                    + "where DATEDIFF(day,[Order].Date, ?) >= 3 "
                    + "and OrderStatusID = ?";
            stm = con.prepareStatement(query);
            stm.setDate(1, new java.sql.Date(date.getTime()));
            stm.setInt(2, OrderStatus.WAITING);
            rs = stm.executeQuery();
            while (rs.next()) {
                String orderID = rs.getString("OrderID");
                int productID = rs.getInt("ProductID");
                OrderDTO order = new OrderDTO();
                order.setOrderID(orderID);
                order.setProductID(productID);
                orders.add(order);
            }
            return orders;
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

    public boolean updateOrderWhenOrderExpired(String orderID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE [Order] "
                    + " SET OrderStatusID = ? "
                    + " WHERE OrderID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, OrderStatus.EXPIRED);
            stm.setString(2, orderID);
            stm.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public long getNumOfOrder(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        long numOfOrder = 0;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select COUNT(OrderID) as numOfOrder "
                    + "from [Order] "
                    + "where ProductID = ? "
                    + "and OrderStatusID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, OrderStatus.WAITING);
            rs = stm.executeQuery();
            if (rs.next()) {
                numOfOrder = rs.getLong("numOfOrder");
            }
            return numOfOrder;
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

    public List<OrderDTO> getPhone(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<OrderDTO> orders = new ArrayList<OrderDTO>();
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * "
                    + "from [Order] "
                    + "where ProductID = ? "
                    + "and OrderStatusID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            stm.setInt(2, OrderStatus.WAITING);
            rs = stm.executeQuery();
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                String phone = rs.getString("Phone");
                order.setPhone(phone);
                orders.add(order);
            }
            return orders;
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
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean cancelAllOrders(String orderID) {
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
                    + "(SELECT ProductID FROM [Order] WHERE OrderID = ?) AND ProductStatusID = ?";
            stmP = conn.prepareStatement(query);
            stmP.setInt(1, ProductStatus.ON_WEB);
            stmP.setString(2, orderID);
            stmP.setInt(3, ProductStatus.ORDERED);
            stmP.executeUpdate();

            conn.commit();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public String getCustomerInforByOrderID(String _orderID, int sendPrice) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        float price = sendPrice * 1000;
        try {

            conn = DBUltilities.makeConnection();
            query = "UPDATE [Order] SET SendPrice = ? WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setFloat(1, price);
            stm.setString(2, _orderID);
            stm.executeUpdate();

            query = "SELECT * FROM [Order] WHERE OrderID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, _orderID);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("Phone");
            }
            return null;
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private String convertPhone(String source) {
        if (source == null) {
            return "";
        }
        return "0" + source.substring(3);
    }

}
