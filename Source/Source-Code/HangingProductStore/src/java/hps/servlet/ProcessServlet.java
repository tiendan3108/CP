/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HoangNHSE61007
 */
public class ProcessServlet extends HttpServlet {

    private final String homeServlet = "HomeServlet";
    private final String viewProductDetailServlet = "ViewProductDetailServlet";

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
            String action = request.getParameter("action");
            switch (action) {
                case "home": {
                    RequestDispatcher rd = request.getRequestDispatcher(homeServlet);
                    rd.forward(request, response);
                    break;
                }
                case "viewDetail": {
                    RequestDispatcher rd = request.getRequestDispatcher(viewProductDetailServlet);
                    rd.forward(request, response);
                    break;
                }
                case "manage": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.MANAGERMENT_SERVLET);
                    rd.forward(request, response);
                    break;
                }
                case "searchStatus": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.SEARCH_PRODUCT_STATUS);
                    rd.forward(request, response);
                    break;
                }
                case "cancel": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.CANCEL_PRODUCT_SERVLET);
                    rd.forward(request, response);
                    break;
                }
                case "pay": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.LOAD_PAYMENT_SERVLET);
                    rd.forward(request, response);
                    break;
                }
                case "publish": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.LOAD_PUBLISH_PAGE_SERVLET);
                    rd.forward(request, response);
                    break;
                }
                case "finalPublish": {
                    RequestDispatcher rd = request.getRequestDispatcher(GlobalVariables.PUBLISH_PRODUCT_SERVLET);
                    rd.forward(request, response);
                    break;
                }
            }
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
