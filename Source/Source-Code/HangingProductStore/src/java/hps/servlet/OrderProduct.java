/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.AccountDAO;
import hps.dao.ConsignmentDAO;
import hps.dao.OrderDAO;
import hps.dao.ProductDAO;
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
                boolean flag = false;
                ProductDAO productDAO = new ProductDAO();
                AccountDAO accountDAO = new AccountDAO();
                ConsignmentDAO consignmentDAO = new ConsignmentDAO();
                OrderDAO orderDAO = new OrderDAO();
                String orderID = request.getParameter("txtOrderID");
                JavaUltilities ultil = new JavaUltilities();
                List<OrderDTO> listCustomer = null;
                boolean isValid = false;
                String action = request.getParameter("btnAction");
                if (action.equals("order")) {
                    String temp_sellingPrice = request.getParameter("txtSellingPrice");
                    float sellingPrice = 0;
                    try {
                        sellingPrice = Float.parseFloat(temp_sellingPrice) * 1000;
                        isValid = true;
                    } catch (Exception e) {
                        isValid = false;
                    }
                    if (isValid) {
                        String consignmentID = consignmentDAO.getConsignmentIDByOrderID(orderID);
                        AccountDTO consignor = accountDAO.getConsignorInforByOrderID(orderID);
                        listCustomer = orderDAO.getListOrderedCustomer(orderID, true);
                        flag = productDAO.changeProductStatus(orderID, sellingPrice);
                        if (consignor.getPhone() != null && !consignor.getPhone().equals("")) {
                            try {
                                ultil.sendSMS(MessageString.soldProductSMS(consignmentID, user.getFullName()), consignor.getPhone());
                            } catch (TwilioRestException ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            } catch (Exception ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        if (consignor.getEmail() != null && !consignor.getEmail().equals("")) {
                            ultil.sendEmail(consignor.getEmail(), MessageString.Subject(), MessageString.soldProductEmail(consignor.getFullName(), consignmentID, user.getFullName()));
                        }
                    }
                }
                if (action.equals("cancel")) {
                    flag = orderDAO.cancelAllOrders(orderID);
                    listCustomer = orderDAO.getListOrderedCustomer(orderID, false);
                }
                if (action.equals("sendPrice")) {
                    String[] orderIDs = request.getParameterValues("chkboxCustomer");
                    String temp_sendPrice = request.getParameter("txtSendPrice");
                    int sendPrice = 0;
                    try {
                        sendPrice = Integer.parseInt(temp_sendPrice);
                        isValid = true;
                    } catch (Exception e) {
                        isValid = false;
                    }
                    if (orderIDs !=null && orderIDs.length > 0 && isValid) {
                        for (String _orderID : orderIDs) {
                            String phone = orderDAO.getCustomerInforByOrderID(_orderID, sendPrice);
                            if (phone != null && !phone.equals("")) {
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
                        if (order.getPhone() != null && !order.getPhone().equals("")) {
                            try {
                                ultil.sendSMS(MessageString.cancelOrderSMS(order.getOrderID(), user.getFullName()), order.getPhone());
                            } catch (TwilioRestException ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            } catch (Exception ex) {
                                Logger.getLogger(OrderProduct.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        if (order.getEmail() != null && !order.getEmail().equals("")) {
                            ultil.sendEmail(order.getEmail(), MessageString.Subject(), MessageString.cancelOrderEmail(order.getOrderID(), user.getFullName(), order.getFullName()));
                        }
                    }
                }
                if (flag) {
                    url = GlobalVariables.MANAGERMENT_SERVLET + "?currentTab=ordered&status=success";
                } else {
                    url = GlobalVariables.MANAGERMENT_SERVLET + "?currentTab=ordered&status=fail";
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
