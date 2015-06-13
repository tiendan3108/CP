package hps.servlet;

import com.google.gson.Gson;
import com.twilio.sdk.TwilioRestException;
import hps.dao.ConsignmentDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.Alert;
import hps.dto.ConsignmentDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
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
 * @author Phuc Tran
 */
@WebServlet(name = "ConsignmentServlet",
        urlPatterns = {"/consignment"})
public class ConsignmentServlet extends HttpServlet {

    private static final String STORE_VIEW = "WEB-INF/jsp/view/store";
//    private static final int STORE_ID = 1;
    private static final String CONSIGNMENT_SEARCH = "/consignment_search";
    private static final String CONSIGNMENT = "/consignment";
    private static final String CONSIGNMENT_REQUEST = "/consignment_request";
    private static final String CONSIGNMENT_ACCEPTED = "/consignment_accepted";
    private static final String CONSIGNMENT_IMPORTED = "/consignment_imported";
    private static final String CONSIGNMENT_SOLD = "/consignment_sold";
    private static final String CONSIGNMENT_DETAIL = "/consignment_detail";

    private static final int REQUEST_WAITING = 1;
    private static final int REQUEST_REFUSED = 2;
    private static final int REQUEST_ACCEPTED = 3;

    private static final int PRODUCT_AVAILABLE = 2;

    private ConsignmentDAO consignmentDAO = new ConsignmentDAO();
    private ProductDAO productDAO = new ProductDAO();
    private JavaUltilities notification = new JavaUltilities();

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
        int storeId = user.getRoleID();

        String userPath = request.getServletPath();
        if (userPath.equals(CONSIGNMENT)) {
            if (request.getParameter("id") != null) {
                userPath = CONSIGNMENT_DETAIL;

                String id = request.getParameter("id");
                ConsignmentDTO consignment = consignmentDAO.getConsignment(id);
                request.setAttribute("consignment", consignment);

            } else if (request.getParameter("search") != null) {
                if (request.getParameter("term") != null) {
                    List<String> list = consignmentDAO.listConsignmentByProductNameAndStatus(storeId, request.getParameter("term"), REQUEST_WAITING);

                    /* Return data format: ["a", "b", "c"] */
                    String json = new Gson().toJson(list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(json);
                    
//                    PrintWriter writer = response.getWriter();
//                    writer.print("[");
//                    for (int i = 0; i < list.size(); i++) {
//                        writer.print("\"" + list.get(i) + "\"");
//                        if (i < list.size() - 1) {
//                            writer.print(",");
//                        }
//                    }
//                    writer.print("]");

                    return;
                } else {
                    userPath = CONSIGNMENT_REQUEST;

                    String searchValue = request.getParameter("searchValue");
                    List<ConsignmentDTO> consignments = consignmentDAO.findConsignmentByProductNameAndStatus(storeId, searchValue, REQUEST_WAITING);
                    request.setAttribute("consignments", consignments);
                }
            } else if (request.getParameter("advand-search") != null) {
                userPath = CONSIGNMENT_SEARCH;

            } else if (request.getParameter("imported") != null) {
                userPath = CONSIGNMENT_IMPORTED;

//                List<Consignment> consignments = consignmentBLO.getConsigmentsImported(STORE_ID);
//                request.setAttribute("consignments", consignments);
            } else if (request.getParameter("sold") != null) {
                userPath = CONSIGNMENT_SOLD;

//                List<Consignment> consignments = consignmentBLO.getConsigmentsSold(STORE_ID);
//                request.setAttribute("consignments", consignments);
            } else if (request.getParameter("accepted") != null) {
                userPath = CONSIGNMENT_ACCEPTED;
                List<ConsignmentDTO> consignments = consignmentDAO.getConsignmentByStoreAndStatus(storeId, REQUEST_ACCEPTED);
                request.setAttribute("consignments", consignments);

            } else /*if (request.getParameter("request") != null)*/ {
                userPath = CONSIGNMENT_REQUEST;
                List<ConsignmentDTO> consignments = consignmentDAO.getConsignmentByStoreAndStatus(storeId, REQUEST_WAITING);
                request.setAttribute("consignments", consignments);
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
                String consignmentId = request.getParameter("id");
                if (request.getParameter("accept") != null) {
                    consignmentDAO.makeConsignmentAsStatus(consignmentId, REQUEST_ACCEPTED);
//                    try {
//                        notification.sendSMS("Yêu cầu ký gửi " + consignmentId + " đã được chấp nhận", "+84917533644");
//                    } catch (TwilioRestException ex) {
//                        Logger.getLogger(ConsignmentServlet.class.getName()).log(Level.SEVERE, null, ex);
//                    }

                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Đã chấp nhận!", "Sản phẩm được dời qua mục Yêu Cầu Đã Duyệt.");
                    request.setAttribute("alert", alert);
                } else if (request.getParameter("refuse") != null) {
                    consignmentDAO.makeConsignmentAsStatus(consignmentId, REQUEST_REFUSED);

                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Đã từ chối!", "Sản phẩm đã được loại bỏ.");
                    request.setAttribute("alert", alert);
                } else if (request.getParameter("import") != null) {
                    double price = Double.parseDouble(request.getParameter("price"));
                    int productId = Integer.parseInt(request.getParameter("productId"));

                    consignmentDAO.makeConsignmentAsReceived(consignmentId, price);

                    productDAO.makeProductAsStatus(productId, PRODUCT_AVAILABLE);

                    Alert alert = new Alert(Alert.AlertType.SUCCESS, "Đã Nhận Hàng!", "Sản phẩm đã được dời qua Hàng Kí Gửi.");
                    request.setAttribute("alert", alert);
                }

                userPath = CONSIGNMENT_DETAIL;

                ConsignmentDTO consignment = consignmentDAO.getConsignment(consignmentId);
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
