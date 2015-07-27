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
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
@WebServlet(name = "CancelProduct", urlPatterns = {"/CancelProduct"})
public class CancelProduct extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        response.sendRedirect(GlobalVariables.SESSION_TIME_OUT_PAGE);
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
        HttpSession session = request.getSession(false);
        AccountDTO user = null;
        if (session != null) {
            user = (AccountDTO) session.getAttribute("ACCOUNT");
        }
        String action = request.getParameter("btnAction");
        String consignmentID = request.getParameter("txtConsignmentID");
        String url = "", sms = "", email = "", subject = "[HPS] Huy bo ki gui ma " + consignmentID;
        int status = 0;
        Date tempDate = Calendar.getInstance().getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String toDay = sdf.format(tempDate);
        JavaUltilities ultil = new JavaUltilities();
        DanqtDAO dao = new DanqtDAO();
        if (user == null || !user.getRole().equals("storeOwner")) {
            url = GlobalVariables.SESSION_TIME_OUT_PAGE;
        } else {
            AccountDTO consignor = dao.getConsignorInforByConsignmentID(consignmentID);
            // get message
            if (action.equals("cancel")) {//agree cancel product
                status = ProductStatus.COMPLETED;
            } else {//not agree cancel product
                status = ProductStatus.ON_WEB;
                if (consignor.getPhone() != null && !consignor.getPhone().equals("")) {
                    sms = "Mon hang voi ma ki gui " + consignmentID + " cua ban huy khong thanh cong."
                            + " Vui long lien he voi chu cua hang " + user.getFullName() + " de biet them chi tiet";
                    try {
                        ultil.sendSMS(sms, consignor.getPhone());
                    } catch (TwilioRestException ex) {
                        Logger.getLogger(CancelProduct.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (Exception ex) {
                        Logger.getLogger(CancelProduct.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                if (consignor.getEmail() != null && !consignor.getEmail().equals("")) {
                    email = "Xin chào " + consignor.getFullName() + "</br> Món hàng với mã kí gửi " + consignmentID + " của bạn không được hủy thành công.</br>"
                            + " Vui lòng liên hệ chủ cửa hàng " + user.getFullName() + " để biết thêm chi tiết" + "</br> Trân trọng</br> HPS System";
                    ultil.sendEmail(consignor.getEmail(), subject, email);
                }
            }
            //update database
            dao.cancelProduct(consignmentID, status);
            //change url
            url = GlobalVariables.MANAGERMENT_SERVLET + "?currentTab=canceled";
        }
        response.sendRedirect(url);
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
