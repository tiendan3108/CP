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
            ConsignmentDAO consignmentDAO = new ConsignmentDAO();
            String action = request.getParameter("btnAction");
            if (action == null) {
                action = "r_search";
            }
            
            if (action.equals("r_search")) {
                String searchValue = request.getParameter("r_searchValue");
                if(searchValue == null){
                    searchValue = "";
                }
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                
                request.setAttribute("REQUEST", c_request);
                request.setAttribute("ACCEPT", c_accept);
                request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
                
            }else if(action.equals("requestdetails")){
                String consignmentID = request.getParameter("id");
                ConsignmentDTO consignment = consignmentDAO.getConsignment(consignmentID);
                String json = new Gson().toJson(consignment);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }
            else if (action.equals("r_searchName")) {
                String term = request.getParameter("term");
                
                List<String> list = consignmentDAO.autoCompleteConsignmentByStoreOwnerIDAndProductNameAndStatus(storeOwner.getRoleID(), term, GlobalVariables.CONSIGNMENT_WAITING);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }
            else if(action.equals("r_accept")){
                String consignmentID = request.getParameter("r_consignmentID");
                consignmentDAO.updateConsignmentStatus(consignmentID, GlobalVariables.CONSIGNMENT_ACCEPTED);
                String searchValue= request.getParameter("r_searchValue");
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                
                request.setAttribute("REQUEST", c_request);
               request.setAttribute("ACCEPT", c_accept);
               request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
            }
            else if(action.equals("r_refuse")){
                String consignmentID = request.getParameter("r_consignmentID");
                consignmentDAO.updateConsignmentStatus(consignmentID, GlobalVariables.CONSIGNMENT_REFUSE);
                
                String searchValue= request.getParameter("r_searchValue");
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                request.setAttribute("REQUEST", c_request);
                request.setAttribute("ACCEPT", c_accept);
                request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
            }
            else if(action.equals("ar_search")){
                String searchValue = request.getParameter("ar_searchValue");
                if(searchValue == null){
                    searchValue = "";
                }
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                request.setAttribute("REQUEST", c_request);
                request.setAttribute("ACCEPT", c_accept);
                request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
            }
            else if (action.equals("ar_searchName")) {
                String term = request.getParameter("term");
                
                List<String> list = consignmentDAO.autoCompleteConsignmentByStoreOwnerIDAndProductNameAndStatus(storeOwner.getRoleID(), term, GlobalVariables.CONSIGNMENT_ACCEPTED);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }
            else if(action.equals("ar_accept")){
                String consignmentID = request.getParameter("ar_consignmentID");
                double maxPrice = Double.parseDouble(request.getParameter("ar_maxPrice"));
                double minPrice = Double.parseDouble(request.getParameter("ar_minPrice"));
                int productID = Integer.parseInt(request.getParameter("ar_productID"));
                consignmentDAO.updateConsignmentStatusAsReceived(consignmentID, minPrice, maxPrice, productID);
                String searchValue = request.getParameter("ar_searchValue");
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                request.setAttribute("REQUEST", c_request);
                request.setAttribute("ACCEPT", c_accept);
                request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
            }
            else if(action.equals("ar_refuse")){
                String consignmentID = request.getParameter("ar_consignmentID");
                consignmentDAO.updateConsignmentStatus(consignmentID, GlobalVariables.CONSIGNMENT_REFUSE);
                
                String searchValue= request.getParameter("ar_searchValue");
                List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_WAITING);
                List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_ACCEPTED);
                List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                request.setAttribute("REQUEST", c_request);
                request.setAttribute("ACCEPT", c_accept);
                request.setAttribute("REFUSE", c_refuse);
                request.setAttribute("CANCEL", c_cancel);
                
            }
            if(action.contains("ar_")){
                request.setAttribute("currentTab", "accepted");
            }else{
                request.setAttribute("currentTab", "request");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher(CONSIGNMENT_SITE);
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
