/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dao;

import hps.ultils.AmazonProduct;
import hps.ultils.AmazonService;
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
public class BrandDAO {

    public static List<String> autoCompleteBrandName(String brandName) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBUltilities.makeConnection();
            String sql = "SELECT BrandName "
                    + " FROM Brand "
                    + " WHERE BrandName LIKE ? "
                    + " ORDER BY BrandName ASC";
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + brandName + "%");

            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                result.add(rs.getString("BrandName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }
    public static List<AmazonProduct> getListAmazonProduct(String productName, String brand, int categoryID) {
        System.out.println("dang vao");
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        float basicPrice = -1;
        try {
            String englishName = "";
            con = DBUltilities.makeConnection();
            String query = "SELECT EnglishName FROM Category WHERE (CategoryID = ?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, categoryID);
            rs = stm.executeQuery();

            if (rs.next()) {
                englishName = rs.getString("EnglishName");
            }
            AmazonService amazon = new AmazonService();

            List<AmazonProduct> list = amazon.getProduct(productName, brand, englishName);

            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
