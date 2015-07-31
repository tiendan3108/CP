package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PhucTQSE60993
 */
public class ConsignmentDAO {

    public ConsignmentDTO getConsignment(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE ConsignmentID = ? ";
            stm = con.prepareStatement(sql);
            stm.setString(1, consignmentID);

            rs = stm.executeQuery();
            if (rs.next()) {
                result = getConsignment(rs);
                populateProduct(result);
                //populateStoreOwner(result);
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

    public List<ConsignmentDTO> getConsignmentByStoreOwnerIDAndStatus(int storeOwnerId, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE ConsignmentStatusID = ? AND StoreOwnerID = ?"
                    + " ORDER BY CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, storeOwnerId);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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

    public List<ConsignmentDTO> getConsignmentByStoreOwnerID(int storeOwnerId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE StoreOwnerID = ?"
                    + " ORDER BY CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerId);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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

    public List<ConsignmentDTO> getConsignmentByMemberIDAndProductName(int MemberID, String productName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.MemberID = ? AND P.ProductName LIKE ?"
                    + " ORDER BY C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, MemberID);
            stm.setString(2, "%" + productName + "%");

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                populateStoreOwner(consignment);
                result.add(consignment);
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

    public List<String> autoCompleteConsignmentByMemberIDAndProductName(int memberId, String productName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT P.ProductName"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.MemberID = ? AND P.ProductName LIKE ?"
                    + " ORDER BY P.ProductName ASC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, memberId);
            stm.setString(2, "%" + productName + "%");

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                result.add(rs.getString("ProductName"));
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

//    public List<ConsignmentDTO> findRequestByStoreOwnerIDProductNameAndStatus(int storeOwnerID, String productName, int status) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        List<ConsignmentDTO> result = null;
//        try {
//            con = DBUltilities.makeConnection();
//            String sql = "SELECT *"
//                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
//                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?"
//                    + " AND P.ProductStatusID = 1 "
//                    + " ORDER BY C.CreatedDate DESC";
//            stm = con.prepareStatement(sql);
//            stm.setInt(1, status);
//            stm.setInt(2, storeOwnerID);
//            stm.setString(3, "%" + productName + "%");
//
//            rs = stm.executeQuery();
//            result = new ArrayList<>();
//            while (rs.next()) {
//                ConsignmentDTO consignment = getConsignment(rs);
//                populateProduct(consignment);
//                result.add(consignment);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (stm != null) {
//                    stm.close();
//                }
//                if (con != null) {
//                    con.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//        return result;
//    }
    
    public List<ConsignmentDTO> getListNewRequestByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT C.*"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID "
                    + " WHERE C.ConsignmentStatusID = 1 AND P.ProductStatusID = 1 "
                    + " AND C.StoreOwnerID = ? "
                    + " ORDER BY C.CreatedDate DESC, C.FromDate ASC, C.ToDate ASC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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
    
    public List<ConsignmentDTO> getListAcceptedRequestByStoreOwnerIDDeliveryMethod(int storeOwnerID, int deliveryMethod) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT C.*"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID "
                    + " WHERE C.ConsignmentStatusID = 3 AND P.ProductStatusID = 1 "
                    + " AND C.StoreOwnerID = ?  "
                    //+ " AND C.DeliveryMethod = ? "
                    + " ORDER BY C.ReviewRequestDate DESC, C.AppointmentDate ASC, C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);
            //stm.setInt(2, deliveryMethod);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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
    
    public List<ConsignmentDTO> getListRefusedRequestByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT C.*"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID "
                    + " WHERE C.ConsignmentStatusID = 2 AND P.ProductStatusID = 1 "
                    + " AND C.StoreOwnerID = ? "
                    + " ORDER BY C.ReviewProductDate DESC, C.ReviewRequestDate DESC, C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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

    public List<ConsignmentDTO> getListCanceledRequestByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT C.*"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE (C.ConsignmentStatusID = 1 OR C.ConsignmentStatusID = 3) AND C.StoreOwnerID = ? AND P.ProductStatusID = 6 "
                    + " ORDER BY C.CancelDate DESC, C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                populateProduct(consignment);
                result.add(consignment);
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

    public List<String> autoCompleteConsignmentByStoreOwnerIDAndProductNameAndStatus(int storeOwnerId, String productName, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT P.ProductName"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?"
                    + " ORDER BY P.ProductName ASC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, storeOwnerId);
            stm.setString(3, "%" + productName + "%");

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                result.add(rs.getString("ProductName"));
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

    //Update Consignment when refuse a request
    public boolean updateConsignmentStatusWhenRefuseRequest(String consignmentID, int status, String reason) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET ConsignmentStatusID = ?, Reason = ?, ReviewRequestDate = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            if (reason.isEmpty()) {
                stm.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(2, reason);
            }

            stm.setString(3, getCurrentDate());

            stm.setString(4, consignmentID);

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

    public boolean updateConsignmentStatusWhenRefuseProduct(String consignmentID, int status, String reason) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET ConsignmentStatusID = ?, Reason = ?, ReviewProductDate = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            if (reason.isEmpty()) {
                stm.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(2, reason);
            }

            stm.setString(3, getCurrentDate());
            stm.setString(4, consignmentID);

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

    // update Consigment Status AS Received and Product Status AS Available
//    public boolean updateConsignmentStatusAsReceived(String consignmentID,
//            double minPrice, double maxPrice, int productID) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        try {
//            con = DBUltilities.makeConnection();
//            String sql = "UPDATE Consignment"
//                    + " SET MinPrice = ?, MaxPrice = ?, ReviewProductDate = ?, ConsignmentStatusID = 5"
//                    + " WHERE ConsignmentID = ?";
//            stm = con.prepareStatement(sql);
//            stm.setDouble(1, minPrice);
//            stm.setDouble(2, maxPrice);
//            stm.setDate(3, new Date(System.currentTimeMillis()));
//            stm.setString(4, consignmentID);
//
//            int result = stm.executeUpdate();
//            if (result > 0) {
//                sql = "UPDATE Product SET ProductStatusID = 2 WHERE ProductID = ?";
//                stm = con.prepareStatement(sql);
//                stm.setDouble(1, productID);
//                result = stm.executeUpdate();
//                if (result > 0) {
//                    return true;
//                }
//            }
//            return false;
//        } catch (SQLException ex) {
//            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            try {
//                if (stm != null) {
//                    stm.close();
//                }
//                if (con != null) {
//                    con.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//        return false;
//    }
    //update consignment and product status for request management
    public boolean updateConsignmentWhenAcceptProduct(String consignmentID, float negotiatedPrice, String productName, int categoryID,
            String brand, String description, int isSpecial) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET NegotiatedPrice = ?, ReviewProductDate = ?, ConsignmentStatusID = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            if (negotiatedPrice > 0) {
                stm.setDouble(1, negotiatedPrice);
            } else {
                stm.setNull(1, java.sql.Types.FLOAT);
            }

            stm.setString(2, getCurrentDate());

            stm.setInt(3, GlobalVariables.CONSIGNMENT_RECEIVED);
            stm.setString(4, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
                        + " ProductStatusID = 2, IsSpecial = ? "
                        + "WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryID);
                stm.setString(3, brand);
                stm.setString(4, description);
                //stm.setDouble(5, productStatusID);
                stm.setInt(5, isSpecial);
                stm.setString(6, consignmentID);
                result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }
            return false;
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

    //update consignment with date in consignment management 14/7/2015
//    public boolean updateConsignmentWhenAcceptrequest(String consignmentID, String appointmentDate,
//            String productName, int categoryID, String brand, String description, int isSpecial) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        try {
//            con = DBUltilities.makeConnection();
//            String sql = "UPDATE Consignment"
//                    + " SET  AppointmentDate = ?, ReviewRequestDate = ?, ConsignmentStatusID = ?"
//                    + " WHERE ConsignmentID = ?";
//            stm = con.prepareStatement(sql);
//
//            stm.setString(1, appointmentDate);
//            stm.setString(2, getCurrentDate());
//            stm.setInt(3, GlobalVariables.CONSIGNMENT_ACCEPTED);
//            stm.setString(4, consignmentID);
//
//            int result = stm.executeUpdate();
//            if (result > 0) {
//                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
//                        + " IsSpecial = ?, ProductStatusID = 1"
//                        + "WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
//                stm = con.prepareStatement(sql);
//                stm.setString(1, productName);
//                stm.setInt(2, categoryID);
//                stm.setString(3, brand);
//                stm.setString(4, description);
//                stm.setInt(5, isSpecial);
//                stm.setString(6, consignmentID);
//                result = stm.executeUpdate();
//                if (result > 0) {
//                    return true;
//                }
//            }
//            return false;
//        } catch (SQLException ex) {
//            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            try {
//                if (stm != null) {
//                    stm.close();
//                }
//                if (con != null) {
//                    con.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//        return false;
//    }
    public boolean updateConsignmentWhenAcceptrequest(String consignmentID, String fullName, String address, 
            String phone, String email, String paypalAccount, String appointmentDate, int deliveryMethod,
            String productName, int categoryID, String brand, String description, int isSpecial) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment "
                    + " SET FullName = ?, Address = ?, Phone = ?, Email = ?, PaypalAccount = ?, "
                    + " AppointmentDate = ?, ReviewRequestDate = ?, ConsignmentStatusID = ?, DeliveryMethod = ? "
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, fullName);
            if(address.isEmpty()){
                stm.setNull(2, java.sql.Types.NVARCHAR);
            }else{
                stm.setString(2, address);
            }
            stm.setString(3, phone);
            
            if(email.isEmpty()){
                stm.setNull(4, java.sql.Types.VARCHAR);
            }else{
                stm.setString(4, email);
            }
            
            if(paypalAccount.isEmpty()){
                stm.setNull(5, java.sql.Types.VARCHAR);
            }else{
                stm.setString(5, paypalAccount);
            }
            
            stm.setString(6, appointmentDate);
            stm.setString(7, getCurrentDate());
            stm.setInt(8, GlobalVariables.CONSIGNMENT_ACCEPTED);
            stm.setInt(9, deliveryMethod);
            stm.setString(10, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
                        + " IsSpecial = ?, ProductStatusID = 1"
                        + "WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryID);
                stm.setString(3, brand);
                stm.setString(4, description);
                stm.setInt(5, isSpecial);
                stm.setString(6, consignmentID);
                result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }
            return false;
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

    //cancel Product by change status of product as Canceled and update date on consignment
    public boolean cancelConsignmentInProduct(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Product SET ProductStatusID = 6 WHERE ProductID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, productID);
            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Consignment SET CancelDate = GETDATE(), CancelFee = (SELECT ((NegotiatedPrice)*15/100) FROM Consignment WHERE ProductID = ?) "
                        + " WHERE ProductID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
                stm.setInt(2, productID);
                result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }

            return false;
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

    //used for getting product info from consignment table and insert into ConsignmentDTO
    public void populateProduct(ConsignmentDTO consignment) {
        ProductDAO dao = new ProductDAO();

        ProductDTO product = dao.getProductByIDNoStatus(consignment.getProductID());
        consignment.setProduct(product);
    }

    //used for getting storeOwner info from consignment table and insert into ConsignmentDTO
    public void populateStoreOwner(ConsignmentDTO consignment) {
        DuchcDAO dao = new DuchcDAO();
        AccountDTO storeOwner = dao.getStoreOwnerByID(consignment.getStoreOwnerID());
        consignment.setStoreOwner(storeOwner);
    }

    private ConsignmentDTO getConsignment(ResultSet rs) throws SQLException {
        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        DateFormat df2 = new SimpleDateFormat("HH:mm|dd-MM-yyyy");
        DateFormat dfHour = new SimpleDateFormat("HH:mm");
        //JavaUltilities java = new JavaUltilities();

        String consignmentID = rs.getString("ConsignmentID");
        int productID = rs.getInt("ProductID");
        Integer memberID = rs.getInt("MemberID");
        int storeOwnerID = rs.getInt("StoreOwnerID");
        String fullName = rs.getString("FullName");
        String address = rs.getString("Address");
        String phone = rs.getString("Phone");
        String email = rs.getString("Email");
        String paypalAccount = rs.getString("PaypalAccount");

        String fromDate = df.format(rs.getDate("FromDate"));
        String toDate = df.format(rs.getDate("ToDate"));

        String raiseWebDate = rs.getString("RaiseWebDate");
        if (raiseWebDate != null) {
            raiseWebDate = df.format(rs.getDate("RaiseWebDate"));
        }
        int period = rs.getInt("Period");
        float minPrice = rs.getFloat("MinPrice") / 1000;
        float maxPrice = rs.getFloat("MaxPrice") / 1000;
        float returnPrice = rs.getFloat("ReturnedPrice") / 1000;
        float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;

        String reviewProductDate = rs.getString("ReviewProductDate");
        if (reviewProductDate != null) {
            reviewProductDate = df2.format(rs.getTimestamp("ReviewProductDate"));
        }
        String createdDate = rs.getString("CreatedDate");
        if (createdDate != null) {
            createdDate = df2.format(rs.getTimestamp("CreatedDate"));
        }
        String cancelDate = rs.getString("CancelDate");
        if (cancelDate != null) {
            cancelDate = df.format(rs.getDate("CancelDate"));
        }
        String appointmentDate = rs.getString("AppointmentDate");
        String hour = "";
        if (appointmentDate != null) {
            appointmentDate = df.format(rs.getDate("AppointmentDate"));
            hour = dfHour.format(rs.getTimestamp("AppointmentDate"));
        }

        String reviewRequestDate = rs.getString("ReviewRequestDate");
        if (reviewRequestDate != null) {
            reviewRequestDate = df2.format(rs.getTimestamp("ReviewRequestDate"));
        }
        
        int consignmentStatusID = rs.getInt("ConsignmentStatusID");
        String reason = rs.getString("Reason");
        int deliveryMethod = rs.getInt("DeliveryMethod");
        
        
        ConsignmentDTO consignment = new ConsignmentDTO();
        consignment.setConsigmentID(consignmentID);
        consignment.setProductID(productID);
        if (memberID > 0) {
            consignment.setMemberID(memberID);
        }
        consignment.setStoreOwnerID(storeOwnerID);
        consignment.setName(fullName);
        consignment.setAddress(address);
        consignment.setPhone(phone);
        consignment.setEmail(email);
        consignment.setPaypalAccount(paypalAccount);

        consignment.setFromDate(fromDate);
        consignment.setToDate(toDate);

        consignment.setRaiseWebDate(raiseWebDate);

        consignment.setPeriod(period);
        consignment.setMinPrice(minPrice);
        consignment.setMaxPrice(maxPrice);
        consignment.setReturnPrice(returnPrice);

        consignment.setReviewProductDate(reviewProductDate);
        consignment.setCreatedDate(createdDate);
        consignment.setCancelDate(cancelDate);
        consignment.setAppointmentDate(appointmentDate);
        consignment.setHour(hour);
        consignment.setReviewRequestDate(reviewRequestDate);
        consignment.setConsignmentStatusID(consignmentStatusID);
        consignment.setReason(reason);
        consignment.setNegotiatedPrice(negotiatedPrice);

        consignment.setDeliveryMethod(deliveryMethod);
        return consignment;
    }

    private String getCurrentDate() {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date currentDate = new java.util.Date();
        return df.format(currentDate);

    }
}
