/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.AccountDAO;
import hps.dao.CategoryDAO;
import hps.dao.DuchcDAO;
import hps.dto.CategoryDTO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.ultils.GlobalVariables;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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
    private static final String HOME = "HomeServlet";

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
            
            String action = request.getParameter("btnAction");
            if (action == null) {
                action = "consign";
            }
            String url = "";
            if (action.equals("consign")) {

                session.removeAttribute("storeName");
                session.removeAttribute("trackId");

                if (session.getAttribute("FCATE") == null || session.getAttribute("CATEGORY") == null) {
                    CategoryDAO cateDao = new CategoryDAO();
                    List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                    List<CategoryDTO> category = cateDao.getAllCategory();
                    session.setAttribute("FCATE", parentCategories);
                    session.setAttribute("CATEGORY", category);
                }
                url = STEP1;
                request.setAttribute("backlink", url);
            } else if (action.equals("tostep2")) {

                String productName = request.getParameter("txtProductName");
                String serialNumber = request.getParameter("txtSerialNumber");
                int categoryID = Integer.parseInt(request.getParameter("txtCategory"));
                String brand = request.getParameter("txtBrand");
                String date = request.getParameter("txtDate");
                //String description = request.getParameter("txtDescription");
                String description = request.getParameter("txtDescription");

                ProductDTO product = new ProductDTO(productName, serialNumber, date, categoryID, brand, description, null, 1);

                session.setAttribute("PRODUCT", product);

                
                DuchcDAO dDAO = new DuchcDAO();
                //Thêm dữ liệu EnglishName vào Category sẽ chạy được hàm này
                double basicPrice = dDAO.getBasicPrice(productName, brand, categoryID);
                
                
                session.setAttribute("BASICPRICE", (int)(basicPrice * GlobalVariables.VND_CURRENCY));

                List<AccountDTO> list = dDAO.getListStoreOwnerByCategory(categoryID);

                session.setAttribute("STORELIST", list);
                session.removeAttribute("STORE");

                url = STEP2;
                request.setAttribute("backlink", url);
            } else if (action.equals("tostep3")) {
                String storeOwnerID = request.getParameter("rdStore");

                session.setAttribute("STORE", storeOwnerID);
                url = STEP3;
                request.setAttribute("backlink", url);
            } else if (action.equals("backstep1")) {

                if (session.getAttribute("FCATE") == null || session.getAttribute("CATEGORY") == null) {
                    CategoryDAO cateDao = new CategoryDAO();
                    List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                    List<CategoryDTO> category = cateDao.getAllCategory();
                    session.setAttribute("FCATE", parentCategories);
                    session.setAttribute("CATEGORY", category);
                }
                url = STEP1;
                request.setAttribute("backlink", url);
            } else if (action.equals("backstep2")) {
                url = STEP2;
                request.setAttribute("backlink", url);
            } else if (action.equals("login")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String backlink = request.getParameter("backlink");
                AccountDAO dao = new AccountDAO();
                AccountDTO account = dao.checkLogin(username, password);
                if (account != null) {
                    AccountDTO temp = dao.getRoleInfo(account.getRole(), account.getAccountID());
                    account.setRoleID(temp.getRoleID());
                    account.setFormula(temp.getFormula());
                    session.setAttribute("ACCOUNT", account);
                    if (account.getRole().equals(GlobalVariables.STORE_OWNER)) {
                        session.removeAttribute("PRODUCT");
                        session.removeAttribute("BASICPRICE");
                        session.removeAttribute("STORE");
                        session.removeAttribute("STORELIST");
                        session.removeAttribute("FCATE");
                        session.removeAttribute("CATEGORY");
                        response.sendRedirect(request.getContextPath() + "/ConsignmentRequestReceive");
                        return;
                    } else {
                        request.setAttribute("backlink", backlink);
                    }
                } else {
                    request.setAttribute("err", "Tên hoặc mật khẩu không hợp lệ");
                    request.setAttribute("username", username);
                    request.setAttribute("password", password);
                    request.setAttribute("backlink", backlink);
                }
                url = backlink;
                if (backlink == "") {
                    url = HOME;
                }
            } else if (action.equals("logout")) {
                String backlink = request.getParameter("backlink");

                session.removeAttribute("ACCOUNT");
                request.setAttribute("backlink", backlink);
                url = HOME;
                session.removeAttribute("PRODUCT");
                session.removeAttribute("BASICPRICE");
                session.removeAttribute("STORE");
                session.removeAttribute("STORELIST");
                session.removeAttribute("FCATE");
                session.removeAttribute("CATEGORY");
            } else if (action.equals("getBrand")) {
                String term = request.getParameter("term");
                List<String> list = DuchcDAO.getBrand(term);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;

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

        //int categoryID = Integer.parseInt(request.getParameter("categotyID"));
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
