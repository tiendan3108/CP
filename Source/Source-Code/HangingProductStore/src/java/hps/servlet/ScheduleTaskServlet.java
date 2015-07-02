/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.twilio.sdk.TwilioRestException;
import hps.dao.DanqtDAO;
import hps.dao.OrderDAO;
import hps.dao.ProductDAO;
import hps.dto.ConsignmentDTO;
import hps.dto.OrderDTO;
import hps.ultils.JavaUltilities;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HoangNHSE61007
 */
public class ScheduleTaskServlet extends HttpServlet {

    public static Timer timer;

    @Override
    public void init() {
        checkOrder();
        remindConsignor();
    }

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
        }
    }

    private void checkOrder() {
        TimerTask timerTask = new TimerTask() {
            @Override
            public void run() {
                OrderDAO orderDao = new OrderDAO();
                ProductDAO productDao = new ProductDAO();
                List<OrderDTO> orders = orderDao.checkOrderExpired();
                if (orders != null) {
                    if (orders.size() > 0) {
                        for (int i = 0; i < orders.size(); i++) {
                            OrderDTO order = orders.get(i);
                            orderDao.updateOrderWhenOrderExpired(order.getOrderID());
                            productDao.updateProductWhenOrderExpired(order.getProductID());
                            System.out.println("da update");
                        }
                    }
                }
            }
        };

        //Timer timer = new Timer();
        long delay = 0;
        long intevalPeriod = 1000 * 60;//1 mins
        // schedules the task to be run in an interval
        timer.scheduleAtFixedRate(timerTask, delay, intevalPeriod);
    }

    private void remindConsignor() {
        TimerTask timerTask = new TimerTask() {
            @Override
            public void run() {
                DanqtDAO dao = new DanqtDAO();
                JavaUltilities ulti = new JavaUltilities();
                List<ConsignmentDTO> listConsignor = dao.remindConsignor();
                if (!listConsignor.isEmpty()) {
                    for (ConsignmentDTO consignor : listConsignor) {
                        if (consignor.getPhone() != null) {
                            String sms = "Mon hang voi ma ki gui " + consignor.getConsigmentID() + " cua ban da qua han ki "
                                    + "gui. Vui long lien he voi chu cua hang de nhan hang hoac gia han ki gui";
                            try {
                                ulti.sendSMS(sms, consignor.getPhone());
                            } catch (TwilioRestException ex) {
                                Logger.getLogger(ScheduleTaskServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        if (consignor.getEmail() != null) {
                            String subject = "[HPS] Hết hạn kí gửi";
                            String email = "Xin chào " + consignor.getName() + "</br>Món hàng với mã kí gửi "
                                    + consignor.getConsigmentID() + " đã quá hạn kí gửi. Vui lòng liên hệ với chủ cửa hàng"
                                    + " để nhận hàng hoặc gia hạn kí gửi.</br> Trân trọng</br> HPS System";
                            ulti.sendEmail(consignor.getEmail(), subject, email);
                        }
                        System.out.println("Send dc 1 thang");
                    }
                }
                System.out.println("Tong cong co " + listConsignor.size() + " het han");
            }
        };

        //Timer timer = new Timer();
        long delay = 0;
        long intevalPeriod = 24 * 60 * 60;//1 mins
        // schedules the task to be run in an interval
        timer.scheduleAtFixedRate(timerTask, delay, intevalPeriod);
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
