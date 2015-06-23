/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import java.io.IOException;
import java.io.PrintWriter;
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
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            String action = request.getParameter("btnAction");
            String url = "";
            boolean flagPaypal = true;// ko co tk paypal
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                String consignmentID = request.getParameter("txtConsignmentID");
                String tmp_returnPrice = request.getParameter("txtReturnPrice");
                String productName = request.getParameter("txtProductName");
                String subject = "[HPS] Hàng gửi mã " + consignmentID;
                float returnPrice = Float.parseFloat(tmp_returnPrice);
                DanqtDAO dao = new DanqtDAO();
                AccountDTO consignor = dao.getConsignorInforByConsignmentID(consignmentID);
                JavaUltilities ultil = new JavaUltilities();
                String message = "";
                if (consignor.getPaypalAccount() == null && consignor.getPhone() != null) {
                    message = "Sản phẩm " + productName + " với mã kí gửi " + consignmentID + " đã được bán với giá " + tmp_returnPrice + " VND."
                            + "Vui lòng tới cửa hàng " + user.getFullName() + " để nhận tiền";
                }
                if (consignor.getPaypalAccount() == null && consignor.getPhone() == null && consignor.getEmail() != null) {
                    message = "Xin chào " + consignor.getFullName() + "<br>Sản phẩm " + productName + " với mã kí gửi " + consignmentID + " đã được bán với giá " + tmp_returnPrice + " VND.</br>"
                            + "Vui lòng tới cửa hàng " + user.getFullName() + " để nhận tiền" + "</br> Trân trọng</br>" + user.getFullName();
                }
                if (consignor.getPaypalAccount() != null && consignor.getPhone() != null) {
                    flagPaypal = false;
                    message = "Sản phẩm " + productName + " với mã kí gửi " + consignmentID + " đã được bán với giá " + tmp_returnPrice + " VND."
                            + "Chúng tôi đã chuyển tiền vào tài khoản Paypal: " + consignor.getPaypalAccount() + ".";
                }
                if (consignor.getPaypalAccount() != null && consignor.getPhone() == null && consignor.getEmail() != null) {
                    flagPaypal = false;
                    message = "Xin chào " + consignor.getFullName() + "<br>Sản phẩm " + productName + " với mã kí gửi " + consignmentID + " đã được bán với giá " + tmp_returnPrice + " VND.</br>"
                            + "Chúng tôi đã chuyển tiền vào tài khoản Paypal: " + consignor.getPaypalAccount() + "." + "</br> Trân trọng</br>" + user.getFullName();
                }
                if (consignor.getPhone() != null) {
                    try {
                        ultil.sendSMS(message, "+84" + consignor.getPhone().substring(1, consignor.getPhone().length()));
                    } catch (TwilioRestException ex) {
                        Logger.getLogger(SoldProduct.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                if (consignor.getEmail() != null) {
                    ultil.sendEmail(consignor.getEmail(), subject, message);
                }
                dao.soldProduct(consignmentID, returnPrice);
                url = GlobalVariables.MANAGERMENT_SERVLET;
                request.setAttribute("currentTab", "sold");
            }
            request.getRequestDispatcher(url).forward(request, response);
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
