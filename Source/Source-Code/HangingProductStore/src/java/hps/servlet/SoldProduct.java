/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.AccountDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.MessageString;
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
@WebServlet(name = "SoldProduct", urlPatterns = {"/SoldProduct"})
public class SoldProduct extends HttpServlet {

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
                AccountDAO accountDAO = new AccountDAO();
                ProductDAO productDAO = new ProductDAO();
                String paymentMethod = request.getParameter("paymentMethod");
                String consignmentID = request.getParameter("txtConsignmentID");
                String tmp_returnPrice = request.getParameter("txtReturnPrice");
                float returnPrice = 0;
                try {
                    returnPrice = Float.parseFloat(tmp_returnPrice) * 1000;
                } catch (Exception e) {
                }
                String currentTab = request.getParameter("currentTab");
                if (returnPrice > 0) {
                    boolean flag = productDAO.soldProduct(consignmentID, returnPrice);
                    if (flag) {
                        url = GlobalVariables.MANAGE_SOLD_PRODUCT_SERVLET + "?status=success#" + currentTab;
                    } else {
                        url = GlobalVariables.MANAGE_SOLD_PRODUCT_SERVLET + "?status=fail#" + currentTab;
                    }
                    if (paymentMethod != null && paymentMethod.equals("paypal")) {
                        JavaUltilities ultil = new JavaUltilities();
                        AccountDTO consignor = accountDAO.getConsignorInforByConsignmentID(consignmentID);
                        if (consignor.getPhone() != null) {
                            try {
                                ultil.sendSMS(MessageString.notifyConsignorSMS(consignmentID, user.getFullName()), consignor.getPhone());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        if (consignor.getEmail() != null) {
                            ultil.sendEmail(consignor.getEmail(), MessageString.Subject(), MessageString.notifyConsignorEmail(consignmentID, user.getFullName(), consignor.getFullName()));
                        }
                    }
                } else {
                    url = GlobalVariables.MANAGE_SOLD_PRODUCT_SERVLET + "?status=fail#" + currentTab;
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
