package hps.dao;

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
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, consignmentID);

            rs = stm.executeQuery();
            while (rs.next()) {
                result = getConsignment(rs);
                populateProduct(result);
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

    public List<ConsignmentDTO> getConsignmentByStoreAndStatus(int storeOwnerId, int status) {
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
    
    public List<ConsignmentDTO> getConsignmentByStore(int storeOwnerId) {
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
    
    public List<ConsignmentDTO> getConsignmentByMember(int MemberID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE MemberID = ?"
                    + " ORDER BY CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, MemberID);

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
    

    public List<ConsignmentDTO> findConsignmentByProductNameAndStatus(int storeOwnerId, String productName, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?"
                    + " ORDER BY C.CreatedDate DESC";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, storeOwnerId);
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

    public List<String> listConsignmentByProductNameAndStatus(int storeOwnerId, String productName, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT P.ProductName"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?"
                    + " ORDER BY C.CreatedDate DESC";
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

    

    public boolean makeConsignmentAsStatus(String consignmentID, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET ConsignmentStatusID = ?"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setString(2, consignmentID);

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

//    public boolean makeConsignmentAsReceived(String consignmentID, double returnPrice) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        try {
//            con = DBUltilities.makeConnection();
//            String sql = "UPDATE Consignment"
//                    + " SET ReturnedPrice = ?, ReceivedDate = ?, ConsignmentStatusID = 5"
//                    + " WHERE ConsignmentID = ?";
//            stm = con.prepareStatement(sql);
//            stm.setDouble(1, returnPrice);
//            stm.setDate(2, new Date(System.currentTimeMillis()));
//            stm.setString(3, consignmentID);
//
//            int result = stm.executeUpdate();
//            while (result > 0) {
//                return true;
//            }
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

    public boolean updateConsignmentAsReceived(String consignmentID, double minPrice, double maxPrice, int productID) {
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
                if(result > 0){
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

    public ConsignmentDTO getByProductID(int productID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment "
                    + " WHERE ProductID = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, productID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String consignmentID = rs.getString("ConsignmentID");
                int period = rs.getInt("Period");
                String receiveDate = rs.getString("ReceivedDate");
                int consignmentStatusID = rs.getInt("ConsignmentStatusID");
                result = new ConsignmentDTO();
                result.setPeriod(period);
                result.setReceivedDate(receiveDate);
                result.setConsignmentStatusID(consignmentStatusID);
                result.setConsigmentID(consignmentID);
            }
            return result;
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
    
    
    //used for getting product info from consignment table and insert into ConsignmentDTO
    public void populateProduct(ConsignmentDTO consignment) {
        ProductDAO dao = new ProductDAO();

        ProductDTO product = dao.getProductByIDNoStatus(consignment.getProductID());
        consignment.setProduct(product);
    }

    private ConsignmentDTO getConsignment(ResultSet rs) throws SQLException {
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
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
        float minPrice = rs.getFloat("MinPrice");
        float maxPrice = rs.getFloat("MaxPrice");
        float returnPrice = rs.getFloat("ReturnedPrice");
        String receiveDate = rs.getString("ReceivedDate");
        if (receiveDate != null) {
            receiveDate = df.format(rs.getDate("ReceivedDate"));
        }
        String createdDate = rs.getString("CreatedDate");
        if (createdDate != null) {
            createdDate = df.format(rs.getDate("CreatedDate"));
        }
        String cancelDate = rs.getString("CancelDate");
        if (cancelDate != null) {
            cancelDate = df.format(rs.getDate("CancelDate"));
        }
        int consignmentStatusID = rs.getInt("ConsignmentStatusID");

        ConsignmentDTO consignment = new ConsignmentDTO();
        consignment.setConsigmentID(consignmentID);
        consignment.setProductID(productID);
        if (memberID != null) {
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
        consignment.setReceivedDate(receiveDate);
        consignment.setCreatedDate(createdDate);
        consignment.setConsignmentStatusID(consignmentStatusID);

        return consignment;
    }
}
