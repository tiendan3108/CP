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
import java.util.Iterator;
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
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentID = ? ";
            stm = con.prepareStatement(sql);
            stm.setString(1, consignmentID);

            rs = stm.executeQuery();
            if (rs.next()) {
                result = getConsignment(rs);
                //populateProduct(result);
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
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ?"
                    + " ORDER BY C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, storeOwnerId);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                //populateProduct(consignment);
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
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.StoreOwnerID = ?"
                    + " ORDER BY C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerId);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                //populateProduct(consignment);
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
                //populateProduct(consignment);
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

    public List<ConsignmentDTO> getListNewRequestByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
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
                //populateProduct(consignment);
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

    public List<ConsignmentDTO> getListRequestByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * "
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID "
                    + " WHERE (C.ConsignmentStatusID = 1 OR C.ConsignmentStatusID = 3 OR "
                    + " C.ConsignmentStatusID = 2 OR "
                    + " (C.ConsignmentStatusID = 7 AND C.ReviewProductDate IS NULL)) "
                    + " AND P.ProductStatusID = 1 AND C.StoreOwnerID = ? "
                    + " ORDER BY CASE C.ConsignmentStatusID WHEN 1 THEN 1 "
                    + " WHEN 3 THEN 2 "
                    + " WHEN 2 THEN 3 "
                    + " WHEN 7 THEN 4 "
                    + " END, C.ReviewRequestDate ASC,  C.CreatedDate ASC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                //populateProduct(consignment);
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
            String sql = "SELECT *"
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
                //populateProduct(consignment);
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
            String sql = "SELECT *"
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
                //populateProduct(consignment);
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
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE (C.ReviewProductDate IS NULL) AND C.ConsignmentStatusID = 7 AND P.ProductStatusID = 1 AND C.NegotiatedPrice IS NULL AND C.StoreOwnerID = ? "
                    + " ORDER BY C.CancelDate DESC, C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerID);

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                ConsignmentDTO consignment = getConsignment(rs);
                //populateProduct(consignment);
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
                if (rs.getInt("ConsignmentStatusID") == GlobalVariables.CONSIGNMENT_ACCEPTED
                        && rs.getInt("ProductStatusID") == 1) {
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
                if (rs.getInt("ConsignmentStatusID") == GlobalVariables.CONSIGNMENT_WAITING
                        && rs.getInt("ProductStatusID") == 1) {
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

    public boolean updateConsignmentWhenAcceptrequestWithDeliveryMethod(String consignmentID, String appointmentDate) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment "
                    + " SET AppointmentDate = ?, ReviewRequestDate = ?, ConsignmentStatusID = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);

            if (appointmentDate.equals("")) {
                stm.setNull(1, java.sql.Types.DATE);
            } else {
                stm.setString(1, appointmentDate);
            }

            stm.setString(2, getCurrentDate());
            stm.setInt(3, GlobalVariables.CONSIGNMENT_ACCEPTED);
            stm.setString(4, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET  ProductStatusID = 1 "
                        + "WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, consignmentID);
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
            String productName, int categoryID, String brand, String description, int isSpecial, int newStatus) {
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

            if (appointmentDate.length() > 0) {
                stm.setString(6, appointmentDate);
            } else {
                stm.setNull(6, java.sql.Types.DATE);
            }

            stm.setInt(7, GlobalVariables.CONSIGNMENT_ACCEPTED);
            stm.setInt(8, deliveryMethod);
            stm.setString(9, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
                        + " IsSpecial = ?, NewStatus = ?, ProductStatusID = 1"
                        + "WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryID);
                stm.setString(3, brand);
                stm.setString(4, description);
                stm.setInt(5, isSpecial);
                stm.setInt(6, newStatus);
                stm.setString(7, consignmentID);
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
    public boolean cancelConsignmentInProduct(String consignmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();

            String sql = "SELECT ConsignmentStatusID FROM Consignment WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, consignmentID);
            ResultSet rs = stm.executeQuery();
            int result = 0;
            if (rs.next()) {
                int consignmentStatusID = rs.getInt("ConsignmentStatusID");
                if (consignmentStatusID == GlobalVariables.CONSIGNMENT_WAITING || consignmentStatusID == GlobalVariables.CONSIGNMENT_ACCEPTED) {
                    sql = "UPDATE Consignment SET ConsignmentStatusID = 7, CancelDate = GETDATE()"
                            + " WHERE ConsignmentID = ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, consignmentID);
                    result = stm.executeUpdate();
                    if (result > 0) {
                        sql = "UPDATE Product SET ProductStatusID = 1 "
                                + " WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, consignmentID);
                        result = stm.executeUpdate();
                        if (result > 0) {
                            return true;
                        }
                    }
                } else {
                    sql = "UPDATE Consignment SET CancelDate = GETDATE(), CancelFee = (SELECT ((NegotiatedPrice)*15/100) FROM Consignment WHERE ConsignmentID = ?) "
                            + " WHERE ConsignmentID = ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, consignmentID);
                    stm.setString(2, consignmentID);

                    result = stm.executeUpdate();
                    if (result > 0) {
                        sql = "UPDATE Product SET ProductStatusID = 6 "
                                + " WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, consignmentID);
                        result = stm.executeUpdate();
                        if (result > 0) {
                            return true;
                        }
                    }
                }
//                     result = stm.executeUpdate();
//                    if (result > 0) {
//                        return true;
//                    }
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

            String query = "SELECT (DATEDIFF(day, RaiseWebDate, GetDate())) AS DiffDate,"
                    + " NegotiatedPrice FROM Consignment WHERE ConsignmentID = ?";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int diffDate = rs.getInt("DiffDate");
                float negotiatedPrice = rs.getFloat("NegotiatedPrice");

                int newPeriod = period + diffDate;
                float extraPayment = 0;
                if (negotiatedPrice >= 1000000) {
                    extraPayment = 5000 * (diffDate - period);
                } else {
                    extraPayment = 10000 * (diffDate - period);
                }
                System.out.println("---------------------------------");
                System.out.println("diffDate: " + diffDate);
                System.out.println("newPeriod: " + newPeriod);
                System.out.println("extraPayment: " + extraPayment);
                System.out.println("---------------------------------");

                query = "UPDATE Consignment SET isExpiredMessage = null, ConsignmentStatusID = ?, "
                        + " Period = ?, RemainExtendFee = (ISNULL(RemainExtendFee, 0) + ?) "
                        + " WHERE ConsignmentID = ?";
                stm = conn.prepareStatement(query);
                stm.setInt(1, ConsignmentStatus.RECEIVED);
                stm.setInt(2, newPeriod);
                stm.setFloat(3, extraPayment);
                stm.setString(4, consignmentID);
                int i = stm.executeUpdate();

                query = "UPDATE Product SET ProductStatusID = ? "
                        + " WHERE ProductID = (SELECT ProductID FROM Consignment WHERE ConsignmentID = ?)";
                stm = conn.prepareStatement(query);
                stm.setInt(1, ProductStatus.ON_WEB);
                stm.setString(2, consignmentID);
                i = stm.executeUpdate();
            }

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
        phone = "0" + phone.substring(3);

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
        float desirePrice = rs.getFloat("DesirePrice") / 1000;

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
            cancelDate = df2.format(rs.getTimestamp("CancelDate"));
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
        consignment.setDesirePrice(desirePrice);

        String productName = rs.getString("ProductName");
        String serialNumber = rs.getString("SerialNumber");
        String purchasedDate = rs.getString("PurchasedDate");
        int categoryID = rs.getInt("CategoryID");
        String brand = rs.getString("Brand");
        String description = rs.getString("Description");
        String image = rs.getString("Image");
        int productStatusID = rs.getInt("ProductStatusID");
        float sellingPrice = rs.getFloat("SellingPrice");
        ProductDTO product = new ProductDTO(productID, productName, serialNumber, purchasedDate, categoryID, brand, description, image, productStatusID, sellingPrice, 0);
        String sellDate = rs.getString("SellDate");
        if (sellDate != null) {
            sellDate = df.format(rs.getDate("SellDate"));
            product.setSellDate(sellDate);
        }
        int isSpecial = rs.getInt("IsSpecial");
        product.setIsSpecial(isSpecial);
        int newStatus = rs.getInt("NewStatus");
        product.setNewStatus(newStatus);

        consignment.setProduct(product);
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
                    + " ConsignmentStatusID, ReviewProductDate, NegotiatedPrice, AppointmentDate,"
                    + " ReviewRequestDate, DeliveryMethod, DesirePrice) "
                    + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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

            if (consigment.getDesirePrice() > 0) {
                stm.setDouble(22, consigment.getDesirePrice());
            } else {
                stm.setNull(22, java.sql.Types.FLOAT);

            }

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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String today = sdf.format(tempDate);
            System.out.println("Today : " + today);
            query = "SELECT c.ConsignmentID, c.FullName, c.Phone, c.Email FROM Consignment c, Product p WHERE "
                    + "DATEDIFF(day,[RaiseWebDate],?) > Period AND p.ProductID = c.ProductID AND "
                    + "p.ProductStatusID > 1 AND p.ProductStatusID < 4 AND c.isExpiredMessage is NULL";
            stm = conn.prepareStatement(query);
            stm.setString(1, today);
            rs = stm.executeQuery();
            while (rs.next()) {
                System.out.println("ConsignmentID");
                consignmentList.add(rs.getString("ConsignmentID"));
                String consignmentID = rs.getString("ConsignmentID");
                String fullName = rs.getString("FullName");
                String phone = (rs.getString("Phone"));
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
                    stm.setInt(1, ProductStatus.AVAILABLE);
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
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("HH:mm | dd-MM-yyyy");
            Date date = df.parse(source);
            String result = df2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(JavaUltilities.class.getName()).log(Level.SEVERE, null, ex);
            return "";
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
            String query = "SELECT c.CancelFee, c.FullName, c.Address, c.Phone, c.Email FROM Consignment c "
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
                float cancelFee = rs.getFloat("CancelFee") / 1000;
                result.setMaxPrice(cancelFee);
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

    public ConsignmentDTO getInforForSoldPage(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = new ConsignmentDTO();
        String consignmentID = "", receivedDate = "", email = "", fullname = "", address = "", phone = "", productName = "", paypalAccount = "";
        float negotiatedPrice = 0, sellingPrice = 0, remainExtendFee = 0;
        int period = 0;
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT c.NegotiatedPrice, c.FullName, c.Address, c.Phone, c.Email, c.Period, c.RemainExtendFee, "
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
                remainExtendFee = rs.getFloat("RemainExtendFee");

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
            result.setRemainExtendFee(remainExtendFee);
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

            String query = "SELECT c.*, p.ProductName, p.Brand, cat.EnglishName, DATEDIFF(day,c.ReviewProductDate,?) AS DiffDate "
                    + "FROM Consignment c, Product p, Category cat WHERE ConsignmentID = ? AND c.ProductID = p.ProductID AND cat.CategoryID = p.CategoryID";
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
                String brand = rs.getString("Brand");
                String category = rs.getString("EnglishName");
                product.setBrand(brand);
                product.setCategoryName(category);
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
            query = "SELECT C.*, P.ProductStatusID "
                    + " FROM Consignment C, Product P "
                    + " WHERE StoreOwnerID = ? AND C.ProductID = P.ProductID "
                    + " ORDER BY C.CancelDate, C.AgreeCancelDate, C.ReceivedDate, "
                    + " C.ReviewProductDate, C.ReviewRequestDate, C.CreatedDate";
            stm = conn.prepareStatement(query);
            stm.setInt(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                item = new ConsignmentDTO();
                item.setName(rs.getString("FullName"));
                item.setConsigmentID(rs.getString("ConsignmentID"));
                item.setCreatedDate(formatDate(rs.getString("CreatedDate")));
                item.setCancelDate(formatDate(rs.getString("CancelDate")));
                item.setAgreeCancelDate(formatDate(rs.getString("AgreeCancelDate")));
                item.setReceivedDate(formatDate(rs.getString("ReceivedDate")));
                item.setReviewRequestDate(formatDate(rs.getString("ReviewRequestDate")));
                item.setReviewProductDate(formatDate(rs.getString("ReviewProductDate")));
                item.setReturnDate(formatDate(rs.getString("ReturnDate")));
                item.setPhone(convertPhone(rs.getString("Phone")));
                item.setConsignmentStatusID(rs.getInt("ConsignmentStatusID"));
                item.setRaiseWebDate(formatDate(rs.getString("RaiseWebDate")));
                ProductDTO product = new ProductDTO();
                product.setProductStatusID(rs.getInt("ProductStatusID"));
                item.setProduct(product);
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

    public ConsignmentDTO getDetailConsignment(String consignmentID) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "";
        ConsignmentDTO item = null;
        ProductDTO product = null;
        try {
            conn = DBUltilities.makeConnection();
            query = "SELECT c.*, p.*, ca.CategoryName FROM Consignment c, Product p, Category ca WHERE c.ConsignmentID = ? AND c.ProductID = p.ProductID AND p.CategoryID = ca.CategoryID";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                item = new ConsignmentDTO();
                item.setNegotiatedPrice(rs.getFloat("NegotiatedPrice") / 1000);
                item.setName(rs.getString("FullName"));
                item.setConsigmentID(rs.getString("ConsignmentID"));
                item.setCreatedDate(formatDateString(rs.getString("CreatedDate")));//
                item.setCancelDate(formatDateString(rs.getString("CancelDate")));//
                item.setAgreeCancelDate(formatDateString(rs.getString("AgreeCancelDate")));//
                item.setReceivedDate(formatDateString(rs.getString("ReceivedDate")));//
                item.setReviewRequestDate(formatDateString(rs.getString("ReviewRequestDate")));//
                item.setReviewProductDate(formatDateString(rs.getString("ReviewProductDate")));//
                item.setReturnDate(formatDateString(rs.getString("ReturnDate")));//
                item.setRaiseWebDate(formatDateString(rs.getString("RaiseWebDate")));//
                item.setPhone(convertPhone(rs.getString("Phone")));
                item.setEmail(rs.getString("Email"));
                item.setPeriod(rs.getInt("Period"));
                item.setReturnPrice(rs.getFloat("ReturnedPrice") / 1000);
                item.setPaypalAccount(rs.getString("PaypalAccount"));
                item.setConsignmentStatusID(rs.getInt("ConsignmentStatusID"));
                String temp = rs.getString("Reason");
                if (temp == null) {
                    item.setReason("");
                } else {
                    item.setReason(temp);
                }
                product = new ProductDTO();
                product.setName(rs.getString("ProductName"));
                product.setImage(rs.getString("Image"));
                product.setBrand(rs.getString("Brand"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setSellDate(formatDateString(rs.getString("SellDate")));
                product.setProductStatusID(rs.getInt("ProductStatusID"));
                item.setProduct(product);
            }
            return item;
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

    private String formatDate(String source) {
        if (source == null) {
            return "";
        }
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("dd-MM-yyyy");
            Date date = df.parse(source);
            String result = df2.format(date);
            return result;
        } catch (ParseException ex) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    private List<ConsignmentDTO> getProduct(int storeOwnerID, int productStatusID, int consignmentStatusID, String orderCollumn) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();

            String query = "SELECT c.*, p.* FROM Consignment c, Product p "
                    + "WHERE c.StoreOwnerID = ? AND c.ProductID = p.ProductID AND "
                    + "p.ProductStatusID = ? AND c.ConsignmentStatusID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            stm.setInt(2, productStatusID);
            stm.setInt(3, consignmentStatusID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                int productID = rs.getInt("ProductID");
                String consignorName = rs.getString("FullName");
                String consignmentID = rs.getString("ConsignmentID");
                String reviewProductDate = formatDateString(rs.getString("ReviewProductDate"));
                ProductDTO product = new ProductDTO();
                product.setProductID(productID);
                product.setProductStatusID(productStatusID);
                product.setName(productName);
                ConsignmentDTO item = new ConsignmentDTO();
                item.setName(consignorName);
                item.setProduct(product);
                item.setConsigmentID(consignmentID);
                item.setReviewProductDate(reviewProductDate);
                item.setConsignmentStatusID(consignmentStatusID);
                result.add(item);
            }
            return result;
        } catch (Exception e) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            return new ArrayList<>();
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
            } catch (SQLException e) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    private List<ConsignmentDTO> getCancelProduct(int storeOwnerID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();

            String query = "SELECT c.*, p.* FROM Consignment c, Product p "
                    + "WHERE c.StoreOwnerID = ? AND c.ProductID = p.ProductID AND "
                    + "p.ProductStatusID = ? AND c.ConsignmentStatusID = ? AND c.RaiseWebDate IS NOT NULL";
            stm = conn.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            stm.setInt(2, ProductStatus.NOT_AVAILABLE);
            stm.setInt(3, ConsignmentStatus.CANCEL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                int productID = rs.getInt("ProductID");
                String consignorName = rs.getString("FullName");
                String consignmentID = rs.getString("ConsignmentID");
                String reviewProductDate = formatDateString(rs.getString("ReviewProductDate"));
                ProductDTO product = new ProductDTO();
                product.setProductID(productID);
                product.setProductStatusID(ProductStatus.NOT_AVAILABLE);
                product.setName(productName);
                ConsignmentDTO item = new ConsignmentDTO();
                item.setName(consignorName);
                item.setProduct(product);
                item.setConsigmentID(consignmentID);
                item.setReviewProductDate(reviewProductDate);
                item.setConsignmentStatusID(ConsignmentStatus.CANCEL);
                result.add(item);
            }
            return result;
        } catch (Exception e) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            return new ArrayList<>();
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
            } catch (SQLException e) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public List<ConsignmentDTO> getProductForManageProductPage(int storeOwnerID) {
        List<ConsignmentDTO> result = new ArrayList<>();
        List<ConsignmentDTO> temp = new ArrayList<>();
        // available product
        temp = getProduct(storeOwnerID, ProductStatus.AVAILABLE, ConsignmentStatus.RECEIVED, "ReviewProductDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        // on web product
        temp = getProduct(storeOwnerID, ProductStatus.ON_WEB, ConsignmentStatus.RECEIVED, "RaiseWebDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        // request cancel
        temp = getProduct(storeOwnerID, ProductStatus.CANCEL, ConsignmentStatus.RECEIVED, "CancelDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        // wait receive product
        temp = getProduct(storeOwnerID, ProductStatus.NOT_YET_RECEIVE, ConsignmentStatus.CANCEL, "CancelDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        // expired
        temp = getProduct(storeOwnerID, ProductStatus.AVAILABLE, ConsignmentStatus.EXPIRED, "CancelDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        // completed
        temp = getProduct(storeOwnerID, ProductStatus.NOT_AVAILABLE, ConsignmentStatus.COMPLETED, "ReceivedDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        temp = getProduct(storeOwnerID, ProductStatus.COMPLETED, ConsignmentStatus.COMPLETED, "ReturnDate");
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        temp = getCancelProduct(storeOwnerID);
        for (ConsignmentDTO next : temp) {
            result.add(next);
        }
        return result;
    }

    public List<ConsignmentDTO> getProductForManageSalesPage(int storeOwnerID) {
        Connection conn = null;
        ResultSet rs = null, rsOrder = null;
        PreparedStatement stm = null, stmOrder = null;
        List<ConsignmentDTO> result = new ArrayList<>();
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT c.*, p.* FROM Consignment c, Product p WHERE c.StoreOwnerID = ? AND c.ProductID = p.ProductID AND (p.ProductStatusID IN (?,?)) ORDER BY p.ProductStatusID, c.ProductID";
            stm = conn.prepareStatement(query);
            stm.setInt(1, storeOwnerID);
            stm.setInt(2, ProductStatus.ORDERED);
            stm.setInt(3, ProductStatus.SOLD);
            rs = stm.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("ProductName");
                int productID = rs.getInt("ProductID");
                String consignorName = rs.getString("FullName");
                int productStatusID = rs.getInt("ProductStatusID");
                String consignmentID = rs.getString("ConsignmentID");
                int consignmentStatusID = rs.getInt("ConsignmentStatusID");
                String reviewProductDate = formatDateString(rs.getString("ReviewProductDate"));
                ProductDTO product = new ProductDTO();
                product.setProductID(productID);
                product.setProductStatusID(productStatusID);
                product.setName(productName);
                ConsignmentDTO item = new ConsignmentDTO();
                item.setName(consignorName);
                item.setProduct(product);
                item.setConsigmentID(consignmentID);
                item.setReviewProductDate(reviewProductDate);
                item.setConsignmentStatusID(consignmentStatusID);
                query = "SELECT COUNT(*) AS Quantity FROM [Order] WHERE ProductID = ? AND OrderStatusID = ?";
                stmOrder = conn.prepareStatement(query);
                stmOrder.setInt(1, productID);
                stmOrder.setInt(2, OrderStatus.WAITING);
                rsOrder = stmOrder.executeQuery();
                while (rsOrder.next()) {
                    item.setQuantity(rsOrder.getInt("Quantity"));
                }
                result.add(item);
            }
            return result;
        } catch (Exception e) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (rsOrder != null) {
                    rs.close();
                }
                if (stmOrder != null) {
                    stm.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public int checkProductStatusByConsignmentID(String consignmentID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        try {
            conn = DBUltilities.makeConnection();
            String query = "SELECT c.ConsignmentStatusID, p.ProductStatusID FROM Consignment c, Product p WHERE  c.ConsignmentID = ? AND c.ProductID = p.ProductID";
            stm = conn.prepareStatement(query);
            stm.setString(1, consignmentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int productStatusID = rs.getInt("ProductStatusID");
                int consignmentStatusID = rs.getInt("ConsignmentStatusID");
                if (productStatusID == 3 && consignmentStatusID == 5) {
                    return 2;
                }
                if (productStatusID == 2 && consignmentStatusID == 5) {
                    return 1;
                }
                if ((productStatusID == 6 && consignmentStatusID == 5) || (productStatusID == 8 && consignmentStatusID == 7)) {
                    return 3;
                }
                if ((productStatusID == 2 && consignmentStatusID == 6)) {
                    return 4;
                }
                if ((productStatusID == 4 && consignmentStatusID == 5)) {
                    return 5;
                }
                if ((productStatusID == 5 && consignmentStatusID == 5)) {
                    return 6;
                }
                return -1;
            }
            return -1;
        } catch (Exception e) {
            Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            return -1;
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
            } catch (SQLException e) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public AccountDTO sellProductOnWeb(int productID, float sellingPrice) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stm = null;
        AccountDTO result = null;
        try {
            conn = DBUltilities.makeConnection();
            conn.setAutoCommit(false);
            String today = getCurrentDate();
            String query = "UPDATE Product SET ProductStatusID = ?, SellingPrice = ?, SellDate = ? WHERE ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, ProductStatus.SOLD);
            stm.setFloat(2, sellingPrice * 1000);
            stm.setString(3, today);
            stm.setInt(4, productID);
            int a = stm.executeUpdate();
            query = "SELECT * FROM Consignment WHERE ProductID = ?";
            stm = conn.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String name = rs.getString("FullName");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                String consignmentID = rs.getString("ConsignmentID");
                result = new AccountDTO();
                result.setFullName(name);
                result.setEmail(email);
                result.setPhone(phone);
                result.setAccountID(consignmentID);
            }
            if (result != null & a > 0) {
                conn.commit();
                return result;
            } else {
                return null;
            }
        } catch (Exception e) {
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
            } catch (SQLException e) {
                Logger.getLogger(ConsignmentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
}
