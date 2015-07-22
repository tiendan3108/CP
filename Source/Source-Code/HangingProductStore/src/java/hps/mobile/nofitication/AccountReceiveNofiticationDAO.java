/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mobile.nofitication;

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
 * @author HoangNHSE61007
 */
public class AccountReceiveNofiticationDAO {

    public int getNumOfProduct(String username) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int num = 0;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select COUNT(*) as num from Consignment, Account "
                    + "where Account.AccountID = ? "
                    + "And convert(varchar(10), Consignment.AppointmentDate, 102) = convert(varchar(10), getdate(), 102)";
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountReceiveNofiticationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountReceiveNofiticationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return num;
    }

    public List<AccountReceiveNotification> getAccount() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<AccountReceiveNotification> accounts = new ArrayList<AccountReceiveNotification>();
        int num = 0;
        try {
            DBUltilities db = new DBUltilities();
            con = db.makeConnection();
            String query = "select * from Account "
                    + "where [Role] = 'StoreOwner' "
                    + "And GcmID is not null ";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                AccountReceiveNotification account = new AccountReceiveNotification();
                String accountID = rs.getString("AccountID");
                String gcmID = rs.getString("GcmID");
                account.setAccountID(accountID);
                account.setGcmID(gcmID);
                accounts.add(account);
            }
            return accounts;
        } catch (SQLException ex) {
            Logger.getLogger(AccountReceiveNofiticationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(AccountReceiveNofiticationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
