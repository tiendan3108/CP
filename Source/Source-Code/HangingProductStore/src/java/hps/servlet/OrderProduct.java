/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.OrderDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.MessageString;
import java.io.IOException;
import java.io.PrintWriter;
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
            AccountDTO user = null;
            if (session != null) {
                user = (AccountDTO) session.getAttribute("ACCOUNT");
            }
            String url = "";
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                DanqtDAO dao = new DanqtDAO();
                String orderID = request.getParameter("txtOrderID");
                JavaUltilities ultil = new JavaUltilities();
                List<OrderDTO> listCustomer = null;
                String action = request.getParameter("btnAction");
                if (action.equals("order")) {
                    String temp_sellingPrice = request.getParameter("txtSellingPrice");
                    float sellingPrice = Float.parseFloat(temp_sellingPrice) * 1000;
                    String consignmentID = dao.getConsignmentIDByOrderID(orderID);
                    AccountDTO consignor = dao.getConsignorInforByOrderID(orderID);
                    listCustomer = dao.getListOrderedCustomer(orderID, true);
                    dao.changeProductStatus(orderID, sellingPrice);
                    if (consignor.getPhone() != null) {
                        try {
                            ultil.sendSMS(MessageString.soldProductSMS(consignmentID, user.getFullName()), consignor.getPhone());
                        } catch (TwilioRestException ex) {
                            Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (Exception ex) {
                            Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if (consignor.getEmail() != null) {
                        ultil.sendEmail(consignor.getEmail(), MessageString.Subject(), MessageString.soldProductEmail(consignor.getFullName(), consignmentID, user.getFullName()));
                    }
                }
                if (action.equals("cancel")) {
                    dao.cancelAllOrders(orderID);
                    listCustomer = dao.getListOrderedCustomer(orderID, false);
                }
                if (action.equals("sendPrice")) {
                    String[] orderIDs = request.getParameterValues("chkboxCustomer");
                    String temp_sendPrice = request.getParameter("txtSendPrice");
                    float sendPrice = 0;
                    try {
                        sendPrice = Float.parseFloat(temp_sendPrice) * 1000;
                    } catch (Exception e) {
                    }
                    if (orderIDs.length > 0) {
                        for (String _orderID : orderIDs) {
                            String phone = dao.getCustomerInforByOrderID(_orderID, sendPrice);
                            if (phone != null) {
                                try {
                                    ultil.sendSMS(MessageString.sendPriceSMS(_orderID, sendPrice, user.getFullName()), phone);
                                } catch (TwilioRestException ex) {
                                    Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                                } catch (Exception ex) {
                                    Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                                }
                            }
                        }
                    }
                }

                if (listCustomer != null && !listCustomer.isEmpty()) {
                    for (OrderDTO order : listCustomer) {
                        if (order.getPhone() != null) {
                            try {
                                ultil.sendSMS(MessageString.cancelOrderSMS(order.getOrderID(), user.getFullName()), order.getPhone());
                            } catch (TwilioRestException ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            } catch (Exception ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        if (order.getEmail() != null) {
                            ultil.sendEmail(order.getEmail(), MessageString.Subject(), MessageString.cancelOrderEmail(order.getOrderID(), user.getFullName(), order.getFullName()));
                        }
                    }
                }

                url = GlobalVariables.MANAGERMENT_SERVLET;
                request.setAttribute("currentTab", "ordered");
            }
            if (url.equals(GlobalVariables.SESSION_TIME_OUT_PAGE)) {
                response.sendRedirect(url);
            } else {
                request.getRequestDispatcher(url).forward(request, response);
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
