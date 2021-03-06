/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.OrderDAO;
import hps.dao.ProductDAO;
import hps.dto.Cart;
import hps.dto.ProductDTO;
import hps.dto.productDetailDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.MessageString;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author HoangNHSE61007
 */
@WebServlet(name = "ConfirmOrderServlet", urlPatterns = {"/ConfirmOrderServlet"})
public class ConfirmOrderServlet extends HttpServlet {

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
            String sproductId = request.getParameter("productId");
            int productID;
            try {
                productID = Integer.parseInt(sproductId);
            } catch (NumberFormatException e) {
                productID = 0;
                e.printStackTrace();
            }
            if (productID > 0) {
                ProductDAO dao = new ProductDAO();
                if (dao.checkProduct(productID)) {
                    OrderDAO orderDao = new OrderDAO();
                    long number = orderDao.getNumOfOrder(productID);
                    if (number > 0) {
                        request.setAttribute("MESS", MessageString.warningOrdered(number));
                    }
                }
                productDetailDTO product = dao.getProductAndStoreDetailByID(productID);
                product.setPhone("0"+product.getPhone().substring(3));
                request.setAttribute("DATA", product);
            }
            RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.CONFIRM_ORDER_PAGE);
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
