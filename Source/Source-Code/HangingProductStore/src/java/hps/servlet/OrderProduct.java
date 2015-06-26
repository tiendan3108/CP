/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.ProductStatus;
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
@WebServlet(name = "OrderProduct", urlPatterns = {"/OrderProduct"})
public class OrderProduct extends HttpServlet {

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
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                String tmp_productID = request.getParameter("txtProductID");
                int productID = Integer.parseInt(tmp_productID);
                String consignmentID = request.getParameter("txtConsignmentID");
                int status = 0;
                float sellingPrice = 0;
                if (action.equals("notOrder")) {
                    status = ProductStatus.ON_WEB;
                } else {
                    String temp_sellingPrice = request.getParameter("txtSellingPrice");
                    sellingPrice = Float.parseFloat(temp_sellingPrice);
                    status = ProductStatus.SOLD;
                }
                //change db and send sms, email
                {
                    DanqtDAO dao = new DanqtDAO();
                    AccountDTO consignor = dao.getCustomerInforByProductID(productID);
                    JavaUltilities ultil = new JavaUltilities();
                    String message = "";
                    if (consignor.getPhone() != null) {
                        message = "Hang ki gui voi ma " + consignmentID + " cua ban da duoc ban. Vui long lien he voi"
                                + " chu cua hang " + user.getFullName() + " de biet them chi tiet.";
                        try {
                            ultil.sendSMS(message, "+84" + consignor.getPhone().substring(1, consignor.getPhone().length()));
                        } catch (TwilioRestException ex) {
                            Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (consignor.getPhone() == null && consignor.getEmail() != null) {
                        message = "Xin chào " + consignor.getFullName() + "</br> Món hàng với mã kí gửi " + consignmentID + " của bạn đã được bán thành công.</br>"
                                + " Vui lòng liên hệ chủ cửa hàng " + user.getFullName() + " để biết thêm chi tiết" + "</br> Trân trọng</br> HPS System";
                        ultil.sendEmail(consignor.getEmail(), "[HPS] Hàng kí gửi", message);
                    }
                    dao.orderProduct(productID, status, sellingPrice);
                    url = GlobalVariables.MANAGERMENT_SERVLET;
                    request.setAttribute("currentTab", "ordered");
                }
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
