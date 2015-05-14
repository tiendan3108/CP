/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author HoangNHSE61007
 */
public class DBUltilities implements Serializable {

    public static Connection makeConnection() {
        try {
            Context context = new InitialContext();
            Context envContext = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("scriptingElement");
            Connection con = ds.getConnection();
            return con;
        } catch (NamingException ex) {
            Logger.getLogger(DBUltilities.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBUltilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
