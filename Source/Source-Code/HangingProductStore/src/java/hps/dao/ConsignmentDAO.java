package hps.dao;

import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
                    + " WHERE ConsignmentStatusID = ? AND StoreOwnerID = ?";
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

    public List<ConsignmentDTO> findConsignmentByProductNameAndStatus(int storeOwnerId, String productName, int status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?";
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
            String sql = "SELECT *"
                    + " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID"
                    + " WHERE C.ConsignmentStatusID = ? AND C.StoreOwnerID = ? AND P.ProductName LIKE ?";
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

    public void populateProduct(ConsignmentDTO consignment) {
        ProductDAO dao = new ProductDAO();

        ProductDTO product = dao.getProductByIDNoStatus(consignment.getProductID());
        consignment.setProduct(product);
    }

    private ConsignmentDTO getConsignment(ResultSet rs) throws SQLException {
        String consignmentID = rs.getString("ConsignmentID");
        int productID = rs.getInt("ProductID");
        Integer memberID = rs.getInt("MemberID");
        int storeOwnerID = rs.getInt("StoreOwnerID");
        String fullName = rs.getString("FullName");
        String address = rs.getString("Address");
        String phone = rs.getString("Phone");
        String email = rs.getString("Email");
        String paypalAccount = rs.getString("PaypalAccount");
        String fromDate = rs.getString("FromDate");
        String toDate = rs.getString("ToDate");
        String raiseWebDate = rs.getString("RaiseWebDate");
        int period = rs.getInt("Period");
        float maxPrice = rs.getFloat("MaxPrice");
        float returnPrice = rs.getFloat("ReturnedPrice");
        String receiveDate = rs.getString("ReceivedDate");
        String createdDate = rs.getString("CreatedDate");
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
        consignment.setMaxPrice(maxPrice);
        consignment.setReturnPrice(returnPrice);
        consignment.setReceivedDate(receiveDate);
        consignment.setCreatedDate(createdDate);
        consignment.setConsignmentStatusID(consignmentStatusID);

        return consignment;
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

    public boolean makeConsignmentAsReceived(String consignmentID, double returnPrice) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "UPDATE Consignment"
                    + " SET ReturnedPrice = ?, ReceivedDate = ?, ConsignmentStatusID = 5"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setDouble(1, returnPrice);
            stm.setDate(2, new Date(System.currentTimeMillis()));
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
}
