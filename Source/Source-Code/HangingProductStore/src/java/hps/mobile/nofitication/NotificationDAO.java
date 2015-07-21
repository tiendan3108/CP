/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile.nofitication;

import hps.ultils.DBUltilities;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HoangNHSE61007
 */
public class NotificationDAO {
    public void insertToken(NotificationDTO noti){
        Connection con = null;
        PreparedStatement stm = null;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "update Account "
                    + "Set GcmID = ? "
                    + "where AccountID = ?";
            stm = con.prepareStatement(query);
            stm.setString(1, noti.getToken());
            stm.setString(2, noti.getAccountID());
            stm.executeUpdate();
            return;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return;
    }
}
