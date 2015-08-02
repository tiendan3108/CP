/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.dto.SeasonDTO;
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
 * @author Tien Dan
 */
public class SeasonDAO {

    public List<SeasonDTO> getSeason() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<SeasonDTO> result = new ArrayList();
        try {
            con = DBUltilities.makeConnection();
            String query = "SELECT * FROM Season";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("SeasonID");
                String name = rs.getString("SeasonName");
                result.add(new SeasonDTO(id, name));
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
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
}
