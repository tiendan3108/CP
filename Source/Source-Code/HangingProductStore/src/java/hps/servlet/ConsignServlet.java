/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dto.ConsignmentDTO;
import hps.dto.StoreOwnerDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
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
@WebServlet(name = "ConsignServlet", urlPatterns = {"/ConsignServlet"})
public class ConsignServlet extends HttpServlet {

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
            String action = request.getParameter("btnAction");
            if(action.equals("tostep2")){
                String productName = request.getParameter("txtProductName");
                String serial = request.getParameter("txtSerialNumber");
                String category = request.getParameter("txtCategory");
                if(category == null){
                    category = "1";
                }
                String brand = request.getParameter("txtBrand");
                String date = request.getParameter("txtDate");
                String description = request.getParameter("txtDescription");
                String image = request.getParameter("txtImage");
                
//                ProductDTO product = new ProductDTO();
//                product.setName(productName);
//                product.setCategoryID(1);
//                product.setReceivedDay(date);
//                product.setDescription(description);
//                product.setImage(image);
//                product.setStatus(1); 
               
                HttpSession session = request.getSession();
//                session.setAttribute("SERIAL", serial);
//                session.setAttribute("PRODUCT", product);
                
                double price = 0;
                if(productName.contains("Gucci")){
                    price = 500000;
                }
                session.setAttribute("PRICE", price);
                List<StoreOwnerDTO> allStore = getStoreOwnerList();
                List<StoreOwnerDTO> storeOwners = new ArrayList<StoreOwnerDTO>();
                for(int i = 0; i < allStore.size(); i++){
                    if(allStore.get(i).getCategoryId() == Integer.parseInt(category)){
                        storeOwners.add(allStore.get(i));
                    }
                }
                request.setAttribute("STORELIST", storeOwners);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("consign_step2.jsp");
        dispatcher.forward(request, response);
            }
            else if(action.equals("tostep3")){
                String store = request.getParameter("rdStore");
                HttpSession session = request.getSession();
                session.setAttribute("STORE", store);
                RequestDispatcher dispatcher = request.getRequestDispatcher("consign_step3.jsp");
                dispatcher.forward(request, response);
            }
            else if(action.equals("consign")){
                String fullName = request.getParameter("txtFullName");
                String fromDate = request.getParameter("txtFromDate");
                String toDate = request.getParameter("txtToDate");
                String address = request.getParameter("txtAddress");
                String phone = request.getParameter("txtPhone");
                String email = request.getParameter("txtEmail");
                String cardNumber = request.getParameter("txtCardNumber");
                String cardOwner = request.getParameter("txtCardOwner");
                
                ConsignmentDTO consignment = new ConsignmentDTO();
                Random random = new Random();
                consignment.setProductID(random.nextInt());
                consignment.setConsignmentID("A12345");
                
                
                HttpSession session = request.getSession();
                request.setAttribute("trackId", "A12345");
                request.setAttribute("customerName", fullName);
                
                request.setAttribute("storeName", session.getAttribute("STORE"));
                session.removeAttribute("SERIAL");
//                session.removeAttribute("PRODUCT");
                
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("consign_success.jsp");
                dispatcher.forward(request, response);
            }
            else if(action.equals("backstep1")){
                RequestDispatcher dispatcher = request.getRequestDispatcher("consign_step1.jsp");
                dispatcher.forward(request, response);
            }else if(action.equals("backstep2")){
                RequestDispatcher dispatcher = request.getRequestDispatcher("consign_step2.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    public List<StoreOwnerDTO> getStoreOwnerList(){
        List<StoreOwnerDTO> storeOwners = new ArrayList<StoreOwnerDTO>();
        StoreOwnerDTO s1 = new StoreOwnerDTO("MT Store", "55, Nguyen Trai, Q.TB", 1, "Average", 10);
        StoreOwnerDTO s2 = new StoreOwnerDTO("Levi Store", "167/15, Quang Trung, Q.GV", 1, "High", 8);
        StoreOwnerDTO s3 = new StoreOwnerDTO("Alvin Store", "88, To Ky, Q.12", 2, "High", 5);
        StoreOwnerDTO s4 = new StoreOwnerDTO("Fashion Store", "286 Au Co, Q.TP", 1, "Average", 12);
        StoreOwnerDTO s5 = new StoreOwnerDTO("Marvel Store", "55 Nguyen Thai Son, Q.GV", 3, "Low", 15);
        storeOwners.add(s1);
        storeOwners.add(s2);
        storeOwners.add(s3);
        storeOwners.add(s4);
        storeOwners.add(s5);
        
        return storeOwners;
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
