/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import com.google.gson.Gson;
import hps.dao.CategoryDAO;
import hps.dao.DuchcDAO;
import hps.dto.CategoryDTO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.dto.StoreOwnerDTO;
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

                String productName = new String(request.getParameter("txtProductName").getBytes("iso-8859-1"), "utf-8");
                String serialNumber = request.getParameter("txtSerialNumber");
                int categoryID = Integer.parseInt(request.getParameter("txtCategory"));
                String brand = new String(request.getParameter("txtBrand").getBytes("iso-8859-1"), "utf-8");
                String date = request.getParameter("txtDate");
                //String description = request.getParameter("txtDescription");
                String description = new String(request.getParameter("txtDescription").getBytes("iso-8859-1"), "utf-8");

                ProductDTO product = new ProductDTO(productName, serialNumber, date, categoryID, brand, description, null, 1);

                session.setAttribute("PRODUCT", product);

                double basicPrice = 0;
                DuchcDAO dDAO = new DuchcDAO();
                //Thêm dữ liệu EnglishName vào Category sẽ chạy được hàm này
                basicPrice = dDAO.getBasicPrice(productName, brand, categoryID);

//                if (productName.toLowerCase().contains("gucci")) {
//                    basicPrice = 50;
//                    if (productName.toLowerCase().contains("t-shirt")) {
//                        basicPrice = 48;
//                    } else if (productName.toLowerCase().contains("pant")) {
//                        basicPrice = 49;
//                    }
//                } else if (productName.toLowerCase().contains("pt")) {
//                    basicPrice = 30;
//                    if (productName.toLowerCase().contains("t-shirt")) {
//                        basicPrice = 32;
//                    } else if (productName.toLowerCase().contains("pant")) {
//                        basicPrice = 34;
//                    }
//                } else if (productName.toLowerCase().contains("ck")) {
//                    basicPrice = 35.5;
//                    if (productName.toLowerCase().contains("t-shirt")) {
//                        basicPrice = 36;
//                    } else if (productName.toLowerCase().contains("pant")) {
//                        basicPrice = 37;
//                    }
//                } else if (productName.toLowerCase().contains("jordan")) {
//                    basicPrice = 35.5;
//                }
                session.setAttribute("BASICPRICE", basicPrice);

                List<StoreOwnerDTO> list = dDAO.getListStoreOwnerByCategory(categoryID);

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
                DuchcDAO dao = new DuchcDAO();
                AccountDTO account = dao.login(username, password);
                if (account != null) {

                    session.setAttribute("ACCOUNT", account);
                    if (account.getRole().equals(GlobalVariables.STORE_OWNER)) {
                        session.removeAttribute("PRODUCT");
                        session.removeAttribute("BASICPRICE");
                        session.removeAttribute("STORE");
                        session.removeAttribute("STORELIST");
                        session.removeAttribute("FCATE");
                        session.removeAttribute("CATEGORY");
                        response.sendRedirect(request.getContextPath() + "/consignment");
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
                //int categoryID = Integer.parseInt(request.getParameter("categotyID"));
                List<String> list = DuchcDAO.getBrandByCategoryID(7);
                String json = new Gson().toJson(list);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
                return;
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
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
