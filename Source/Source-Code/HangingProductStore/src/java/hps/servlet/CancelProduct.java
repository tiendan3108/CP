/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.AccountDAO;
import hps.dao.ProductDAO;
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
        String tempCancelFee = request.getParameter("txtCancelFee");
        String btnaction = request.getParameter("btnAction");
        String consignmentID = request.getParameter("txtConsignmentID");
        String url = "", sms = "", email = "", subject = "[HPS] Huy bo ki gui ma " + consignmentID;
        int status = 0;
        float cancelFee = 0;
        JavaUltilities ultil = new JavaUltilities();
        ProductDAO productDAO = new ProductDAO();
        AccountDAO accountDAO = new AccountDAO();
        if (user == null || !user.getRole().equals("storeOwner")) {
            url = GlobalVariables.LOGIN_PAGE;
        } else {
            AccountDTO consignor = accountDAO.getConsignorInforByConsignmentID(consignmentID);
            // get message
            switch (btnaction) {
                case "cancel":
                    //agree cancel product
                    try {
                        cancelFee = Float.parseFloat(tempCancelFee);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    status = ProductStatus.NOT_YET_RECEIVE;
                    if (consignor.getPhone() != null && !consignor.getPhone().equals("")) {
                        sms = "Mon hang voi ma ki gui " + consignmentID + " cua ban huy thanh cong. Tien phat cua ban la " + tempCancelFee
                                + " ngan dong. Vui long lien he voi chu cua hang " + user.getFullName() + " de nhan hang va biet them chi tiet";
                        try {
                            ultil.sendSMS(sms, consignor.getPhone());
                        } catch (TwilioRestException ex) {
                            Logger.getLogger(CancelProduct.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (Exception ex) {
                            Logger.getLogger(CancelProduct.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (consignor.getEmail() != null && !consignor.getEmail().equals("")) {
                        email = "Xin chào " + consignor.getFullName() + "</br> Món hàng với mã kí gửi " + consignmentID + " của bạn đã được hủy thành công.</br> Tiền phạt cho việc hủy kí gửi là " + tempCancelFee + ".000 đồng</br>"
                                + " Vui lòng liên hệ chủ cửa hàng " + user.getFullName() + " để nhận hàng và biết thêm chi tiết" + "</br> Trân trọng</br> HPS System";
                        ultil.sendEmail(consignor.getEmail(), subject, email);
                    }
                    break;
                case "notCancel":
                    //not agree cancel product
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
                    break;
                case "receive":
                    //receive product
                    status = ProductStatus.NOT_AVAILABLE;
                    try {
                        cancelFee = Float.parseFloat(tempCancelFee);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case "refuse":
                    //refuse receive product
                    status = ProductStatus.ON_WEB;
                    break;
            }
            //update database
            boolean flag = productDAO.cancelProduct(consignmentID, status, cancelFee);
            String currentTab = request.getParameter("currentTab");
            if (currentTab != null && !currentTab.equals("all")) {
                currentTab = "requestCancel";
            }
            //change url
            if (flag) {
                url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=success#" + currentTab;
            } else {
                url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=fail#" + currentTab;
            }

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
