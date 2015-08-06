package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.DBUltilities;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.OrderStatus;
import hps.ultils.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
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
 * @author PhucTQSE60993
 */
public class ConsignmentDAO {

    static ConsignmentDAO dao;

    public static ConsignmentDAO getInstance() {
        if (dao == null) {
            dao = new ConsignmentDAO();
        }
        return dao;
    }

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

    //update consignment and product status for request management
    public boolean updateConsignmentWhenAcceptProduct(String consignmentID, float negotiatedPrice) {
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
                sql = "UPDATE Product SET ProductStatusID = ? "
                        + " WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = con.prepareStatement(sql);

                stm.setInt(1, 2);

                stm.setString(2, consignmentID);
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

    public boolean checkIfConsignmentStatusIsAccepted(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT     C.ConsignmentStatusID, P.ProductStatusID"
                    + "   FROM       dbo.Consignment AS C INNER JOIN "
                    + "              dbo.Product AS P ON C.ProductID = P.ProductID"
                    + "   WHERE      ConsignmentID = ?";
            stm = con.prepareStatement(sql);

            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {           
                if (rs.getInt("ConsignmentStatusID") == GlobalVariables.CONSIGNMENT_ACCEPTED && 
                        rs.getInt("ProductStatusID") == 1) {
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
    
    public boolean checkIfConsignmentStatusIsWaiting(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT     C.ConsignmentStatusID, P.ProductStatusID"
                    + "   FROM       dbo.Consignment AS C INNER JOIN "
                    + "              dbo.Product AS P ON C.ProductID = P.ProductID"
                    + "   WHERE      ConsignmentID = ?";
            stm = con.prepareStatement(sql);

            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            if (rs.next()) {           
                if (rs.getInt("ConsignmentStatusID") == GlobalVariables.CONSIGNMENT_WAITING && 
                        rs.getInt("ProductStatusID") == 1) {
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
            if (address.isEmpty()) {
                stm.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(2, address);
            }
            stm.setString(3, phone);

            if (email.isEmpty()) {
                stm.setNull(4, java.sql.Types.VARCHAR);
            } else {
                stm.setString(4, email);
            }

            if (paypalAccount.isEmpty()) {
                stm.setNull(5, java.sql.Types.VARCHAR);
            } else {
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

    public boolean updateAcceptedrequest(String consignmentID, String fullName, String address,
            String phone, String email, String paypalAccount, String appointmentDate, int deliveryMethod,
            String productName, int categoryID, String brand, String description, int isSpecial) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment "
                    + " SET FullName = ?, Address = ?, Phone = ?, Email = ?, PaypalAccount = ?, "
                    + " AppointmentDate = ?, ConsignmentStatusID = ?, DeliveryMethod = ? "
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, fullName);
            if (address.isEmpty()) {
                stm.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(2, address);
            }
            stm.setString(3, phone);

            if (email.isEmpty()) {
                stm.setNull(4, java.sql.Types.VARCHAR);
            } else {
                stm.setString(4, email);
            }

            if (paypalAccount.isEmpty()) {
                stm.setNull(5, java.sql.Types.VARCHAR);
            } else {
                stm.setString(5, paypalAccount);
            }

            stm.setString(6, appointmentDate);
            stm.setInt(7, GlobalVariables.CONSIGNMENT_ACCEPTED);
            stm.setInt(8, deliveryMethod);
            stm.setString(9, consignmentID);

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
//duchc

    public void ExtendProduct(String consignmentID, int period) {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();

            String query = "UPDATE Consignment SET isExpiredMessage = null, ConsignmentStatusID = ?, Period = ((Period) + 30 + (DATEDIFF(day, RaiseWebDate, GetDate())) ) WHERE ConsignmentID = ?";
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        AccountDAO dao = new AccountDAO();
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

    //begin merge
    //duchcDAO
    public boolean addConsigment(ConsignmentDTO consigment) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUltilities.makeConnection();
            // add Consigment Values
            String query = "INSERT INTO Consignment(ConsignmentID, ProductID, MemberID, StoreOwnerID, FullName, Address,"
                    + " Phone, Email, PaypalAccount, FromDate, ToDate, Period, MinPrice, MaxPrice, CreatedDate, "
                    + " ConsignmentStatusID, ReviewProductDate, NegotiatedPrice, AppointmentDate, ReviewRequestDate, DeliveryMethod) "
                    + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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

            //stm.setString(15, consigment.getCreatedDate());
            stm.setString(15, getCurrentDate());

            stm.setInt(16, consigment.getConsignmentStatusID());

            if (consigment.getReviewProductDate() != null) {
                stm.setString(17, consigment.getReviewProductDate());
            } else {
                stm.setNull(17, java.sql.Types.DATE);
            }
            if (consigment.getNegotiatedPrice() > 0) {
                stm.setDouble(18, consigment.getNegotiatedPrice());
            } else {
                stm.setNull(18, java.sql.Types.FLOAT);
            }

            if (consigment.getAppointmentDate() != null) {
                stm.setString(19, consigment.getAppointmentDate());
            } else {
                stm.setNull(19, java.sql.Types.DATE);
            }

            if (consigment.getReviewRequestDate() != null) {
                stm.setString(20, consigment.getReviewRequestDate());
            } else {
                stm.setNull(20, java.sql.Types.DATE);
            }

            stm.setInt(21, consigment.getDeliveryMethod());

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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return false;
    }

    //danqt
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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private String convertPhone(String source) {
        if (source == null) {
            return "";
        }
        return "0" + source.substring(3);
    }

    private String formatDateString(String source) {
        if (source == null) {
            return "";
        }
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("hh:mm | dd-MM-yyyy");
            Date date = df.parse(source);
            String result = df2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    public List<ConsignmentDTO> getProductStatus(int storeOwnerID, int productStatus) {
        Connection conn = null;
        ResultSet rsC = null, rsP = null;
        PreparedStatement stmC = null, stmP = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        ProductDTO product = null;
        ConsignmentDTO item = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "";
            if (productStatus == ProductStatus.CANCEL) {
                query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ? OR ProductStatusID = ?) ORDER BY ReviewProductDate";
                stmC = conn.prepareStatement(query);
                stmC.setInt(1, storeOwnerID);
                stmC.setInt(2, ProductStatus.NOT_YET_RECEIVE);
                stmC.setInt(3, ProductStatus.CANCEL);
            } else {
                query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? AND ProductID IN (SELECT ProductID FROM Product WHERE ProductStatusID = ?) ORDER BY ReviewProductDate";
                stmC = conn.prepareStatement(query);
                stmC.setInt(1, storeOwnerID);
                stmC.setInt(2, productStatus);
            }
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ConsignmentDTO getInforForCancelPage(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String address = "", phone = "", email = "", reviewProductDate = "", CancelDate = "";
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
                query = "SELECT p.ProductStatusID, p.ProductName, c.ConsignmentID, c.ReviewProductDate, c.NegotiatedPrice, "
                        + "c.CancelDate FROM Product p, Consignment c WHERE c.ConsignmentID = ? AND "
                        + "c.ProductID = p.ProductID";
                stm = con.prepareStatement(query);
                stm.setString(1, consignmentID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int status = rs.getInt("ProductStatusID");
                    String ProductName = rs.getString("ProductName");
                    String ConsignmentID = rs.getString("ConsignmentID");
                    reviewProductDate = formatDateString(rs.getString("ReviewProductDate"));
                    CancelDate = formatDateString(rs.getString("CancelDate"));
                    float negotiatedPrice = rs.getFloat("NegotiatedPrice") / 1000;
                    ProductDTO product = new ProductDTO(ProductName, reviewProductDate, ConsignmentID, negotiatedPrice, CancelDate);
                    product.setProductStatusID(status);
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

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

    public ConsignmentDTO getInforForExpiredPage(String consignmentID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        ProductDTO product = new ProductDTO();
        try {
            conn = DBUltilities.makeConnection();

            Date tempDate = Calendar.getInstance().getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            query = "SELECT * FROM Consignment WHERE StoreOwnerID = ? ORDER BY CreatedDate, CancelDate, AgreeCancelDate, ReceivedDate, ReviewProductDate, ReviewRequestDate";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                item = new ConsignmentDTO();
                item.setName(rs.getString("FullName"));
                item.setConsigmentID(rs.getString("ConsignmentID"));
                item.setCreatedDate(formatDateString(rs.getString("CreatedDate")));
                item.setCancelDate(formatDateString(rs.getString("CancelDate")));
                item.setAgreeCancelDate(formatDateString(rs.getString("AgreeCancelDate")));
                item.setReceivedDate(formatDateString(rs.getString("ReceivedDate")));
                item.setReviewRequestDate(formatDateString(rs.getString("ReviewRequestDate")));
                item.setReviewProductDate(formatDateString(rs.getString("ReviewProductDate")));
                item.setReturnDate(formatDateString(rs.getString("ReturnDate")));
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
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
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
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
