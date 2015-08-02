/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
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
            AccountDTO member = (AccountDTO) session.getAttribute("ACCOUNT");
            if (member != null) {
                if (member.getRole().equals(GlobalVariables.STORE_OWNER)) {
                    response.sendRedirect(STORE_OWNER_PAGE);
                    return;
                }
            }
            ConsignmentDAO dao = new ConsignmentDAO();
            String action = request.getParameter("btnAction");
            String url = "";

            if (member == null) {
                if (action == null) {
                    session.removeAttribute("CONSIGNMENT");
                    RequestDispatcher rd = request.getRequestDispatcher(GUEST_PAGE);
                    rd.forward(request, response);
                    return;
                }
            }

            if (member != null) {
                if (action == null) {
                    action = "m_search";
                }
            }

            if (action.equals("search")) {
                String searchValue = request.getParameter("searchValue");
                ConsignmentDTO consignment = dao.getConsignment(searchValue);
                if (consignment != null) {
                    dao.populateStoreOwner(consignment);
                    consignment.setPhone("0" + consignment.getPhone().substring(3));
                }

                request.setAttribute("CONSIGNMENT", consignment);
            } else if (action.equals("cancel")) {
                int consignmentID = Integer.parseInt(request.getParameter("consignmentID"));
                String searchValue = request.getParameter("searchValue");
                dao.cancelConsignmentInProduct(consignmentID);
                ConsignmentDTO consignment = dao.getConsignment(searchValue);
                request.setAttribute("CONSIGNMENT", consignment);

            } else if (action.equals("extend")) {
                String consignmentID = request.getParameter("consignmentID");
                dao.ExtendProduct(consignmentID, 30);
                ConsignmentDTO consignment = dao.getConsignment(consignmentID);
                request.setAttribute("CONSIGNMENT", consignment);
            } else if (action.equals("m_search")) {
                String searchValue = request.getParameter("searchValue");
                if (searchValue == null) {
                    searchValue = "";
                }
                List<ConsignmentDTO> list = dao.getConsignmentByMemberIDAndProductName(member.getRoleID(), searchValue);
                request.setAttribute("CONSIGNMENT", list);
            } else if (action.equals("m_cancel")) {
                int actionValue = Integer.parseInt(request.getParameter("actionValue"));
                String searchValue = request.getParameter("searchValue");
                dao.cancelConsignmentInProduct(actionValue);
                List<ConsignmentDTO> list = dao.getConsignmentByMemberIDAndProductName(member.getRoleID(), searchValue);
                request.setAttribute("CONSIGNMENT", list);

            } else if (action.equals("m_details")) {

            } else if (action.equals("m_searchName")) {
                String term = request.getParameter("term");

                List<String> list = dao.autoCompleteConsignmentByMemberIDAndProductName(member.getRoleID(), term);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            } else if (action.equals("requestdetails")) {
                String consignmentID = request.getParameter("id");
                ConsignmentDTO consignment = dao.getConsignment(consignmentID);
                dao.populateStoreOwner(consignment);
                String json = new Gson().toJson(consignment);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }

            if (action.contains("m_")) {
                url = MEMBER_PAGE;
            } else {
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
