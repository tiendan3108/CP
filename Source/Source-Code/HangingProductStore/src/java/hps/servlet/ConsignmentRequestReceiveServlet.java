/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.CategoryDAO;
import hps.dao.ConsignmentDAO;
import hps.dao.DuchcDAO;
import hps.dto.AccountDTO;
import hps.dto.CategoryDTO;
import hps.dto.ConsignmentDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
@WebServlet(name = "ConsignmentRequestReceiveServlet", urlPatterns = {"/ConsignmentRequestReceive"})
public class ConsignmentRequestReceiveServlet extends HttpServlet {

    private static final String HOME = "HomeServlet";
    private static final String CONSIGNMENT_SITE = "manageRequest.jsp";

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
            //get ACCOUNT on session
            AccountDTO storeOwner = (AccountDTO) session.getAttribute("ACCOUNT");
            ConsignmentDAO consignmentDAO = new ConsignmentDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            String currentTab = "";
            String action = request.getParameter("btnAction");
            //hash for url
            if (action == null) {
                currentTab = "request";
            } else {
                if (action.equals("changeTab")) {
                    currentTab = request.getParameter("tab");
                } else if (action.equals("consignmentdetails")) {
                    String consignmentID = request.getParameter("id");
                    ConsignmentDTO consignment = consignmentDAO.getConsignment(consignmentID);
                //System.out.println("consignment reason: " + consignment.getReason());
                    //set session this consignment for accept or refuse action
                    //session.setAttribute("consignment_details", consignment);
                    String json = new Gson().toJson(consignment);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(json);
                    return;
                } else if (action.equals("searchBrand")) {
                    String term = request.getParameter("term");

                    List<String> list = DuchcDAO.autoCompleteBrandName(term);
                    String json = new Gson().toJson(list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(json);
                    return;
                } else if (action.equals("r_accept")) {
                    String consignmentID = request.getParameter("consignmentID");
                    String productName = request.getParameter("txtProductName");
                    String hour = request.getParameter("txtHour");

// get appointmentDate and add hour into it then format to update database
                    String appointmentDate = request.getParameter("txtReceivedDate") + " " + hour;
                    appointmentDate = formatDate(appointmentDate);

                    int categoryID = Integer.parseInt(request.getParameter("txtCategoryID"));
                    String brand = request.getParameter("txtBrand");
                    String description = request.getParameter("txtDescription");
                    int productID = Integer.parseInt(request.getParameter("productID"));

                    consignmentDAO.updateConsignmentWhenAcceptrequest(consignmentID, appointmentDate, GlobalVariables.CONSIGNMENT_ACCEPTED, productID, productName, categoryID, brand, description, 1);

                //ConsignmentDTO consignment = (ConsignmentDTO) session.getAttribute("consignment_details");
                    //send sms and email
//                if (consignment != null) {
//                    session.removeAttribute("consignment_details");
//                    String msg = "Yêu cầu ký gửi với mã số " + consignment.getConsigmentID() + " của bạn đã được chấp nhận.\n "
//                            + "Cửa hàng sẽ đến nhận hàng từ " + consignment.getFromDate() + " đến ngày " + consignment.getToDate() + ".";
//                    JavaUltilities java = new JavaUltilities();
//                    if (consignment.getPhone() != null && consignment.getPhone().length() > 0) {
//
//                        try {
//                            java.sendSMS(msg, consignment.getPhone());
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send sms accept consignment request.");
//                            e.printStackTrace();
//                        }
//                    }
//                    
//                    if(consignment.getEmail() != null && consignment.getEmail().length() > 0){
//                        try {
//                            java.sendEmail(consignment.getEmail(), "[HPS] Chấp nhận yêu cầu ký gửi", msg);
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send email accept consignment request.");
//                            e.printStackTrace();
//                        }
//                    }
//            }
                    currentTab = "request";

                } else if (action.equals("r_refuse")) {
                    String consignmentID = request.getParameter("r_consignmentID");
                    String reason = request.getParameter("r_reason");
                    consignmentDAO.updateConsignmentStatusWhenRefuseRequest(consignmentID, GlobalVariables.CONSIGNMENT_REFUSE, reason);

//send sms and email
//                ConsignmentDTO consignment = (ConsignmentDTO) session.getAttribute("consignment_details");
//                if (consignment != null) {
//                    session.removeAttribute("consignment_details");
//                    String msg = "Yêu cầu ký gửi với mã số " + consignment.getConsigmentID() + " của bạn đã bị từ chối. ";
//                    JavaUltilities java = new JavaUltilities();
//                    
//                    
//                    if (consignment.getPhone() != null && consignment.getPhone().length() > 0) {
//
//                        try {
//                            java.sendSMS(msg, consignment.getPhone());
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send sms refuse consignment request.");
//                            e.printStackTrace();
//                        }
//                    }
//                    if(consignment.getEmail() != null && consignment.getEmail().length() > 0){
//                        try {
//                            java.sendEmail(consignment.getEmail(), "[HPS] Hủy yêu cầu ký gửi", msg);
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send email refuse consignment request.");
//                            e.printStackTrace();
//                        }
//                    }
//
//                }
                    currentTab = "request";

                } else if (action.equals("ar_accept")) {
                    //String consignmentID = request.getParameter("ar_consignmentID");
//                double maxPrice = Double.parseDouble(request.getParameter("ar_maxPrice"));
//                double minPrice = Double.parseDouble(request.getParameter("ar_minPrice"));
//                int productID = Integer.parseInt(request.getParameter("ar_productID"));
//                consignmentDAO.updateConsignmentStatusAsReceived(consignmentID, minPrice, maxPrice, productID);

                    String consignmentID = request.getParameter("consignmentID");
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    String productName = request.getParameter("txtProductName");
                    int categoryID = Integer.parseInt(request.getParameter("txtCategoryID"));
                    String brand = request.getParameter("txtBrand");
                    String description = request.getParameter("txtDescription");
                    float negotiatedPrice = Float.parseFloat(request.getParameter("txtNegotiatedPrice")) * 1000;

//                Date date = new Date();
//                DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
//                String receivedDate = dateFormat.format(date);
                    //consignmentDAO.updateConsignmentWhenAcceptProduct(consignmentID, negotiatedPrice, receivedDate, GlobalVariables.CONSIGNMENT_RECEIVED, productID, productName, categoryID, brand, description, 2);
                    consignmentDAO.updateConsignmentWhenAcceptProduct(consignmentID, negotiatedPrice, GlobalVariables.CONSIGNMENT_RECEIVED, productID, productName, categoryID, brand, description, 2);

                //ConsignmentDTO consignment = (ConsignmentDTO) session.getAttribute("consignment_details");
                    //send sms and email
//                if (consignment != null) {
//                    session.removeAttribute("consignment_details");
//                    String msg = "Sản phẩm với mã số " + consignment.getConsigmentID() + " của bạn đã được nhận.";
//                    JavaUltilities java = new JavaUltilities();
//                    
//                    
//                    if (consignment.getPhone() != null && consignment.getPhone().length() > 0) {
//
//                        try {
//                            java.sendSMS(msg, consignment.getPhone());
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send sms accept product.");
//                            e.printStackTrace();
//                        }
//                    }
//                    if(consignment.getEmail() != null && consignment.getEmail().length() > 0){
//                        try {
//                            java.sendEmail(consignment.getEmail(), "[HPS] Nhận hàng ký gửi", msg);
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send email accept product.");
//                            e.printStackTrace();
//                        }
//                    }
//
//                }
                    //String searchValue = request.getParameter("ar_searchValue");
                    //List<ConsignmentDTO> c_request = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_WAITING);
                    //List<ConsignmentDTO> c_accept = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), searchValue, GlobalVariables.CONSIGNMENT_ACCEPTED);
                    //List<ConsignmentDTO> c_refuse = consignmentDAO.findConsignmentByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                    //List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                    //request.setAttribute("REQUEST", c_request);
                    //request.setAttribute("ACCEPT", c_accept);
                    //request.setAttribute("REFUSE", c_refuse);
                    //request.setAttribute("CANCEL", c_cancel);
                    currentTab = "accepted";

                } else if (action.equals("ar_refuse")) {
                    String consignmentID = request.getParameter("ar_consignmentID");
                    String reason = request.getParameter("ar_reason");
                    System.out.println("reason: " + reason);
                    consignmentDAO.updateConsignmentStatusWhenRefuseProduct(consignmentID, GlobalVariables.CONSIGNMENT_REFUSE, reason);

                //ConsignmentDTO consignment = (ConsignmentDTO) session.getAttribute("consignment_details");
                    //send sms and email
//                if (consignment != null) {
//                    session.removeAttribute("consignment_details");
//                    String msg = "Sản phẩm với mã số " + consignment.getConsigmentID() + " của bạn đã bị từ chối.";
//                    JavaUltilities java = new JavaUltilities();
//                    if (consignment.getPhone() != null && consignment.getPhone().length() > 0) {
//
//                        try {
//                            java.sendSMS(msg, consignment.getPhone());
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send sms refuse product.");
//                            e.printStackTrace();
//                        }
//                    }
//                    if (consignment.getEmail() != null && consignment.getEmail().length() > 0) {
//                        try {
//                            java.sendEmail(consignment.getEmail(), "[HPS] Từ chối hàng ký gửi", msg);
//                        } catch (Exception e) {
//                            System.out.println("CANNOT send email refuse.");
//                            e.printStackTrace();
//                        }
//                    }
//
//                }
                    String searchValue = request.getParameter("ar_searchValue");

                    currentTab = "accepted";

                }
            }

            if (currentTab.equals("request")) {
                List<ConsignmentDTO> c_request = consignmentDAO.findRequestByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_WAITING);
                request.setAttribute("REQUEST", c_request);
            } else if (currentTab.equals("accepted")) {
                List<ConsignmentDTO> c_accept = consignmentDAO.findRequestByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_ACCEPTED);
                request.setAttribute("ACCEPT", c_accept);
            } else if (currentTab.equals("refuse")) {
                List<ConsignmentDTO> c_refuse = consignmentDAO.findRequestByStoreOwnerIDProductNameAndStatus(storeOwner.getRoleID(), "", GlobalVariables.CONSIGNMENT_REFUSE);
                request.setAttribute("REFUSE", c_refuse);

            } else if (currentTab.equals("cancel")) {
                List<ConsignmentDTO> c_cancel = consignmentDAO.getCanceledConsignmentByStoreOwnerID(storeOwner.getRoleID());
                request.setAttribute("CANCEL", c_cancel);
            }

            request.setAttribute("currentTab", currentTab);

            List<CategoryDTO> parentCategories = categoryDAO.getParentCategory();
            List<CategoryDTO> category = categoryDAO.getAllCategory();
            request.setAttribute("FCATE", parentCategories);
            request.setAttribute("CATEGORY", category);

            RequestDispatcher rd = request.getRequestDispatcher(CONSIGNMENT_SITE);
            rd.forward(request, response);
        }
    }

    private String formatDate(String date) {
        try {
            DateFormat format1 = new SimpleDateFormat("dd-MM-yyyy hh:mm aa");
            DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date datetime = format1.parse(date);
            return format2.format(datetime);
        } catch (ParseException ex) {
            Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
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
