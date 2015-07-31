/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.StatisticDTO;
import hps.ultils.ConsignmentStatus;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
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
@WebServlet(name = "StatisticsServlet", urlPatterns = {"/Statistics"})
public class StatisticsServlet extends HttpServlet {

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
            DanqtDAO dao = new DanqtDAO();
            AccountDTO user = null;
            if (session != null) {
                user = (AccountDTO) session.getAttribute("ACCOUNT");
            }
            String url = "";
            List<StatisticDTO> resultP = null;
            List<ConsignmentDTO> resultC = null;
            float totalPrice = 0;
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                String currentTab = request.getParameter("currentTab");
                if (currentTab == null || currentTab.equals("product")) {
                    resultP = dao.getProductInforForStatisticPage(user.getRoleID());
                    if (resultP != null) {
                        for (StatisticDTO item : resultP) {
                            totalPrice += item.getRevenue();
                        }
                    }

                    Calendar calendar = Calendar.getInstance();
                    calendar.set(Calendar.DAY_OF_MONTH, 1);
                    Date firstDayOfMonth = calendar.getTime();
                    calendar.add(Calendar.MONTH, 1);
                    calendar.add(Calendar.DATE, -1);
                    Date lastDayOfMonth = calendar.getTime();
                    DateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

                    String fromDate = sdf.format(firstDayOfMonth);
                    String toDate = sdf.format(lastDayOfMonth);

                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("resultP", resultP);
                    request.setAttribute("currentTab", "product");
                    request.setAttribute("fromDate", fromDate);
                    request.setAttribute("toDate", toDate);
                } else {
                    Date tempDate = Calendar.getInstance().getTime();
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    String today = sdf.format(tempDate);

                    resultC = dao.getConsignmentInforForStatisticPage(user.getRoleID());
                    System.out.println(resultC.size());
                    request.setAttribute("resultC", resultC);
                    request.setAttribute("currentTab", "consignment");
                    request.setAttribute("fromDate", today);
                    request.setAttribute("toDate", today);
                }
                url = GlobalVariables.STATISTIC_PAGE;
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
