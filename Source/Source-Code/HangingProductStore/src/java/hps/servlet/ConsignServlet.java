/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.CategoryDAO;
import hps.dao.DuchcDAO;
import hps.dto.CategoryDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.dto.StoreOwnerDTO;
import hps.ultils.AmazonService;
import hps.ultils.JavaUltilities;
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
    private static final String COMPLETED = "consign_success.jsp";

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
            String action = request.getParameter("btnAction");
            if (action == null) {
                action = "consign";
            }
            String url = "";
            if (action.equals("consign")) {
                HttpSession session = request.getSession();
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
                String description = request.getParameter("txtDescription");
                String image = request.getParameter("txtImage");

                ProductDTO product = new ProductDTO(productName, serialNumber, date, categoryID, brand, description, image, 1);

                HttpSession session = request.getSession();
                session.setAttribute("PRODUCT", product);

                double basicPrice = 0;
//                AmazonService amazon = new AmazonService();
                
                if (productName.toLowerCase().contains("gucci")) {
                    basicPrice = 50;
                    if (productName.toLowerCase().contains("t-shirt")) {
                        basicPrice = 48;
                    } else if (productName.toLowerCase().contains("pant")) {
                        basicPrice = 49;
                    }
                } else if (productName.toLowerCase().contains("pt")) {
                    basicPrice = 30;
                    if (productName.toLowerCase().contains("t-shirt")) {
                        basicPrice = 32;
                    } else if (productName.toLowerCase().contains("pant")) {
                        basicPrice = 34;
                    }
                } else if (productName.toLowerCase().contains("ck")) {
                    basicPrice = 35.5;
                    if (productName.toLowerCase().contains("t-shirt")) {
                        basicPrice = 36;
                    } else if (productName.toLowerCase().contains("pant")) {
                        basicPrice = 37;
                    }
                } else if (productName.toLowerCase().contains("jordan")) {
                    basicPrice = 35.5;
                }

                session.setAttribute("BASICPRICE", basicPrice);
                DuchcDAO dDAO = new DuchcDAO();
                List<StoreOwnerDTO> list = dDAO.getListStoreOwnerByCategory(categoryID);

                session.setAttribute("STORELIST", list);
                session.removeAttribute("STORE");

                url = STEP2;
                request.setAttribute("backlink", url);
            } else if (action.equals("tostep3")) {
                String storeOwnerID = request.getParameter("rdStore");
                HttpSession session = request.getSession();
                session.setAttribute("STORE", storeOwnerID);
                url = STEP3;
                request.setAttribute("backlink", url);
            } else if (action.equals("complete")) {
                HttpSession session = request.getSession();
                if (session.getAttribute("storeName") == null || session.getAttribute("trackId") == null) {

                    String fullName = request.getParameter("txtFullName");
                    String fromDate = request.getParameter("txtFromDate");
                    String toDate = request.getParameter("txtToDate");
                    String address = request.getParameter("txtAddress");
                    String phone = request.getParameter("txtPhone");
                    String email = request.getParameter("txtEmail");
                    String paypalAccount = request.getParameter("txtPaypalAccount");

                    ProductDTO product = (ProductDTO) session.getAttribute("PRODUCT");
                    //code cứng do chưa up được ảnh
                    if (product.getImage() == null) {
                        product.setImage("./assets/image/nike_air_jordan_4_retro_2013110110_0.jpg");
                    }

                    DuchcDAO dao = new DuchcDAO();
                    //Add new product and get id of it
                    int productID = dao.addProduct(product);

                    //get memberID if session MEMBER is not null
                    int memberID = -1;
                    if (session.getAttribute("MEMBER") != null) {
                        memberID = ((AccountDTO) session.getAttribute("MEMBER")).getRoleID();
                    }
                    //get storeOwnerID from step2
                    int storeOwnerID = 0;

                    storeOwnerID = Integer.parseInt(session.getAttribute("STORE").toString());

                    double maxPrice = 0;
                    double minPrice = 0;
                    //get store de lay fomula va nam cua store
                    AccountDTO store = dao.getStoreOwnerByID(storeOwnerID);
                    if (session.getAttribute("BASICPRICE") != null) {
                        maxPrice = Double.parseDouble(session.getAttribute("BASICPRICE").toString());

                        maxPrice = (maxPrice * 60 / 100) * (1 + store.getFormula() / 100);
                        minPrice = (maxPrice * 60 / 100) * (1 - store.getFormula() / 100);

                    }
                    
                    JavaUltilities ulti = new JavaUltilities();
                    //tạo ID cho consigment
                    String consigmentID = ulti.randomString(10);

                    ConsignmentDTO consignment = new ConsignmentDTO(consigmentID, productID, memberID, storeOwnerID, fullName,
                            address, phone, email, paypalAccount, fromDate, toDate, 30, minPrice, maxPrice, "", 1);
                    boolean result = dao.addConsigment(consignment);
                    session.setAttribute("storeName", store.getFullName());
                    session.setAttribute("trackId", consigmentID);
                    session.removeAttribute("PRODUCT");
                    session.removeAttribute("BASICPRICE");
                    session.removeAttribute("STORE");
                    session.removeAttribute("STORELIST");
                    session.removeAttribute("FCATE");
                    session.removeAttribute("CATEGORY");
                }
                url = COMPLETED;
                request.setAttribute("backlink", url);

            } else if (action.equals("backstep1")) {
                HttpSession session = request.getSession();
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
            }
            else if(action.equals("login")){
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String backlink = request.getParameter("backlink");
                DuchcDAO dao = new DuchcDAO();
                AccountDTO account = dao.login(username, password);
                if(account != null){
                    HttpSession session = request.getSession();
                    session.setAttribute("MEMBER", account);
                }else{
                    request.setAttribute("err", "Tên đăng nhập hoặc mật khẩu không hợp lệ.");
                }
                url = backlink;
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
