package hps.servlet;

import hps.blo.ConsignmentBLO;
import hps.blo.ConsignmentBLOFactory;
import hps.dto.Consignment;
import hps.dto.Customer;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Phuc Tran
 */
@WebServlet(name = "ConsignmentServlet",
        urlPatterns = {
            "/consignment",
            "/consignor"})
public class ConsignmentServlet extends HttpServlet {
    
    private static final String STORE_VIEW = "WEB-INF/jsp/view/store";
    private static final int STORE_ID = 1;
    
    private ConsignmentBLO consignmentBLO = ConsignmentBLOFactory.getDemoInstance();

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
        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        
        if (userPath.equals("/consignment")) {
            if (request.getParameter("id") != null) {
                userPath = "/consignment_detail";
                
                long id = Long.parseLong(request.getParameter("id"));
                Consignment consignment = consignmentBLO.getConsignment(id);
                consignmentBLO.makeConsignmentAsViewed(id);                
                request.setAttribute("consignment", consignment);
                
            } else if (request.getParameter("search") != null) {
                userPath = "/consignment_search";
            } else {
                List<Consignment> consignments = consignmentBLO.getConsigmentsByStore(STORE_ID);                
                request.setAttribute("consignments", consignments);  
                
                int nonViewRequest = consignmentBLO.getNonViewRequest(STORE_ID);
                session.setAttribute("nonViewRequest", nonViewRequest);              
            }
        } else if (userPath.equals("/consignor")) {
            List<Customer> consignors = consignmentBLO.getConsignorsByStore(STORE_ID);
            request.setAttribute("consignors", consignors);
        }

        String url = STORE_VIEW + userPath + ".jsp";
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        String userPath = request.getServletPath();
        
        if (userPath.equals("/consignment")) {
            if (request.getParameter("id") != null) {
                long id = Long.parseLong(request.getParameter("id"));
                if (request.getParameter("accept") != null) {
                    consignmentBLO.makeConsignmentAsAccepted(id);
                } else if (request.getParameter("refuse") != null) {
                    consignmentBLO.makeConsignmentAsRefused(id);
                }
                
                userPath = "/consignment_detail";
                
                Consignment consignment = consignmentBLO.getConsignment(id);
                consignmentBLO.makeConsignmentAsViewed(id);
                
                request.setAttribute("consignment", consignment);
            } else if (request.getParameter("search") != null) {
                
            }
        }
        
        String url = STORE_VIEW + userPath + ".jsp";
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
