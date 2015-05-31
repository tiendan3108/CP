package hps.servlet;

import hps.blo.ConsignmentBLO;
import hps.blo.ConsignmentBLOFactory;
import hps.dto.Alert;
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
    private static final String CONSIGNMENT_SEARCH = "/consignment_search";
    private static final String CONSIGNMENT = "/consignment";
    private static final String CONSIGNMENT_REQUEST = "/consignment_request";
    private static final String CONSIGNMENT_IMPORTED = "/consignment_imported";
    private static final String CONSIGNMENT_SOLD = "/consignment_sold";
    private static final String CONSIGNMENT_DETAIL = "/consignment_detail";
    
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
        
        if (userPath.equals(CONSIGNMENT)) {
            if (request.getParameter("id") != null) {
                userPath = CONSIGNMENT_DETAIL;
                
                long id = Long.parseLong(request.getParameter("id"));
                Consignment consignment = consignmentBLO.getConsignment(id);
                consignmentBLO.makeConsignmentAsViewed(id);                
                request.setAttribute("consignment", consignment);
                
                int nonViewRequest = consignmentBLO.getNonViewRequest(STORE_ID);
                session.setAttribute("nonViewRequest", nonViewRequest);   
                
            } else if (request.getParameter("search") != null) {
                userPath = CONSIGNMENT_SEARCH;          
                
            } else if (request.getParameter("imported") != null) {
                userPath = CONSIGNMENT_IMPORTED;
                
                List<Consignment> consignments = consignmentBLO.getConsigmentsImported(STORE_ID);
                request.setAttribute("consignments", consignments);
                
            } else if (request.getParameter("sold") != null) {
                userPath = CONSIGNMENT_SOLD;
                
                List<Consignment> consignments = consignmentBLO.getConsigmentsSold(STORE_ID);
                request.setAttribute("consignments", consignments);
                                
            } else /*if (request.getParameter("request") != null)*/ {
                userPath = CONSIGNMENT_REQUEST;
                
                List<Consignment> consignments = consignmentBLO.getConsigmentsRequest(STORE_ID);
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
        
        if (userPath.equals(CONSIGNMENT)) {
            if (request.getParameter("id") != null) {
                long id = Long.parseLong(request.getParameter("id"));
                if (request.getParameter("accept") != null) {
                    consignmentBLO.makeConsignmentAsAccepted(id);
                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Accepted Successful!", "");
                    request.setAttribute("alert", alert);
                } else if (request.getParameter("refuse") != null) {
                    consignmentBLO.makeConsignmentAsRefused(id);
                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Refused Successful!", "");
                    request.setAttribute("alert", alert);
                } else if (request.getParameter("import") != null) {
                    consignmentBLO.makeConsignmentAsImported(id);
                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Imported Successful!", "The product was moved to Imported List.");
                    request.setAttribute("alert", alert);
                }
                
                userPath = CONSIGNMENT_DETAIL;
                
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
