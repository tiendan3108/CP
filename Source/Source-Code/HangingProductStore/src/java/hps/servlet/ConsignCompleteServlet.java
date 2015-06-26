/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.servlet;

import hps.dao.DuchcDAO;
import hps.dto.AccountDTO;
import hps.dto.ConsignmentDTO;
import hps.dto.ProductDTO;
import hps.ultils.JavaUltilities;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@WebServlet(name = "ConsignCompleteServlet", urlPatterns = {"/ConsignCompleteServlet"})
@MultipartConfig()
public class ConsignCompleteServlet extends HttpServlet {

    private static final String SAVE_DIR = "assets\\image";
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
            String url = "consign_success.jsp";
            HttpSession session = request.getSession();
            if (session.getAttribute("storeName") == null || session.getAttribute("trackId") == null) {
                String fullName = null;
                String fromDate = null;
                String toDate = null;
                String address = null;
                String phone = null;
                String email = null;
                String paypalAccount = null;
                String rdContact = "";
                String rdPayment = "";

                JavaUltilities ulti = new JavaUltilities();
                //tạo ID cho consigment và dùng cho product Image thêm đa dạng
                String consigmentID = ulti.randomString(10);

                List<FileItem> items = null;
                String imagePath = "";

                try {
                    items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                } catch (FileUploadException e) {
                    Logger.getLogger(ConsignServlet.class.getName()).log(Level.SEVERE, null, e);
                }
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "txtFullName":
                                fullName = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtFromDate":
                                fromDate = item.getString();
                                break;
                            case "txtToDate":
                                toDate = item.getString();
                                break;
                            case "txtAddress":
                                address = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtPhone":
                                phone = item.getString();
                                if (phone.length() > 0) {
                                    phone = "+84" + phone.substring(1);

                                    System.out.println(phone);
                                }
                                break;
                            case "txtEmail":
                                email = item.getString();
                                break;
                            case "txtPaypalAccount":
                                paypalAccount = item.getString();
                                break;
                            case "rdContact":
                                rdContact = item.getString();
                                break;
                            case "rdPayment":
                                rdPayment = item.getString();
                                break;
                            default:
                                break;
                        }
                    } else {
                        String path = request.getServletContext().getRealPath("") + File.separator + SAVE_DIR; //specify your path here
                        File fileSaveDir = new File(path);
                        if (!fileSaveDir.exists()) {
                            fileSaveDir.mkdir();
                        }
                        String filename = FilenameUtils.getName(item.getName()); // Get filename.
                        File file = new File(path, consigmentID + filename); // Define destination file.
                        try {
                            item.write(file); // Write to destination file.
                        } catch (Exception ex) {
                            Logger.getLogger(UploadImageServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        imagePath = "assets/image/" + consigmentID + filename;
                    }
                }

                ProductDTO product = (ProductDTO) session.getAttribute("PRODUCT");
                
                product.setImage(imagePath);

                DuchcDAO dao = new DuchcDAO();

                //Add new product and get id of it
                int productID = dao.addProduct(product);

//                dao.updateProductImage(productID, imagePath); //Du

                //get memberID if session MEMBER is not null
                int memberID = 5;
                if (session.getAttribute("ACCOUNT") != null) {
                    memberID = ((AccountDTO) session.getAttribute("ACCOUNT")).getRoleID();
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

                ConsignmentDTO consignment = new ConsignmentDTO(consigmentID, productID, memberID, storeOwnerID, fullName,
                        address, phone, email, paypalAccount, fromDate, toDate, 30, minPrice, maxPrice, "", 1);
                boolean result = dao.addConsigment(consignment);

                JavaUltilities java = new JavaUltilities();
                if (phone.length() > 0) {
                    java.sendSMS("Ban da ky gui thanh cong. Ma san pham cua ban la: " + consigmentID + ".", phone);
                }
                if (email.length() > 0) {
                    java.sendEmail(email, "Ky gui thanh cong!", "Ma san pham cua ban la: " + consigmentID);
                }

                session.setAttribute("storeName", store.getFullName());
                session.setAttribute("trackId", consigmentID);
                session.removeAttribute("PRODUCT");
                session.removeAttribute("BASICPRICE");
                session.removeAttribute("STORE");
                session.removeAttribute("STORELIST");
                session.removeAttribute("FCATE");
                session.removeAttribute("CATEGORY");

            }

            RequestDispatcher rd = request.getRequestDispatcher(COMPLETED);
            rd.forward(request, response);
            /* 
             //You need this loop if you submitted more than one file
             for (Part part : request.getParts()) {
             String fileName = extractFileName(part);
             part.write(savePath + File.separator + fileName);
             }*/
        } catch (Exception e) {
            e.printStackTrace();
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
