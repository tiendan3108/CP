/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 *
 * @author Tien Dan
 */
public class AmazonService {

    public static final String AWS_ACCESS_KEY_ID = "AKIAJQUQ7BS6CDFYFMLA";// access key id from amazon
    public static final String AWS_SECRET_KEY = "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";// secret key from amazon, pair with access key
    public static final String ENDPOINT = "ecs.amazonaws.com";// location
    public static final String ASS_TAG = "danqt-20";// account given by amazon so we can send request.

    public static void main(String[] args) {
        AmazonService test = new AmazonService();
        test.getProduct("rayban 3025", "Rayban", "FashionMen");
    }

    public List<AmazonProduct> getProduct(String keywords, String brand, String type) {

        SignedRequestsHelper helper;
        try {
            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, ASS_TAG);
        } catch (IllegalArgumentException | UnsupportedEncodingException | NoSuchAlgorithmException | InvalidKeyException e) {
            return null;
        }

        String requestUrl = null;
        List<AmazonProduct> result = new ArrayList<>();

        Map<String, String> params = new HashMap<>();
        params.put("Service", "AWSECommerceService");//ok
        params.put("Operation", "ItemSearch");
        params.put("Keywords", keywords);
        params.put("ResponseGroup", "Offers");
        params.put("Condition", "New");
        params.put("MerchantId", "All");
        params.put("SearchIndex", type);
        params.put("Brand", brand);

        requestUrl = helper.sign(params);
        System.out.println(requestUrl);
        result = fetchProduct(requestUrl);
        return result;
    }

    private List<AmazonProduct> fetchProduct(String requestUrl) {
        List<AmazonProduct> temp_result = new ArrayList<>();
        List<AmazonProduct> result = new ArrayList<>();
        AmazonProduct product = null;
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            doc.getDocumentElement().normalize();
            NodeList source, items, itemContent, offerSummaryContent, lowestNewPriceContent;
            Node nNode, item, ASINNode, offerSummaryNode, lowestNewPriceNode, priceNode, currencyNode;
            String ASIN, Currency;
            Float price;
            source = doc.getElementsByTagName("Items");
            nNode = source.item(0);
            items = nNode.getChildNodes();
            //start first node
            NodeList TotalResultsContent = doc.getElementsByTagName("TotalResults");
            Node TotalResults = TotalResultsContent.item(0);
            int maxLoop = 0, quantity;
            try {
                quantity = Integer.parseInt(TotalResults.getTextContent());
            } catch (DOMException | NumberFormatException e) {
                return null;
            }
            if (quantity >= 10) {
                quantity = 10;
            }
            int i = 4;
            for (int j = 0; j < quantity; j++) {
                item = items.item(i);
                itemContent = item.getChildNodes();
                ASINNode = itemContent.item(0);
                ASIN = ASINNode.getTextContent();
                offerSummaryNode = itemContent.item(1);
                offerSummaryContent = offerSummaryNode.getChildNodes();
                lowestNewPriceNode = offerSummaryContent.item(0);
                lowestNewPriceContent = lowestNewPriceNode.getChildNodes();
                priceNode = lowestNewPriceContent.item(0);
                currencyNode = lowestNewPriceContent.item(1);
                i++;
                if (lowestNewPriceNode.getNodeName().equals("LowestNewPrice")) {
                    price = Float.parseFloat(priceNode.getTextContent()) / 100;
                    Currency = currencyNode.getTextContent();
                    temp_result.add(new AmazonProduct(price, ASIN, Currency));
                }
            }
            for (AmazonProduct temp_product : temp_result) {
                product = getProductDetail(temp_product);
                if (product != null) {
                    result.add(product);
                }
            }
        } catch (ParserConfigurationException | SAXException | IOException ex) {
            Logger.getLogger(AmazonService.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return result;
    }

    private AmazonProduct getProductDetail(AmazonProduct product) {
        SignedRequestsHelper helper;
        try {
            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, ASS_TAG);
        } catch (IllegalArgumentException | UnsupportedEncodingException | NoSuchAlgorithmException | InvalidKeyException e) {
            e.printStackTrace();
            return null;
        }

        String requestUrl = null;
        List<AmazonProduct> result = new ArrayList<AmazonProduct>();

        Map<String, String> params = new HashMap<String, String>();
        params.put("Service", "AWSECommerceService");//ok
        params.put("Operation", "ItemLookup");
        params.put("ResponseGroup", "Large");
        params.put("Condition", "New");
        params.put("ItemId", product.getASIN());
        params.put("MerchantId", "All");

        requestUrl = helper.sign(params);
        return fetchProductDetail(product, requestUrl);
    }

    private AmazonProduct fetchProductDetail(AmazonProduct product, String requestUrl) {
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            doc.getDocumentElement().normalize();
            NodeList DetailPageURLContent = doc.getElementsByTagName("DetailPageURL");
            Node DetailPageURL = DetailPageURLContent.item(0);
            product.setUrl(DetailPageURL.getTextContent());
            NodeList TitleContent = doc.getElementsByTagName("Title");
            Node Title = TitleContent.item(0);
            product.setName(Title.getTextContent());
        } catch (ParserConfigurationException | SAXException | IOException ex) {
            Logger.getLogger(AmazonService.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return product;
    }
}
