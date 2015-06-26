/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.OrderDTO;
import hps.ultils.DBUltilities;
import hps.ultils.OrderStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNHSE61007
 */
public class OrderDAO {

    /**
     *
     * @author HoangNHSE61007 insert order
     */
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
        try {
            con = DBUltilities.makeConnection();
            String sql = "Insert into [Order] Values(?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, order.getOrderID());
            stm.setInt(2, order.getCustomerID());
            stm.setDate(3, new java.sql.Date(date.getTime()));
            stm.setString(4, order.getEmail());
            stm.setString(5, order.getFullName());
            stm.setString(6, order.getAddress());
            stm.setString(7, order.getPhone());
            stm.setFloat(8, order.getTotalPrice());
            stm.setInt(9, OrderStatus.WAITING);
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
}
