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
    private static final String STEP4 = "consign_step4.jsp";
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
            if (session.getAttribute("CONSIGNMENT") == null || session.getAttribute("STOREOWNER") == null) {
                String fullName = null;
                String fromDate = null;
                String toDate = null;
                String address = null;
                String phone = null;
                String email = null;
                String paypalAccount = null;
                String image = null;
                String rdPayment = "";

                JavaUltilities ulti = new JavaUltilities();
                //tạo ID cho consigment và dùng cho product Image thêm đa dạng
                String consigmentID = ulti.randomString(10);

                List<FileItem> items = null;
                String imagePath = "";

                try {
                    items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                } catch (FileUploadException e) {
                    Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, e);
                }
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "txtFullName":
                                fullName = new String(item.getString().getBytes("iso-8859-1"), "utf-8");
                                break;
                            case "txtFromDate":
                                fromDate = item.getString();
                                fromDate = formatDate(fromDate);

                                break;
                            case "txtToDate":
                                toDate = item.getString();
                                toDate = formatDate(toDate);

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
                                rdPayment = item.getString();
                                break;
                            case "txtImage":
                                image = item.getString();
                                break;
                            default:
                                break;
                        }
                    } else {
                        String projectPath = request.getServletContext().getRealPath("/"); // web
                        String basePath = projectPath.substring(0, projectPath.length() - 9) + "web\\assets\\image";;// base path
                        String deploymentPath = projectPath + "\\assets\\image";

//                        File fileSaveDir = new File(path);
//                        System.out.println("File path father: " + fileSaveDir.getParent());
//                        if (!fileSaveDir.exists()) {
//                            fileSaveDir.mkdir();
//                        }
                        String filename = consigmentID + FilenameUtils.getName(item.getName()); // Get filename.
                        //web path
                        File file1 = new File(basePath + "\\" + filename); // base file
                        // project path
                        File file2 = new File(deploymentPath + "\\" + filename);//deployment file
                        try {
                            //item.write(file); // Write to base place
                            //item.write(file2);// write to deployment place
                            InputStream in = item.getInputStream();
                            OutputStream opsDeployment = new BufferedOutputStream(new FileOutputStream(file1));
                            OutputStream opsBase = new BufferedOutputStream(new FileOutputStream(file2));
                            for (int b; (b = in.read()) != -1;) {
                                opsDeployment.write(b);
                                opsBase.write(b);
                            }
                            if (!filename.isEmpty()) {
                                imagePath = "assets\\image\\" + filename;
                            }

                            opsDeployment.close();
                            opsBase.close();
                            in.close();
                        } catch (Exception ex) {
                            System.out.println("Cannot upload image");
                            Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }
                }

                ProductDTO product = (ProductDTO) session.getAttribute("PRODUCT");
                if (!product.getPurchasedDate().isEmpty()) {
                    product.setPurchasedDate(formatDate(product.getPurchasedDate()));
                }

                System.out.println("Local image link:  " + imagePath);
                System.out.println("product image link:  " + product.getImage());
                if (!imagePath.isEmpty()) {
                    product.setImage(imagePath);
                }
                //product.setImage(imagePath);

                DuchcDAO dao = new DuchcDAO();

                //Add new product and get id of it
                int productID = dao.addProduct(product);
                if (productID > 0) {
                    //get memberID if session MEMBER is not null
                    int memberID = 5;
                    if (session.getAttribute("ACCOUNT") != null) {
                        memberID = ((AccountDTO) session.getAttribute("ACCOUNT")).getRoleID();
                    }
                    //get storeOwnerID from step2
                    int storeOwnerID = 0;

                    storeOwnerID = Integer.parseInt(session.getAttribute("STORE").toString());
                    AccountDTO store = dao.getStoreOwnerByID(storeOwnerID);
                    double maxPrice = 0;
                    double minPrice = 0;
                    //get store de lay fomula va nam cua store

                    if (session.getAttribute("BASICPRICE") != null) {
                        double basicPrice = Double.parseDouble(session.getAttribute("BASICPRICE").toString());
                        maxPrice = Math.round((basicPrice * 60 / 100) * (1 + store.getFormula() / 100) / 1000) * 1000;
                        minPrice = Math.round((basicPrice * 60 / 100) * (1 - store.getFormula() / 100) / 1000) * 1000;

                    }

                    Date date = new Date();
                    DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
                    String createdDate = dateFormat.format(date);
                    ConsignmentDTO consignment = new ConsignmentDTO(consigmentID, productID, memberID, storeOwnerID, fullName,
                            address, phone, email, paypalAccount, fromDate, toDate, 30, minPrice, maxPrice, createdDate, 1);
                    boolean result = dao.addConsigment(consignment);
                    if (result) {

//                        String msg = "Cám ơn " + fullName + " đã ký gửi. \n"
//                                + "Mã sản phẩm của bạn là: " + consigmentID + ". \n"
//                                + store.getFullName() + " sẽ xem xét yêu cầu ký gửi của bạn.";;
//                        //send sms and email
//                        if (!phone.isEmpty()) {
//                            try {
//                                ultil.sendSMS(msg, phone);
//                            } catch (Exception e) {
//                                System.out.println("Loi khi gui tin nhan sms!");
//                                e.printStackTrace();
//                            }
//                        }
//                        if (!email.isEmpty()) {
//                            try {
//                                ultil.sendEmail(email, "[HPS] Ky gui thanh cong!", msg);
//                            } catch (Exception e) {
//                                System.out.println("Loi khi gui email!");
//                                e.printStackTrace();
//                            }
//
//                        }
                        consignment.setProduct(product);
                        session.setAttribute("CONSIGNMENT", consignment);
                        session.setAttribute("STOREOWNER", store);
                        
                        
                        session.removeAttribute("PRODUCT");
                        session.removeAttribute("BASICPRICE");
                        session.removeAttribute("STORE");
                        session.removeAttribute("STORELIST");
                        session.removeAttribute("FCATE");
                        session.removeAttribute("CATEGORY");
                    } else {
                        url = STEP4;
                    }

                } else {
                    url = STEP4;
                }

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

    private String formatDate(String date) {
        try {
            DateFormat format1 = new SimpleDateFormat("dd-MM-yyyy");
            DateFormat format2 = new SimpleDateFormat("MM/dd/yyyy");
            Date datetime = format1.parse(date);
            return format2.format(datetime);
        } catch (ParseException ex) {
            Logger.getLogger(ConsignCompleteServlet.class.getName()).log(Level.SEVERE, null, ex);
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
