/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.productDAO;
import hps.dto.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

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
            String sPage = request.getParameter("page");
            String sCategoryId = request.getParameter("categoryId");
            String key = request.getParameter("key");
            String sparentCategoryId = request.getParameter("parentId");
            List<ProductDTO> products = new ArrayList<ProductDTO>();
            productDAO dao = new productDAO();
            int page;
            int categoryId;
            int parentId;
            if (sPage == null) {
                page = 1;
            } else {
                try {
                    page = Integer.parseInt(sPage);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    page = 0;
                }
            }
            if (sparentCategoryId != null) {
                try {
                    parentId = Integer.parseInt(sparentCategoryId);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    parentId = 0;
                }
                products = dao.getProductByParentCategory(parentId, page);

            } else {
                if (sCategoryId != null) {
                    if (sCategoryId.equals("all")) {
                        products = dao.getProductByName(key, page);
                    } else {
                        try {
                            categoryId = Integer.parseInt(sCategoryId);
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                            categoryId = 0;
                        }
                        if (key == null) {
                            products = dao.getProductByCategory(categoryId, page);
                        } else {
                            products = dao.getProductByCategoryAndName(categoryId, key, page);
                        }
                    }
                }
            }
            request.setAttribute("DATA", products);
            RequestDispatcher rd = request.getRequestDispatcher("product.jsp");
            rd.forward(request, response);
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
