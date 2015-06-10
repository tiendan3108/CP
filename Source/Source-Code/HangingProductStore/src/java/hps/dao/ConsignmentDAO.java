package hps.dao;

import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.DBUltilities;
import java.sql.Connection;
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

    public ConsignmentDTO getConsignment(String consigmentID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ConsignmentDTO result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE ConsignmentID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, consigmentID);

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

    public List<ConsignmentDTO> getConsignmentByStore(int storeOwnerId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT * FROM Consignment"
                    + " WHERE StoreOwnerID = ?";
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
    
    public List<ConsignmentDTO> findConsignmentByProductName(int storeOwnerId, String productName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ConsignmentDTO> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT *" +
                         " FROM Consignment AS C JOIN Product AS P ON C.ProductID = P.ProductID" +
                         " WHERE C.StoreOwnerID = ? AND P.ProductName LIKE ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, storeOwnerId);
            stm.setString(2, "%" + productName + "%");

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

    public void populateProduct(ConsignmentDTO consignment) {
        productDAO dao = new productDAO();

        ProductDTO product = dao.getProductByID(consignment.getProductID());
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
        String cardNumber = rs.getString("CardNumber");
        String cardOwner = rs.getString("CardOwner");
        String fromDate = rs.getString("FromDate");
        String toDate = rs.getString("ToDate");
        String raiseWebDate = rs.getString("RaiseWebDate");
        String status = rs.getString("Status");
        int period = rs.getInt("Period");
        float maxPrice = rs.getFloat("MaxPrice");
        float returnPrice = rs.getFloat("ReturnedPrice");
        String receiveDate = rs.getString("ReceivedDate");

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
        consignment.setCardNumber(cardNumber);
        consignment.setCardOwner(cardOwner);
        consignment.setFromDate(fromDate);
        consignment.setToDate(toDate);
        consignment.setRaiseWebDate(raiseWebDate);
        consignment.setStatus(status);
        consignment.setPeriod(period);
        consignment.setMaxPrice(maxPrice);
        consignment.setReturnPrice(returnPrice);
        consignment.setReceivedDate(receiveDate);
        
        return consignment;
    }
}
