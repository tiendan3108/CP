/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.ConsignmentDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.AmazonProduct;
import hps.ultils.AmazonService;
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
@WebServlet(name = "LoadExpiredProduct", urlPatterns = {"/LoadExpiredProduct"})
public class LoadExpiredProduct extends HttpServlet {

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
            request.setCharacterEncoding("UTF-8");
            String consignmentID = request.getParameter("consignmentID");
            ConsignmentDAO consignmentDAO = new ConsignmentDAO();
            ConsignmentDTO infor = consignmentDAO.getInforForExpiredPage(consignmentID);
            ProductDTO temp = infor.getProduct();
            AmazonService service = new AmazonService();
            float price = 0;
            int quantity = 0;
            List<AmazonProduct> amazonProduct = service.getProduct(temp.getName(), temp.getBrand(), temp.getCategoryName());
            if (amazonProduct != null && !amazonProduct.isEmpty()) {
                System.out.println("we have " + amazonProduct.size());
                for (AmazonProduct item : amazonProduct) {
                    price += item.getPrice();
                    quantity++;
                }
                price = price / quantity;
                float minprice = (float) ((price * 60 / 100) * (1 - 0.1)) * 22;
                float maxprice = (float) ((price * 60 / 100) * (1 + 0.1)) * 22;
                infor.setMinPrice(minprice);
                infor.setMaxPrice(maxprice);
            } else {
                System.out.println("we have nothing");
            }
            String json = new Gson().toJson(infor);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(json);
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
