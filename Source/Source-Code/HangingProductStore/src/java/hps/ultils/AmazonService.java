/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

import java.util.HashMap;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

/**
 *
 * @author Tien Dan
 */
public class AmazonService {
    // ham getprice này truyền 3 tham số
    // keywords là tên của sản phẩm, brand là hãng
    // type là loại sản phẩm nằm trong danh sách sau:
    // Watches,Fashion,Shoes,FashionBoys,FashionGirls,FashionWomen,FashionMen,Jewelry,FashionBaby
    // hàm trả về -1 nếu ko tìm thấy sản phẩm
    // trả về số là giá thấp nhất của sản phầm mới theo đơn vị USD
    public float getPrice(String keywords, String brand, String type) {
        
        SignedRequestsHelper helper;
        try {
            helper = SignedRequestsHelper.getInstance(GlobalVariables.ENDPOINT, GlobalVariables.AWS_ACCESS_KEY_ID, GlobalVariables.AWS_SECRET_KEY,GlobalVariables.ASS_TAG);
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
        
        String requestUrl = null;
        float price;

        Map<String, String> params = new HashMap<String, String>();
        params.put("Service", "AWSECommerceService");//ok
        params.put("Operation", "ItemSearch");
        params.put("Keywords",keywords);
        params.put("ResponseGroup", "Offers");
        params.put("Condition", "New");
        params.put("MerchantId","All");
        params.put("SearchIndex", type);
        params.put("Brand", brand);

        requestUrl = helper.sign(params);
        price = fetchPrice(requestUrl);
        System.out.println(requestUrl);
        return price;
    }

    private float fetchPrice(String requestUrl) {
        float price;
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            Node titleNode = doc.getElementsByTagName("Amount").item(0);
            price = Float.parseFloat(titleNode.getTextContent())/100;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
        return price;
    }
    
    public static void main(String[] args) {
        AmazonService amazon = new AmazonService();
        String keyword = "Native Miller";
        String brand = "";
        String category = "Shoes";
        
        float price = amazon.getPrice(keyword, brand, category);
        System.out.println("Keyword : " + keyword);
        System.out.println("Brand   : " + brand);
        System.out.println("Category: " + category);
        System.out.println("Price   : " + price);
    }
}
