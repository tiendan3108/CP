/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.ConsignmentDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.ProductDTO;
import hps.ultils.GlobalVariables;
import hps.ultils.JavaUltilities;
import hps.ultils.SpecialProduct;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Tien Dan
 */
@WebServlet(name = "PublishProduct", urlPatterns = {"/PublishProduct"})
public class PublishProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private boolean isImageType(String source) {
        int lastDot = source.lastIndexOf(".");
        String type = source.substring(lastDot);
        if (type.toLowerCase().equals(".jpg") || type.toLowerCase().equals(".tif") || type.toLowerCase().equals(".gif")
                || type.toLowerCase().equals(".png") || type.toLowerCase().equals(".bmp") || type.toLowerCase().equals(".jpeg")
                || type.toLowerCase().equals(".jpe") || type.toLowerCase().equals(".dib") || type.toLowerCase().equals(".jfif")) {
            return true;
        }
        return false;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            AccountDTO user = null;
            if (session != null) {
                user = (AccountDTO) session.getAttribute("ACCOUNT");
            }
            String url = "";
            String productName = null, serialNumber = null, category = null, brand = null, description = null, tmp_productID = null,
                    image = null, action = null, isSpecial = null, imagePath = null, temp_NewRatio = null, currentTab = null;
            String tempSeason = "";
            List<String> season = new ArrayList<>();
            int categoryID = 0, productID = 0, special = 2, newRatio = -1;
            List<FileItem> items = null;
            boolean isvalid = false;
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.LOGIN_PAGE;
            } else {
                ProductDAO productDAO = new ProductDAO();
                ConsignmentDAO consignmentDAO = new ConsignmentDAO();
                try {
                    items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                } catch (FileUploadException e) {
                    Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, e);
                }
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "btnAction":
                                action = item.getString();
                                break;
                            case "txtNewRatio":
                                temp_NewRatio = item.getString();
                                try {
                                    newRatio = Integer.parseInt(temp_NewRatio);
                                } catch (Exception e) {
                                }
                                break;
                            case "txtProductName":
                                productName = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtSerialNumber":
                                serialNumber = item.getString();
                                break;
                            case "txtBrand":
                                brand = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtCategory":
                                category = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                categoryID = Integer.parseInt(category);
                                break;
                            case "txtDescription":
                                description = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtProductID":
                                tmp_productID = item.getString();
                                productID = Integer.parseInt(tmp_productID);
                                break;
                            case "txtSeasonList":
                                tempSeason = item.getString();
                                break;
                            case "rdSendPrice_1":
                                isSpecial = item.getString();
                                break;
                            case "rdSendPrice_2":
                                isSpecial = item.getString();
                                break;
                            case "currentTab":
                                currentTab = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            default:
                                break;
                        }
                    } else {
                        String path = request.getServletContext().getRealPath("/");
                        String basePath = path.substring(0, path.length() - 9) + "web";
                        String filename = FilenameUtils.getName(item.getName()); // Get filename.
                        if (!filename.equals("")) {
                            JavaUltilities.deleteProductImage(path, productID);//delete deployment file
                            JavaUltilities.deleteProductImage(basePath, productID);// delete base file
                            String consignmentID = consignmentDAO.getConsignmentIDByProductID(productID);
                            filename = consignmentID + filename;
                            image = "assets\\image\\" + filename;
                            imagePath = "assets/image/" + filename;
                            File file1 = new File(path + "\\" + image); // deployment place
                            File file2 = new File(basePath + "\\" + image);//base place
                            try {
                                try (InputStream in = item.getInputStream()) {
                                    OutputStream opsBase;
                                    try (OutputStream opsDeployment = new BufferedOutputStream(new FileOutputStream(file1))) {
                                        opsBase = new BufferedOutputStream(new FileOutputStream(file2));
                                        for (int b; (b = in.read()) != -1;) {
                                            opsDeployment.write(b);
                                            opsBase.write(b);
                                        }
                                    }
                                    opsBase.close();
                                }
                            } catch (IOException ex) {
                                Logger.getLogger(PublishProduct.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }
                }
                if (action == null) {
                    url = GlobalVariables.SESSION_TIME_OUT_PAGE;
                } else {
                    if (isSpecial != null && isSpecial.equals("isSpecial")) {
                        special = SpecialProduct.NOT_SPECIAL;
                    }
                    if (isSpecial != null && isSpecial.equals("notSpecial")) {
                        special = SpecialProduct.SPECIAL;
                    }
                    ProductDTO product = new ProductDTO(productID, productName, serialNumber, brand, categoryID, description, imagePath, special, newRatio);
                    if (tempSeason.contains("1")) {
                        season.add("1");
                    }
                    if (tempSeason.contains("2")) {
                        season.add("2");
                    }
                    if (tempSeason.contains("3")) {
                        season.add("3");
                    }
                    if (tempSeason.contains("4")) {
                        season.add("4");
                    }
                    boolean isPublish = true;
                    if (!action.equals("available")) {
                        isPublish = false;
                    }
                    if (currentTab == null || currentTab.equals("all")) {
                        currentTab = "all";
                    } else {
                        if (currentTab.equals("Trên web")) {
                            currentTab = "onweb";
                        } else {
                            currentTab = "available";
                        }
                    }
                    if ((newRatio >= 0 || newRatio <= 100)) {
                        boolean flag = productDAO.publishOnWeb(product, season, isPublish);
                        if (flag) {
                            url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=success#" + currentTab;
                        } else {
                            url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=fail#" + currentTab;
                        }
                    } else {
                        url = GlobalVariables.MANAGE_AVAILABLE_PRODUCT_SERVLET + "?status=fail#" + currentTab;
                    }
                    
                }
            }
            response.sendRedirect(url);
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
