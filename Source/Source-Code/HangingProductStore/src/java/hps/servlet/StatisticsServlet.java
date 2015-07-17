/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.StatisticDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import java.io.IOException;
import java.io.PrintWriter;
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
                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("resultP", resultP);
                    request.setAttribute("currentTab", "product");
                } else {
                    resultC = dao.getConsignmentInforForStatisticPage(user.getRoleID());
                    request.setAttribute("resultC", resultC);
                    request.setAttribute("currentTab", "consignment");
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
