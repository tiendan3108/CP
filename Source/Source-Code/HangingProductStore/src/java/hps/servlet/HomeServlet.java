/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.CategoryDAO;
import hps.dao.ConsignmentDAO;
import hps.dao.ProductDAO;
import hps.dto.CategoryDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.Season;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HoangNHSE61007
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/HomeServlet"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date newDate = new Date();
            String year = "" + (newDate.getYear() + 1900);
            String sd1 = year + "-01-23";
            String sd2 = year + "-06-21";
            String sd3 = year + "-09-23";
            String sd4 = year + "-12-22";
            String sd5 = year + "-12-31";
            String sd6 = year + "-01-01";
            Date d1 = df.parse(sd1);
            Date d2 = df.parse(sd2);
            Date d3 = df.parse(sd3);
            Date d4 = df.parse(sd4);
            Date d5 = df.parse(sd5);
            Date d6 = df.parse(sd6);
            int season = 0;
            if (newDate.after(d1) && newDate.before(d2)) {
                season = Season.spring;
            } else if (newDate.after(d2) && newDate.before(d3)) {
                season = Season.summer;
            } else if (newDate.after(d3) && newDate.before(d4)) {
                season = Season.fall;
            } else if ((newDate.after(d4) && newDate.before(d5)) || (newDate.after(d6) && newDate.before(d1))) {
                season = Season.winter;
            }
            ProductDAO productDao = new ProductDAO();
            List<ProductDTO> data = productDao.getNewData();
            List<ProductDTO> seasonItems = productDao.getProductBySeason(season);
            CategoryDAO cateDao = new CategoryDAO();
            List<CategoryDTO> parentCategories = cateDao.getParentCategory();
            List<CategoryDTO> category = cateDao.getAllCategory();
            request.setAttribute("DATA", data);
            request.setAttribute("CATEGORY", parentCategories);
            request.setAttribute("ALLCATE", category);
            request.setAttribute("SEASONDATA", seasonItems);
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
