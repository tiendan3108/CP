/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tien Dan
 */
@WebServlet(name = "ExtendProduct", urlPatterns = {"/ExtendProduct"})
public class ExtendProduct extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(false);
            AccountDTO user = null;
            if (session != null) {
                user = (AccountDTO) session.getAttribute("ACCOUNT");
            }
            String url = "";
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.LOGIN_PAGE;
            } else {
                ProductDAO productDAO = new ProductDAO();
                String action = request.getParameter("btnAction");
                String tempExpiredFee = request.getParameter("txtExpiredFee");
                float expiredFee = 0;
                try {
                    expiredFee = Float.parseFloat(tempExpiredFee) * 1000;
                } catch (Exception e) {
                }
                boolean flag = true;
                String currentTab = request.getParameter("currentTab");
                if (currentTab == null) {
                    currentTab = "all";
                }else{
                    currentTab = "expired";
                }
                if (action != null && expiredFee >= 0) {
                    if (action.equals("receive")) {//nhan hang
                        String consignmentID = request.getParameter("txtConsignmentID");

                        flag = productDAO.ExtendProduct(consignmentID, expiredFee);
                    }
                    if (action.equals("extend")) {// gia han
                        String consignmentID = request.getParameter("txtConsignmentID");
                        flag = productDAO.ExtendProducts(consignmentID, expiredFee);
                    }
                    if (flag) {
                        url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=success#" + currentTab;
                    } else {
                        url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=fail#" + currentTab;
                    }
                } else {
                    url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=fail#" + currentTab;
                }
            }
            response.sendRedirect(url);
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
