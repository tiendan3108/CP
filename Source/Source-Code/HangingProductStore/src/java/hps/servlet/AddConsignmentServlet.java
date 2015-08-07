/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.CategoryDAO;
import hps.dao.ConsignmentDAO;
import hps.dao.ProductDAO;
import hps.dto.AccountDTO;
import hps.dto.CategoryDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.JavaUltilities;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Robingios
 */
@WebServlet(name = "AddConsignmentServlet", urlPatterns = {"/AddConsignment"})
public class AddConsignmentServlet extends HttpServlet {

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

            HttpSession session = request.getSession();
            String productName = "";
            String serialNumber = "";
            int categoryID = 0;
            String brand = "";
            String purchasedDate = "";
            String description = "";
            float negotiatedPrice = 0;
            String fullName = "";
            String address = "";
            String phone = "";
            String email = "";
            String paypalAccount = "";
            String paymentMethod = "";
            String searchValue = "";
            int isSpecial = 0;

            JavaUltilities ulti = new JavaUltilities();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNT");

            //tạo ID cho consigment và dùng cho product Image thêm đa dạng
            String consigmentID = ulti.randomString(10);

            //For parsing request with image
            List<FileItem> items = null;
            //for upload image from client to server
            String imagePath = "";
            //getProduct on session
            ProductDTO product = new ProductDTO();

            try {
                items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            } catch (FileUploadException e) {
                Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, e);
            }
            for (FileItem item : items) {
                if (item.isFormField()) {
                    //if item is form fie
                    switch (item.getFieldName()) {
                        case "ar_searchValue":
                            searchValue = item.getString();
                            break;
                        case "txtFullName":
                            fullName = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                            break;

                        case "txtAddress":
                            address = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                            break;
                        case "txtPhone":
                            phone = item.getString();
                            if (phone.length() > 0) {
                                phone = "+84" + phone.substring(1);
                            }
                            break;
                        case "txtEmail":
                            email = item.getString();
                            break;
                        case "txtPaypalAccount":
                            paypalAccount = item.getString();
                            break;
                        case "rdPayment":
                            paymentMethod = item.getString();
                            break;
                        case "txtProductName":
                            productName = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                            break;
                        case "txtSerialNumber":
                            serialNumber = item.getString();
                            break;
                        case "txtCategoryID":
                            String category = item.getString();
                            categoryID = Integer.parseInt(category);
                            break;
                        case "txtBrand":
                            brand = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                            break;

                        case "txtDate":
                            purchasedDate = item.getString();

                            break;

                        case "txtDescription":
                            description = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                            break;
                        case "txtNegotiatedPrice":
                            String negotiate = item.getString();
                            negotiatedPrice = Float.parseFloat(negotiate) * 1000;
                            break;
                            case "txtIsSpecial":
                            String special = item.getString();
                            if(special != null){
                                isSpecial = 1;
                            }
                            break;
                        default:
                            break;
                    }
                } else {
                    try {
                        String projectPath = request.getServletContext().getRealPath("/"); // web
                        String basePath = projectPath.substring(0, projectPath.length() - 9) + "web\\assets\\image";// base path
                        String deploymentPath = projectPath + "\\assets\\image";

                        //create inputstream
                        InputStream in;

                        //getString file name
                        String filename = FilenameUtils.getName(item.getName()); // Get filename.

                        //if file is amazon url 
//                        if (filename.trim().isEmpty()) {
//
//                            filename = product.getImage().substring(product.getImage().lastIndexOf("/") + 1);
//                            URL amazonUrl = new URL(product.getImage());
//                            in = amazonUrl.openStream();
//                        } else {
                        //if file is uploaded from pc
                        in = item.getInputStream();
                        //}
                        filename = consigmentID + "_" + filename.replaceAll("[!@#$%^&*?,;/'\" ]", "_");
                        System.out.println("File name after: " + filename);

                        //item.write(file); // Write to base place
                        //item.write(file2);// write to deployment place
                        //web path                        
                            File file1 = new File((basePath + "\\" + filename).replaceAll("\\\\", "/")); // base file
                            // project path
                            File file2 = new File((deploymentPath + "\\" + filename).replaceAll("\\\\", "/"));//deployment file

                        OutputStream opsDeployment = new BufferedOutputStream(new FileOutputStream(file1));
                        OutputStream opsBase = new BufferedOutputStream(new FileOutputStream(file2));
                        for (int b; (b = in.read()) != -1;) {
                            opsDeployment.write(b);
                            opsBase.write(b);
                        }

                        imagePath = "assets\\image\\" + filename;

                        opsDeployment.close();
                        opsBase.close();
                        in.close();
                    } catch (Exception ex) {
                        System.out.println("Cannot upload image");
                        Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
            }
            // add Purchased date from step1 if user set it

            product.setName(productName);
            product.setSerialNumber(serialNumber);
            product.setCategoryID(categoryID);
            product.setBrand(brand);
            product.setPurchasedDate(purchasedDate);
            product.setDescription(description);
            if (!purchasedDate.isEmpty()) {
                product.setPurchasedDate(formatDate(product.getPurchasedDate()));
            }

            product.setImage(imagePath);
            product.setProductStatusID(2);
            product.setIsSpecial(isSpecial);
            
            ProductDAO productDAO = new ProductDAO();
            ConsignmentDAO consignmentDAO = new ConsignmentDAO();
            int productID = productDAO.addProduct(product);
            if (productID > 0) {
                int memberID = 5;
                int storeOwnerID = account.getRoleID();
                float minPrice = 0;
                float maxPrice = 0;
                Date date = new Date();
                DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                String currentDate = dateFormat.format(date);

                if (paymentMethod.equals("direct")) {
                    paypalAccount = "";
                }
                ConsignmentDTO consignment = new ConsignmentDTO(consigmentID, productID, memberID, storeOwnerID, fullName,
                        address, phone, email, paypalAccount, currentDate, currentDate, 30, minPrice, maxPrice, currentDate, 5);
                consignment.setReviewProductDate(currentDate);
                consignment.setNegotiatedPrice(negotiatedPrice);
                consignment.setDeliveryMethod(0);
                boolean result = consignmentDAO.addConsigment(consignment);
                if (result) {
                    CategoryDAO categoryDAO = new CategoryDAO();

                    List<ConsignmentDTO> c_accept = consignmentDAO.getListAcceptedRequestByStoreOwnerIDDeliveryMethod(account.getRoleID(), 0);

                    //request.setAttribute("REQUEST", c_request);
                    request.setAttribute("ACCEPT", c_accept);
//                    request.setAttribute("REFUSE", c_refuse);
//                    request.setAttribute("CANCEL", c_cancel);

                    List<CategoryDTO> parentCategories = categoryDAO.getParentCategory();
                    List<CategoryDTO> category = categoryDAO.getAllCategory();
                    request.setAttribute("FCATE", parentCategories);
                    request.setAttribute("CATEGORY", category);

                    request.setAttribute("currentTab", "accepted");

                    RequestDispatcher rd = request.getRequestDispatcher("manageRequest.jsp");
                    rd.forward(request, response);
                }

            }

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

    private String formatDate(String date) {
        try {
            DateFormat format1 = new SimpleDateFormat("dd-MM-yyyy");
            DateFormat format2 = new SimpleDateFormat("MM/dd/yyyy");
            Date datetime = format1.parse(date);
            return format2.format(datetime);
        } catch (ParseException ex) {
            Logger.getLogger(AddConsignmentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
