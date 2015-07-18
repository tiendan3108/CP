package hps.dao;

import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
import java.sql.Connection;
import java.sql.Date;
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
                populateStoreOwner(result);
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

    public List<ConsignmentDTO> findConsignmentByStoreOwnerIDProductNameAndStatus(int storeOwnerID, String productName, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?"
                    + " AND P.ProductStatusID <> 6 "
                    + " ORDER BY C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, storeOwnerID);
            stm.setString(3, "%" + productName + "%");

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

    public List<ConsignmentDTO> getCanceledConsignmentByStoreOwnerID(int storeOwnerID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = 1 AND C.StoreOwnerID = ? AND P.ProductStatusID = 6 "
                    + " ORDER BY C.CancelDate DESC";
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

    //Update Consignment Status except Received
    public boolean updateConsignmentStatus(String consignmentID, int status, String reason) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET ConsignmentStatusID = ?, Reason = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            if (reason.isEmpty()) {
                stm.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                stm.setString(2, reason);
            }

            stm.setString(3, consignmentID);

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
    public boolean updateConsignmentStatusAsReceived(String consignmentID,
            double minPrice, double maxPrice, int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET MinPrice = ?, MaxPrice = ?, ReceivedDate = ?, ConsignmentStatusID = 5"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setDouble(1, minPrice);
            stm.setDouble(2, maxPrice);
            stm.setDate(3, new Date(System.currentTimeMillis()));
            stm.setString(4, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductStatusID = 2 WHERE ProductID = ?";
                stm = con.prepareStatement(sql);
                stm.setDouble(1, productID);
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

    //update consignment and product status for request management
    public boolean updateConsignmentAndProductStatus(String consignmentID, float negotiatedPrice,
            String receivedDate, int consignmentStatusID, int productID, String productName, int categoryID,
            String brand, String description, int productStatusID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET NegotiatedPrice = ?, ReceivedDate = ?, ConsignmentStatusID = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            if (negotiatedPrice > 0) {
                stm.setDouble(1, negotiatedPrice);
            } else {
                stm.setNull(1, java.sql.Types.FLOAT);
            }

            if (receivedDate.isEmpty()) {
                stm.setNull(2, java.sql.Types.DATE);
            } else {
                stm.setString(2, receivedDate);
            }

            stm.setInt(3, consignmentStatusID);
            stm.setString(4, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
                        + " ProductStatusID = ? WHERE ProductID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryID);
                stm.setString(3, brand);
                stm.setString(4, description);
                stm.setDouble(5, productStatusID);
                stm.setInt(6, productID);
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
    public boolean updateConsignmentAndProductStatusWithDate(String consignmentID, float negotiatedPrice, String appointmentDate, int consignmentStatusID, int productID,
            String productName, int categoryID, String brand, String description, int productStatusID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET NegotiatedPrice = ?, AppointmentDate = ?, ConsignmentStatusID = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            if (negotiatedPrice > 0) {
                stm.setDouble(1, negotiatedPrice);
            } else {
                stm.setNull(1, java.sql.Types.FLOAT);
            }

            if (appointmentDate.isEmpty()) {
                stm.setNull(2, java.sql.Types.DATE);
            } else {
                stm.setString(2, appointmentDate);
            }

            stm.setInt(3, consignmentStatusID);

            stm.setString(4, consignmentID);

            int result = stm.executeUpdate();
            if (result > 0) {
                sql = "UPDATE Product SET ProductName = ?, CategoryID = ?, Brand = ?, Description = ?, "
                        + " ProductStatusID = ? WHERE ProductID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryID);
                stm.setString(3, brand);
                stm.setString(4, description);
                stm.setDouble(5, productStatusID);
                stm.setInt(6, productID);
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
                sql = "UPDATE Consignment SET CancelDate = GETDATE() WHERE ProductID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
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
        DateFormat dfHour = new SimpleDateFormat("hh:mm aa");
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
        //String fromDate = rs.getString("FromDate");
        //fromDate = java.formatDateString(fromDate);
        String fromDate = df.format(rs.getDate("FromDate"));

        //String toDate = rs.getString("ToDate");
        //toDate = java.formatDateString(toDate);
        String toDate = df.format(rs.getDate("ToDate"));

        String raiseWebDate = rs.getString("RaiseWebDate");
        if (raiseWebDate != null) {
            raiseWebDate = df.format(rs.getDate("RaiseWebDate"));
            //raiseWebDate = java.formatDateString(raiseWebDate);
        }
        int period = rs.getInt("Period");
        float minPrice = rs.getFloat("MinPrice") / 1000;
        float maxPrice = rs.getFloat("MaxPrice") / 1000;
        float returnPrice = rs.getFloat("ReturnedPrice") / 1000;

        String receiveDate = rs.getString("ReceivedDate");
        if (receiveDate != null) {
            receiveDate = df.format(rs.getDate("ReceivedDate"));
        }
        String createdDate = rs.getString("CreatedDate");
        if (createdDate != null) {
            //createdDate = java.formatDateString(createdDate);
            createdDate = df.format(rs.getDate("CreatedDate"));
        }
        String cancelDate = rs.getString("CancelDate");
        if (cancelDate != null) {
            cancelDate = df.format(rs.getDate("CancelDate"));
            //cancelDate = java.formatDateString(cancelDate);
        }
        String appointmentDate = rs.getString("AppointmentDate");
        String hour = "";
        if (appointmentDate != null) {
            appointmentDate = df.format(rs.getDate("AppointmentDate"));
            hour = dfHour.format(rs.getTimestamp("AppointmentDate"));
        }
        int consignmentStatusID = rs.getInt("ConsignmentStatusID");
        String reason = rs.getString("Reason");
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
        consignment.setHour(hour);
        consignment.setRaiseWebDate(raiseWebDate);
        consignment.setPeriod(period);
        consignment.setMinPrice(minPrice);
        consignment.setMaxPrice(maxPrice);
        consignment.setReturnPrice(returnPrice);
        consignment.setReceivedDate(receiveDate);
        consignment.setCreatedDate(createdDate);
        consignment.setCancelDate(cancelDate);
        consignment.setAppointmentDate(appointmentDate);
        consignment.setConsignmentStatusID(consignmentStatusID);
        consignment.setReason(reason);

        return consignment;
    }
}
