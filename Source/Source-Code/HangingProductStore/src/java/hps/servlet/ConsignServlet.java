/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.AccountDAO;
import hps.dao.CategoryDAO;
import hps.dao.DuchcDAO;
import hps.dto.CategoryDTO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.ultils.AmazonProduct;
import hps.ultils.AmazonService;
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
    private static final String STEP4 = "consign_step4.jsp";
    private static final String COMPLETED = "consign_success.jsp";
    private static final String HOME = "HomeServlet";
    DuchcDAO dDAO = new DuchcDAO();

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
                session.removeAttribute("storeName");
                session.removeAttribute("trackId");
                session.removeAttribute("PRODUCT");
                session.removeAttribute("STOREOWNER");
                session.removeAttribute("CONSIGNMENT");

            }
            String url = "";
            double basicPrice = 0;
            if (action.equals("backstep1")) {

                CategoryDAO cateDao = new CategoryDAO();
                List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                List<CategoryDTO> category = cateDao.getAllCategory();
                request.setAttribute("FCATE", parentCategories);
                request.setAttribute("CATEGORY", category);

                url = STEP1;
            }
            if (action.equals("backstep2")) {
                if (session.getAttribute("AMAZONLIST") == null) {
                    url = STEP1;
                } else {
                    url = STEP2;
                }
            }
            if (action.equals("backstep3")) {
                url = STEP3;
            }

            if (action.equals("consign")) {

                
                    CategoryDAO cateDao = new CategoryDAO();
                    List<CategoryDTO> parentCategories = cateDao.getParentCategory();
                    List<CategoryDTO> category = cateDao.getAllCategory();
                    request.setAttribute("FCATE", parentCategories);
                    request.setAttribute("CATEGORY", category);
                
                url = STEP1;
            }
            if (action.equals("tostep2")) {
                String productName = request.getParameter("txtProductName").trim();
                String serialNumber = request.getParameter("txtSerialNumber").trim();
                int categoryID = Integer.parseInt(request.getParameter("txtCategory"));
                String brand = request.getParameter("txtBrand").trim();
                String date = request.getParameter("txtDate").trim();
                String description = request.getParameter("txtDescription").trim();

                ProductDTO product = new ProductDTO(productName, serialNumber, date, categoryID, brand, description, null, 1);

                //check product using serial Number
                if (serialNumber.length() > 0) {
                    AmazonService amazon = new AmazonService();
                    AmazonProduct amazonProduct = amazon.getProductByUPC(serialNumber);
                    if (amazonProduct != null) {
                        basicPrice = amazonProduct.getPrice();
                        product.setImage(amazonProduct.getImage());

                        String formatName = amazonProduct.getName().trim().replaceAll("[!@#$%^&*.?,;/]", " ");
                        if (formatName.length() > 100) {
                            product.setName(formatName.substring(0, 100));

                        } else {
                            product.setName(formatName);
                        }

                        action = "tostep3";
                    } else {

                        url = STEP1;
                        request.setAttribute("UPCERROR", "Không thể tìm thấy sản phẩm với mã số này");
                    }
                    session.removeAttribute("AMAZONLIST");
                    //action = "tostep3";

                } //check product using name 
                else {

                    List<AmazonProduct> list = dDAO.getListAmazonProduct(productName, brand, categoryID);

                    if (list != null) {
                        if (list.size() > 0) {
                            session.setAttribute("AMAZONLIST", list);
                            url = STEP2;
                        } else {
                            action = "tostep3";
                            session.removeAttribute("AMAZONLIST");
                        }

                    } else {
                        action = "tostep3";
                        session.removeAttribute("AMAZONLIST");
                    }
                }
//                request.setAttribute("backlink", url);
                session.setAttribute("PRODUCT", product);

                session.removeAttribute("ASIN");
                session.removeAttribute("BASICPRICE");
            }
            if (action.equals("tostep3")) {

                String ASIN = request.getParameter("rdAmazon");
                ProductDTO product = (ProductDTO) session.getAttribute("PRODUCT");
                if (ASIN != null) {
                    session.setAttribute("ASIN", ASIN);
                    List<AmazonProduct> list = (List<AmazonProduct>) session.getAttribute("AMAZONLIST");
                    for (AmazonProduct a : list) {
                        if (a.getASIN().equals(ASIN)) {
                            basicPrice = a.getPrice();
                            String formatName = a.getName().trim().replaceAll("[!@#$%^&*.?,;]", " ");
                            if (formatName.length() > 100) {
                                product.setName(formatName.substring(0, 100));

                            } else {
                                product.setName(formatName);
                            }
                            System.out.println("amazon name length: " + product.getName());

                            product.setImage(a.getImage());
                            session.setAttribute("PRODUCT", product);
                            break;
                        }
                    }
                } else {

                    //product.setImage(null);
                    session.setAttribute("PRODUCT", product);
                }
                basicPrice = (basicPrice * GlobalVariables.VND_CURRENCY);
                session.setAttribute("BASICPRICE", basicPrice);

                int categoryID = product.getCategoryID();
                List<AccountDTO> list = dDAO.getListStoreOwnerByCategory(categoryID, basicPrice);

                session.setAttribute("STORELIST", list);
                session.removeAttribute("STORE");

                url = STEP3;
//                request.setAttribute("backlink", url);
            }
            if (action.equals("tostep4")) {
                String storeOwnerID = request.getParameter("rdStore");

                session.setAttribute("STORE", storeOwnerID);
                url = STEP4;
//                request.setAttribute("backlink", url);
            }

            if (action.equals("login")) {
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
                        session.removeAttribute("ASIN");
                        session.removeAttribute("AMAZONLIST");

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
            }
            if (action.equals("logout")) {
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
                session.removeAttribute("ASIN");
                session.removeAttribute("AMAZONLIST");
                session.removeAttribute("CONSIGNMENT");
                session.removeAttribute("STOREOWNER");
            }
//            if (action.equals("getBrand")) {
//                String term = request.getParameter("term");
//                List<String> list = DuchcDAO.autoCompleteBrandName(term);
//                String json = new Gson().toJson(list);
//                response.setContentType("application/json;charset=UTF-8");
//                response.getWriter().write(json);
//                return;
//
//            }
            request.setAttribute("backlink", url);
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
