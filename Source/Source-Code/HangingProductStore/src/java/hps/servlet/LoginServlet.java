/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.AccountDAO;
import hps.dto.AccountDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.MessageString;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HoangNHSE61007
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String url;
            AccountDAO dao = new AccountDAO();
            AccountDTO account = dao.checkLogin(username, password);
            if (account != null) {
                account.setPhone("0" + account.getPhone().substring(3));
                if (!account.getRole().equals(GlobalVariables.ADMIN)) {
                    AccountDTO temp = dao.getRoleInfo(account.getRole(), account.getAccountID());
                    account.setRoleID(temp.getRoleID());
                    account.setFormula(temp.getFormula());
                }
                HttpSession session = request.getSession();
                session.setAttribute("ACCOUNT", account);
                if (account.getRole().equals(GlobalVariables.STORE_OWNER)) {
                    response.sendRedirect(request.getContextPath() + "/ConsignmentRequestReceive");
                    return;
                } else if (account.getRole().equals(GlobalVariables.ADMIN)) {
                    response.sendRedirect("ViewAccountServlet");
                    return;
                } else {
                    url = GlobalVariables.HOME_SERVLET;
                }
            } else {
                request.setAttribute("ERR", MessageString.loginFail);
                url = "login.jsp";
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
