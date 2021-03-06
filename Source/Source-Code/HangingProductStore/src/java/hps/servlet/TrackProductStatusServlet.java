/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.AccountDAO;
import hps.dao.ConsignmentDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.MessageString;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
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
//                    consignment.setPhone("0" + consignment.getPhone().substring(3));

//                    if (consignment.getConsignmentStatusID() == 6) {
//                        System.out.println("Raise On Web Date: " + consignment.getRaiseWebDate());
//                        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
//                        Date currentDate = new Date();
//                        try {
//                            Date raiseWeb = df.parse(consignment.getRaiseWebDate());
//
//                            long diff = (currentDate.getTime() - raiseWeb.getTime());
//                            int result = (int) (diff / (24 * 60 * 60 * 1000)) - consignment.getPeriod();
//
//                            int extraPayment = 0;
//                            if (consignment.getNegotiatedPrice() >= 1000000) {
//                                extraPayment = 10 * result;
//                            } else {
//                                extraPayment = 5 * result;
//                            }
//                            request.setAttribute("extraPayment", extraPayment);
//                            request.setAttribute("overDate", result);
//                        } catch (ParseException ex) {
//                            Logger.getLogger(TrackProductStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
//                        }
//                    }
                }

                request.setAttribute("CONSIGNMENT", consignment);
                //request.setAttribute("searchValue", searchValue);
            } else if (action.equals("cancel")) {
                String consignmentID = request.getParameter("consignmentID");
                String searchValue = request.getParameter("searchValue");
                boolean result = dao.cancelConsignmentInProduct(consignmentID);
                ConsignmentDTO consignment = dao.getConsignment(consignmentID);
                if (!result) {
                    request.setAttribute("ERROR", "Không thể hủy ký gửi này");
                    System.out.println("KHONG THE XOA!!!!!");
                } else {
                    if (consignment != null) {
                        dao.populateStoreOwner(consignment);
                        if (consignment.getReviewProductDate() == null && consignment.getAppointmentDate() != null) {
                            DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                            java.util.Date currentDate = new java.util.Date();
                            String today = df.format(currentDate);
                            if (consignment.getAppointmentDate().equals(today) && consignment.getDeliveryMethod() != 1) {
                                JavaUltilities java = new JavaUltilities();
                                String noti = MessageString.titleNofitication;
                                java.sendNofitiCation(noti, MessageString.cancelProductNotification(consignment.getProduct().getName(), consignment.getConsigmentID()), AccountDAO.getGcmIDOfStoreOwnerByConsignmentID(consignment.getConsigmentID()));
                                System.out.println("Send cancel notification");
                            }
                        }
                    }
                }
                request.setAttribute("CONSIGNMENT", consignment);
                request.setAttribute("searchValue", consignmentID);

            } else if (action.equals("extend")) {
                String consignmentID = request.getParameter("consignmentID");
                dao.ExtendProduct(consignmentID, 30);

                ConsignmentDTO consignment = dao.getConsignment(consignmentID);
                if (consignment != null) {
                    dao.populateStoreOwner(consignment);

                }

                request.setAttribute("CONSIGNMENT", consignment);
                request.setAttribute("searchValue", consignmentID);
            } else if (action.equals("m_search")) {
                String searchValue = request.getParameter("searchValue");
                if (searchValue == null) {
                    searchValue = "";
                }
                List<ConsignmentDTO> list = dao.getConsignmentByMemberIDAndProductName(member.getRoleID(), searchValue);
                request.setAttribute("CONSIGNMENT", list);
            } else if (action.equals("m_cancel")) {
                String actionValue = request.getParameter("actionValue");
                String searchValue = request.getParameter("searchValue");
                boolean result = dao.cancelConsignmentInProduct(actionValue);
                ConsignmentDTO consignment = dao.getConsignment(searchValue);
                if (!result) {
                    request.setAttribute("ERROR", "Không thể hủy ký gửi này");
                    System.out.println("KHONG THE XOA!!!!!");
                } else {

                    if (consignment != null) {
                        dao.populateStoreOwner(consignment);
                        if (consignment.getReviewProductDate() == null && consignment.getAppointmentDate() != null) {
                            DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                            java.util.Date currentDate = new java.util.Date();
                            String today = df.format(currentDate);
                            if (consignment.getAppointmentDate().equals(today) && consignment.getDeliveryMethod() != 1) {
                                JavaUltilities java = new JavaUltilities();
                                String noti = MessageString.titleNofitication;
                                java.sendNofitiCation(noti, MessageString.cancelProductNotification(consignment.getProduct().getName(), consignment.getConsigmentID()), AccountDAO.getGcmIDOfStoreOwnerByConsignmentID(consignment.getConsigmentID()));
                                System.out.println("Send cancel notification");
                            }
                        }
                    }
                }
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
