/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.DanqtDAO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.ultils.GlobalVariables;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author Tien Dan
 */
@WebServlet(name = "PublishOnWebServlet", urlPatterns = {"/PublishOnWebServlet"})
public class PublishOnWebServlet extends HttpServlet {

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
            HttpSession session = request.getSession(false);
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            String url = "";
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                String action = request.getParameter("btnAction");
                String imageName = request.getParameter("imageName");
                if (action.equals("cancel")) {
                    url = GlobalVariables.MANAGERMENT_SERVLET;
                    String path = request.getServletContext().getRealPath("/") + "\\assets\\image\\" + imageName;
                    File imageFile = new File(path);
                    try {
                        imageFile.delete();
                    } catch (SecurityException e) {
                        Logger.getLogger(DanqtDAO.class.getName()).log(Level.SEVERE, null, e);
                    }
                } else {
                    ProductDTO product;
                    String serialNumber = "", description = "";
                    float price = 0;
                    String temp_productID = request.getParameter("productID");
                    int productID = Integer.parseInt(temp_productID);
                    String productName = request.getParameter("productName");
                    serialNumber = request.getParameter("serialNumber");
                    String parentCat = request.getParameter("parentCat");
                    String childCat = request.getParameter("childCat");
                    String brand = request.getParameter("brand");
                    description = request.getParameter("description");
                    String image = "assets/image/" + imageName;
                    String temp_price = request.getParameter("price");
                    if (!temp_price.equals("")) {
                        price = Float.parseFloat(temp_price);
                    }
                    DanqtDAO dao = new DanqtDAO();
                    int categoryID = dao.getCategoryIDByCategoryNameAndParentCategoryName(parentCat, childCat);
                    if (imageName.equals("")) {
                        product = new ProductDTO(productID, productName, serialNumber, categoryID, brand, description, price);
                    } else {
                        product = new ProductDTO(productID, productName, serialNumber, categoryID, brand, description, image, price);
                    }
                    boolean flag = dao.publishOnWeb(product);
                    if (flag) {
                        url = GlobalVariables.SUCCESS_ACTION_PAGE;
                    } else {
                        url = GlobalVariables.SESSION_TIME_OUT_PAGE;
                    }
                }
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
