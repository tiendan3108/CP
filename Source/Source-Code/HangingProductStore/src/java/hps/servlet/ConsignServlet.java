/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.CategoryDAO;
import hps.dao.DuchcDAO;
import hps.dto.CategoryDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.MemberDTO;
import hps.dto.ProductDTO;
import hps.dto.StoreOwnerDTO;
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
 * @author duchc
 */
@WebServlet(name = "ConsignServlet", urlPatterns = {"/ConsignServlet"})
public class ConsignServlet extends HttpServlet {
    private static final String STEP1 = "consign_step1.jsp";
    private static final String STEP2 = "consign_step2.jsp";
    private static final String STEP3 = "consign_step3.jsp";
    private static final String COMPLETED = "consign_success.jsp";
    
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
            if( action == null){
                action = "consign";
            }
            String url = "";
            if (action.equals("consign")) {
                CategoryDAO cateDao = new CategoryDAO();
                List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                List<CategoryDTO> category = cateDao.getAllCategory();
                HttpSession session = request.getSession();
                if(session.getAttribute("FCATE") == null){
                    session.setAttribute("FCATE", parentCategories);
                }
                if(session.getAttribute("CATEGORY") == null){
                    session.setAttribute("CATEGORY", category);
                }
                url = STEP1;
            } else if (action.equals("tostep2")) {
                String productName = request.getParameter("txtProductName");
                String serialNumber = request.getParameter("txtSerialNumber");
                int categoryID = Integer.parseInt(request.getParameter("txtCategory")); 
                String brand = request.getParameter("txtBrand");
                String date = request.getParameter("txtDate");
                String description = request.getParameter("txtDescription");
                String image = request.getParameter("txtImage");
                
                
                
                ProductDTO product = new ProductDTO(productName, serialNumber, date, categoryID, brand, description, image, 0);
//                ProductDTO product = new ProductDTO();
//                product.setName(productName);
//                product.setCategoryID(categoryID);
//                product.setPurchasedDate(date);
//                product.setDescription(description);
//                product.setImage(image);
//                product.setStatus(0); 
//                product.setSerialNumber(serialNumber);
//                product.setBrand(brand);

                HttpSession session = request.getSession();
                session.setAttribute("PRODUCT", product);

                double price = 0;
                if (productName.contains("Gucci")) {
                    price = 500000;
                }
                if (productName.contains("PT")) {
                    price = 300000;
                }

                session.setAttribute("PRICE", price);
                DuchcDAO dDAO = new DuchcDAO();
                List<StoreOwnerDTO> list = dDAO.getStoreOwnerByCategory(categoryID);

                session.setAttribute("STORELIST", list);
                session.removeAttribute("STORE");

                url = STEP2;
            } else if (action.equals("tostep3")) {
                String store = request.getParameter("rdStore");
                HttpSession session = request.getSession();
                session.setAttribute("STORE", store);
                url = STEP3;
            } else if (action.equals("complete")) {
                String fullName = request.getParameter("txtFullName");
                String fromDate = request.getParameter("txtFromDate");
                String toDate = request.getParameter("txtToDate");
                String address = request.getParameter("txtAddress");
                String phone = request.getParameter("txtPhone");
                String email = request.getParameter("txtEmail");
                String cardNumber = request.getParameter("txtCardNumber");
                String cardOwner = request.getParameter("txtCardOwner");

                HttpSession session = request.getSession();
                ProductDTO product = (ProductDTO)session.getAttribute("PRODUCT");
                
                DuchcDAO dao = new DuchcDAO();
                int productID = dao.addProduct(product);
                int memberID = -1;
                if(session.getAttribute("MEMBER") != null){
                    memberID = ((MemberDTO)session.getAttribute("MEMBER")).getMemberID();
                }
                int storeOwnerID = Integer.parseInt(session.getAttribute("STORE").toString());
                
                String consigmentID = dao.generateConsignmentID(product.getName(), fullName);
                boolean result = dao.addConsigment(consigmentID, productID, memberID, storeOwnerID, fullName, address, phone, email, cardNumber, cardOwner, fromDate, toDate);
                request.setAttribute("trackId", consigmentID );

                url = COMPLETED;
            } else if (action.equals("backstep1")) {
               url = STEP1;
            } else if (action.equals("backstep2")) {
                url = STEP2;
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                dispatcher.forward(request, response);
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
