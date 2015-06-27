/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.OrderDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.OrderDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.MessageString;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "CompleteOrderServlet", urlPatterns = {"/CompleteOrderServlet"})
public class CompleteOrderServlet extends HttpServlet {

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
            JavaUltilities lib = new JavaUltilities();
            String sproductID = request.getParameter("productID");
            int productID = Integer.parseInt(sproductID);
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            if(!phone.isEmpty()){
                phone = "+84" + phone.substring(1);
            }           
            String fullname = request.getParameter("name");
            String address = request.getParameter("address");
            String orderID = lib.randomString(10);
            int customerID = 5;
            OrderDAO orderDao = new OrderDAO();
            ProductDAO productDao = new ProductDAO();
            HttpSession session = request.getSession();
            if (session != null) {
                AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNT");
                if (account != null) {
                    customerID = account.getRoleID();
                } else {
                    customerID = 5;
                }
            }
            if (productDao.checkProduct(productID)) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(orderID);
                order.setCustomerID(customerID);
                order.setEmail(email);
                order.setPhone(phone);
                order.setAddress(address);
                order.setFullName(fullname);
                //insert order
                orderDao.insertOrderWithMemberInfo(order);
                System.out.println("abc");
                //update product status                                  
                productDao.updateStatusToOrdered(productID, orderID);
                //send sms
                if (!phone.isEmpty()) {                   
                    try {
                        lib.sendSMS(MessageString.orderSuccessSMS(orderID), phone);
                        System.out.println("send roi" + phone);
                    } catch (TwilioRestException ex) {
                        Logger.getLogger(CompleteOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                //send email
                if (!email.isEmpty()) {
                    String body = MessageString.orderSuccessEmail(orderID);
                    lib.sendEmail(email, MessageString.confirmOrder, body);
                }
                RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.COMPLETE_ODER_PAGE);
                rd.forward(request, response);
            } else {
                request.setAttribute("ERROR", MessageString.orderFail);
                RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.HOME_SERVLET);
                rd.forward(request, response);
            }

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
