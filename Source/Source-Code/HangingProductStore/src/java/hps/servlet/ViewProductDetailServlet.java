/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.AccountDAO;
import hps.dao.CategoryDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.CategoryDTO;
import hps.dto.ProductDTO;
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

/**
 *
 * @author HoangNHSE61007
 */
@WebServlet(name = "ViewProductDetailServlet", urlPatterns = {"/ViewProductDetailServlet"})
public class ViewProductDetailServlet extends HttpServlet {

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
            String sProductID = request.getParameter("productID");
            int productID;
            try {
                productID = Integer.parseInt(sProductID);
            } catch (NumberFormatException e) {
                productID = 0;
                e.printStackTrace();
            }
            ProductDAO dao = new ProductDAO();
            ProductDTO product = dao.getProductByID(productID);
            CategoryDAO cateDao = new CategoryDAO();
            List<CategoryDTO> parentCategories = cateDao.getParentCategory();
            List<CategoryDTO> category = cateDao.getAllCategory();
            AccountDAO accountDAO = new AccountDAO();
            AccountDTO storeInfo = accountDAO.getInfoByProductID(productID);
            if (product != null) {
                int categoryID = product.getCategoryID();
                List<ProductDTO> similarProducts = dao.getSimilarProduct(categoryID, productID);
                request.setAttribute("PRODUCT", product);
                request.setAttribute("SIMILARPRODUCT", similarProducts);
                request.setAttribute("STOREINFO", storeInfo);
            }
            request.setAttribute("CATEGORY", parentCategories);
            request.setAttribute("ALLCATE", category);
            RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.VIEW_DETAIL_PAGE);
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
