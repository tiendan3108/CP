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
import hps.ultils.JavaUltilities;
import java.io.File;
import java.io.IOException;
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            String url = "";
            String productName = null, serialNumber = null, category = null, brand = null, description = null, tmp_productID = null, image = null;
            List<String> season = new ArrayList<>();
            int categoryID = 0, productID = 0;
            List<FileItem> items = null;
            if (user == null || !user.getRole().equals("storeOwner")) {
                url = GlobalVariables.SESSION_TIME_OUT_PAGE;
            } else {
                try {
                    items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                } catch (FileUploadException e) {
                    Logger.getLogger(ConsignServlet.class.getName()).log(Level.SEVERE, null, e);
                }
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        System.out.println(item.getFieldName());
                        switch (item.getFieldName()) {
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
                            case "chkSeason":
                                season.add(new String(item.getString().getBytes("iso-8859-1"), "utf-8"));
                                break;
                            default:
                                break;
                        }
                    } else {
                        String path = request.getServletContext().getRealPath("/");
                        String filename = FilenameUtils.getName(item.getName()); // Get filename.
                        if (filename == null || filename.equals("")) {
                        } else {
                            filename = JavaUltilities.getFileUpload(path, filename, productID);
                            image = "\\assets\\image\\" + filename;
                            System.out.println(path + image);
                            File file = new File(path + image); // Define destination file.
                            try {
                                item.write(file); // Write to destination file.
                            } catch (Exception ex) {
                                Logger.getLogger(UploadImageServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }
                }
                DanqtDAO dao = new DanqtDAO();
                ProductDTO product = new ProductDTO(productID, productName, serialNumber, brand, categoryID, description, image);
                dao.publishOnWeb(product, season);
                url = GlobalVariables.MANAGERMENT_SERVLET;
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
