/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.ConsignmentDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "TrackProductStatusServlet", urlPatterns = {"/TrackProductStatus"})
public class TrackProductStatusServlet extends HttpServlet {

    private static final String HOME = "HomeServlet";
    private static final String STORE_OWNER_PAGE = "ConsignmentRequestReceive";
    private static final String GUEST_PAGE = "trackProductStatus_Guest.jsp";
    private static final String MEMBER_PAGE = "trackProductStatus_Member.jsp";
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
            HttpSession session = request.getSession();
            if (session.getAttribute("ACCOUNT") != null) {
                if (((AccountDTO) session.getAttribute("ACCOUNT")).getRole() == GlobalVariables.STORE_OWNER) {
                    response.sendRedirect(STORE_OWNER_PAGE);
                    return;
                }
            }
            
            String action = request.getParameter("btnAction");
            String url = "";
            if(action == null){
                response.sendRedirect(GUEST_PAGE);
                return;
            }else if(action.equals("search")){
                String searchValue = request.getParameter("searchValue");
                ConsignmentDAO dao = new ConsignmentDAO();
                ConsignmentDTO consignment = dao.getConsignment(searchValue);
                request.setAttribute("CONSIGNMENT", consignment);
                url = GUEST_PAGE;
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
