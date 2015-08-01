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
import hps.dto.ConsignmentDTO;
import hps.dto.SeasonDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.ProductStatus;
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
 * @author Tien Dan
 */
@WebServlet(name = "ManageProductServlet", urlPatterns = {"/ManageProduct"})
public class LoadManageProductPageServlet extends HttpServlet {

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
            DanqtDAO dao = new DanqtDAO();
            CategoryDAO catDao = new CategoryDAO();
            HttpSession session = request.getSession(false);
            AccountDTO user = null;
            if (session != null) {
                user = (AccountDTO) session.getAttribute("ACCOUNT");
            }
            String url = "";
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {

                List<ConsignmentDTO> available = dao.getProductStatus(user.getRoleID(), ProductStatus.AVAILABLE);
                List<ConsignmentDTO> onWeb = dao.getProductStatus(user.getRoleID(), ProductStatus.ON_WEB);
                List<ConsignmentDTO> ordered = dao.getOrderedProduct(user.getRoleID(), ProductStatus.ORDERED);
                List<ConsignmentDTO> sold = dao.getProductStatus(user.getRoleID(), ProductStatus.SOLD);
                List<ConsignmentDTO> completed = dao.getProductStatus(user.getRoleID(), ProductStatus.COMPLETED);
                List<ConsignmentDTO> canceled = dao.getProductStatus(user.getRoleID(), ProductStatus.CANCEL);
                List<ConsignmentDTO> expired = dao.getExpiredProduct(user.getRoleID());
                List<CategoryDTO> parentCat = catDao.getParentCategory();
                List<CategoryDTO> allCat = catDao.getAllCategory();
                List<SeasonDTO> season = dao.getSeason();

                Object currentTab = request.getAttribute("currentTab");
                String temp_currentTab = request.getParameter("currentTab");
                String tab = "";
                if (currentTab != null) {
                    tab = (String) currentTab;
                } else if (temp_currentTab != null) {
                    tab = temp_currentTab;
                } else {
                    tab = "available";
                }

                request.setAttribute("available", available);
                request.setAttribute("onWeb", onWeb);
                request.setAttribute("ordered", ordered);
                request.setAttribute("sold", sold);
                request.setAttribute("completed", completed);
                request.setAttribute("canceled", canceled);
                request.setAttribute("expired", expired);
                request.setAttribute("currentTab", tab);
                request.setAttribute("parentCat", parentCat);
                request.setAttribute("allCat", allCat);
                request.setAttribute("season", season);
                url = GlobalVariables.MANAGERMENT_PAGE;
            }
            if (url.equals(GlobalVariables.SESSION_TIME_OUT_PAGE)) {
                response.sendRedirect(url);
            } else {
                request.getRequestDispatcher(url).forward(request, response);
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
