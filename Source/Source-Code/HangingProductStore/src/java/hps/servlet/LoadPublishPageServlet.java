/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.CategoryDAO;
import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.CategoryDTO;
import hps.dto.ProductDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tien Dan
 */
@WebServlet(name = "LoadPublishPageServlet", urlPatterns = {"/LoadPublishPageServlet"})
public class LoadPublishPageServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(false);
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            String url = "";
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                String temp_productID = request.getParameter("productID");
                int productID;
                if (temp_productID != null) {
                    productID = Integer.parseInt(temp_productID);

                } else {
                    productID = Integer.parseInt((String) request.getAttribute("productID"));
                }
                String imageName = (String) request.getAttribute("fileName");
                DanqtDAO dao = new DanqtDAO();
                CategoryDAO cateDao = new CategoryDAO();
                List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                ProductDTO product = dao.getProductByID(productID);
                String categoryName = cateDao.getCategoryName(product.getCategoryID());
                List<CategoryDTO> sameLevelCat = cateDao.getCatSameLevel(product.getParentCategoryID());
                request.setAttribute("imageName", imageName);
                request.setAttribute("productCat", categoryName);
                request.setAttribute("sameLevelCat", sameLevelCat);
                request.setAttribute("product", product);
                request.setAttribute("parentCat", parentCategories);
                url = GlobalVariables.PUBLISH_PAGE;
            }
            request.getRequestDispatcher(url).forward(request, response);
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
