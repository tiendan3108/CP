/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import com.twilio.sdk.resource.instance.Account;
import hps.dao.ConsignmentDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Robingios
 */
@WebServlet(name = "ConsignmentRequestReceiveServlet", urlPatterns = {"/ConsignmentRequestReceive"})
public class ConsignmentRequestReceiveServlet extends HttpServlet {
    
    private static final String HOME = "HomeServlet";
    private static final String CONSIGNMENT_SITE = "consignment_request_receive.jsp";

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
            request.setCharacterEncoding("UTF8");
            HttpSession session = request.getSession();
            if (session.getAttribute("ACCOUNT") == null) {
                response.sendRedirect(HOME);
                return;
            } else {
                if (!((AccountDTO) session.getAttribute("ACCOUNT")).getRole().equals(GlobalVariables.STORE_OWNER)) {
                    response.sendRedirect(HOME);
                    return;
                }
            }
            AccountDTO storeOwner = (AccountDTO) session.getAttribute("ACCOUNT");
            String url = "";
            ConsignmentDAO consignmentDAO = new ConsignmentDAO();
            String action = request.getParameter("btnAction");
            if (action == null) {
                action = "search";
            }
            
            if (action.equals("search")) {
                String searchValue = request.getParameter("searchValue");
                if(searchValue == null){
                    searchValue = "";
                }
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_WAITING);
                //List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_ACCEPTED);
                request.setAttribute("CONSIGNMENT_REQUEST", c_request);
                //request.setAttribute("CONSIGNMENT_ACCEPT", c_accept);
                url = CONSIGNMENT_SITE;
            }
            if (action.equals("searchName")) {
                String term = request.getParameter("term");
                String status = request.getParameter("status");
                int statusID = 0;
                if (status.equals("accepted")) {
                    statusID = GlobalVariables.CONSIGNMENT_ACCEPTED;
                } else {
                    statusID = GlobalVariables.CONSIGNMENT_WAITING;
                }
                
                List<String> list = consignmentDAO.listConsignmentByProductNameAndStatus(storeOwner.getRoleID(), term, statusID);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
