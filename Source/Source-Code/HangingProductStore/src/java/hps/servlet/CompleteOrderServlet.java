/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.OrderDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.Cart;
import hps.ultils.JavaUltilities;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String orderID = lib.randomString(10);
            int customerID = 5;
            //System.out.println(email);
            if (phone != null) {
                phone = "+84" + phone.substring(1);
//                try {
//                    lib.sendSMS("Bạn đã đặt hàng thành công, mã đơn hàng của bạn là " + orderID + ". Sau 3 ngày nếu không tới lấy hàng, đơn hàng của bạn sẽ bị hủy", phone);
//                } catch (TwilioRestException ex) {
//                    Logger.getLogger(CompleteOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
//                }
            }
            if (email != null) {
//                String body = "<h3>Chúc Mưng Bạn</h3> Bạn đã đặt hàng thành công, mã đơn hàng của bạn là " + orderID + "<br/>" + "Sau 3 ngày nếu không tới lấy hàng, đơn hàng của bạn sẽ bị hủy";
//                lib.sendEmail(email, "Xác nhận đơn hàng", body);
            }
            HttpSession session = request.getSession();
            if (session != null) {
                AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNT");
                if (account != null) {
                    customerID = account.getRoleID();
                } else {
                    customerID = 5;
                }
            }
            OrderDAO orderDao = new OrderDAO();
            orderDao.insertOrder(orderID, customerID, email, phone);
            ProductDAO productDao = new ProductDAO();
            List<Integer> itemIDs = new ArrayList<Integer>();
            if (session != null) {
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null) {
                    itemIDs = cart.getItems();
                    for (int i = 0; i < itemIDs.size(); i++) {
                        int productID = itemIDs.get(i);
                        productDao.updateStatusToOrdered(productID, orderID);
                    }
                }
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
