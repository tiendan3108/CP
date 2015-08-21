/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

import java.io.File;
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
//        AmazonService test = new AmazonService();
//        test.getProductByUPC("635753490879");
//        AmazonProduct bla = test.getProductByUPC("079767960599");
//        if (bla == null) {
//            System.out.println("sai cmnr");
//        } else {
//            System.out.println(bla.getNewPrice() + " " + bla.getPrice());
//        }
//        List<AmazonProduct> result = test.getProduct("Crawford Boyfriend Watch-Chocolate", "Geneva", "Watches");
    }
    
    public List<AmazonProduct> getProduct(String keywords, String brand, String type) {
        List<AmazonProduct> result = new ArrayList<>();
        try {
            SignedRequestsHelper helper;
            try {
                helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, ASS_TAG);
            } catch (IllegalArgumentException | UnsupportedEncodingException | NoSuchAlgorithmException | InvalidKeyException ex) {
                return null;
            }
            
            String requestUrl = null;
            
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
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        }
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
            NodeList source, items, itemContent;
            Node nNode, item, ASINNode;
            String ASIN;
            source = doc.getElementsByTagName("Items");
            nNode = source.item(0);
            items = nNode.getChildNodes();
            //start first node
            NodeList TotalResultsContent = doc.getElementsByTagName("TotalResults");
            Node TotalResults = TotalResultsContent.item(0);
            int quantity;
            try {
                quantity = Integer.parseInt(TotalResults.getTextContent());
            } catch (DOMException | NumberFormatException e) {
                return null;
            }
            if (quantity >= 10) {
                return null;
            }
            int i = 4;
            for (int j = 0; j < quantity; j++) {
                item = items.item(i);
                itemContent = item.getChildNodes();
                ASINNode = itemContent.item(0);
                ASIN = ASINNode.getTextContent();
                product = new AmazonProduct();
                product.setASIN(ASIN);
                temp_result.add(product);
                i++;
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
        
        Map<String, String> params = new HashMap<String, String>();
        params.put("Service", "AWSECommerceService");//ok
        params.put("Operation", "ItemLookup");
        params.put("ResponseGroup", "Large");
        params.put("Condition", "New");
        params.put("ItemId", product.getASIN());
        params.put("MerchantId", "All");
        
        requestUrl = helper.sign(params);
        System.out.println("Child url : " + requestUrl);
        return fetchProductDetail(product, requestUrl);
    }
    
    private AmazonProduct fetchProductDetail(AmazonProduct product, String requestUrl) {
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            doc.getDocumentElement().normalize();
            NodeList TitleContent = doc.getElementsByTagName("Title");
            Node Title = TitleContent.item(0);
            product.setName(Title.getTextContent());
            NodeList MediumImageContent = doc.getElementsByTagName("MediumImage");
            if (MediumImageContent != null) {
                Node imageURL = MediumImageContent.item(0);
                if (imageURL != null) {
                    NodeList URLContent = imageURL.getChildNodes();
                    Node URL = URLContent.item(0);
                    if (URL != null && URL.getNodeName().equals("URL")) {
                        product.setImage(URL.getTextContent());
                    }
                }
            }
            NodeList LargeImageContent = doc.getElementsByTagName("LargeImage");
            if (LargeImageContent != null) {
                Node imageURL = LargeImageContent.item(0);
                if (imageURL != null) {
                    NodeList URLContent = imageURL.getChildNodes();
                    Node URL = URLContent.item(0);
                    if (URL != null && URL.getNodeName().equals("URL")) {
                        product.setImage(URL.getTextContent());
                    }
                }
            }
            NodeList DetailPageURLContent = doc.getElementsByTagName("DetailPageURL");
            if (DetailPageURLContent != null) {
                Node detailPage = DetailPageURLContent.item(0);
                if (detailPage != null) {
                    product.setUrl(detailPage.getTextContent());
                }
            }
            NodeList OfferSummaryContent = doc.getElementsByTagName("OfferSummary");
            if (OfferSummaryContent != null) {
                Node OfferSummaryNode = OfferSummaryContent.item(0);
                if (OfferSummaryNode != null) {
                    NodeList LowestNewPriceContent = OfferSummaryNode.getChildNodes();
                    if (LowestNewPriceContent != null) {
                        Node LowestNewPriceNode = LowestNewPriceContent.item(0);
                        if (LowestNewPriceNode != null && LowestNewPriceNode.getNodeName().equals("LowestNewPrice")) {
                            NodeList AmountContent = LowestNewPriceNode.getChildNodes();
                            Node AmountNode = AmountContent.item(0);
                            if (AmountNode != null && AmountNode.getNodeName().equals("Amount")) {
                                product.setPrice(Float.parseFloat(AmountNode.getTextContent()) / 100);
                            } else {
                                return null;
                            }
                        } else {
                            return null;
                        }
                    }
                }
            } else {
                return null;
            }
            if (product.getImage() == null) {
                NodeList ImageSetsContent = doc.getElementsByTagName("ImageSets");
                if (ImageSetsContent != null) {
                    for (int i = 0; i < ImageSetsContent.getLength(); i++) {
                        Node imageURL = ImageSetsContent.item(i);
                        if (imageURL.getNodeName().equals("MediumImage") || imageURL.getNodeName().equals("LargeImage")) {
                            NodeList URLContent = imageURL.getChildNodes();
                            Node URL = URLContent.item(0);
                            if (URL != null && URL.getNodeName().equals("URL")) {
                                product.setImage(URL.getTextContent());
                            }
                        }
                    }
                } else {
                    return null;
                }
            }
            System.out.println(product.toString());
            if (product.getImage() == null) {
                return null;
            }
            return product;
        } catch (ParserConfigurationException | SAXException | IOException ex) {
            Logger.getLogger(AmazonService.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public AmazonProduct getProductByUPC(String upc) {
        try {
            SignedRequestsHelper helper;
            try {
                helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, ASS_TAG);
            } catch (IllegalArgumentException | UnsupportedEncodingException | NoSuchAlgorithmException | InvalidKeyException ex) {
                return null;
            }
            
            String requestUrl = null;
            
            Map<String, String> params = new HashMap<>();
            params.put("Service", "AWSECommerceService");//ok
            params.put("Operation", "ItemLookup");
            params.put("ResponseGroup", "Large");
            params.put("SearchIndex", "All");
            params.put("IdType", "UPC");
            params.put("ItemId", upc);
            
            requestUrl = helper.sign(params);
            System.out.println(requestUrl);
            return fetchProductByUPC(requestUrl);
        } catch (Exception e) {
            return null;
        }
    }
    
    private AmazonProduct fetchProductByUPC(String requestUrl) {
        AmazonProduct product = null;
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
            doc.getDocumentElement().normalize();
            NodeList error = doc.getElementsByTagName("Errors");
            if (error.getLength() != 0) {
                return null;
            } else {
                product = new AmazonProduct();
                NodeList TitleContent = doc.getElementsByTagName("Title");
                if (TitleContent != null) {
                    Node titleNode = TitleContent.item(0);
                    if (titleNode != null) {
                        product.setName(titleNode.getTextContent());
                    }
                }
                NodeList DetailPageURLContent = doc.getElementsByTagName("DetailPageURL");
                if (DetailPageURLContent != null) {
                    Node urlNode = DetailPageURLContent.item(0);
                    if (urlNode != null) {
                        product.setUrl(urlNode.getTextContent());
                    }
                }
                NodeList MediumImageContent = doc.getElementsByTagName("MediumImage");
                if (MediumImageContent != null) {
                    Node imageURL = MediumImageContent.item(0);
                    NodeList URLContent = imageURL.getChildNodes();
                    Node URL = URLContent.item(0);
                    if (URL != null && URL.getNodeName().equals("URL")) {
                        product.setImage(URL.getTextContent());
                    }
                }
                NodeList LargeImageContent = doc.getElementsByTagName("LargeImage");
                if (LargeImageContent != null) {
                    Node imageURL = LargeImageContent.item(0);
                    NodeList URLContent = imageURL.getChildNodes();
                    Node URL = URLContent.item(0);
                    if (URL != null && URL.getNodeName().equals("URL")) {
                        product.setImage(URL.getTextContent());
                    }
                }
                if (product.getImage() == null) {
                    NodeList ImageSetsContent = doc.getElementsByTagName("ImageSets");
                    if (ImageSetsContent != null) {
                        for (int i = 0; i < ImageSetsContent.getLength(); i++) {
                            Node imageURL = ImageSetsContent.item(i);
                            if (imageURL.getNodeName().equals("MediumImage") || imageURL.getNodeName().equals("LargeImage")) {
                                NodeList URLContent = imageURL.getChildNodes();
                                Node URL = URLContent.item(0);
                                if (URL != null && URL.getNodeName().equals("URL")) {
                                    product.setImage(URL.getTextContent());
                                }
                            }
                        }
                    } else {
                        return null;
                    }
                }
                NodeList ListPriceContent = doc.getElementsByTagName("ListPrice");
                if (ListPriceContent != null) {
                    Node ListPriceNode = ListPriceContent.item(0);
                    if (ListPriceNode != null) {
                        NodeList AmoutContent = ListPriceNode.getChildNodes();
                        Node AmoutNode = AmoutContent.item(0);
                        if (AmoutNode != null) {
                            product.setNewPrice(Float.parseFloat(AmoutNode.getTextContent()) / 100);
                        }
                    }
                }
                NodeList LowestUsedPriceContent = doc.getElementsByTagName("LowestUsedPrice");
                if (LowestUsedPriceContent != null) {
                    Node ListPriceNode = LowestUsedPriceContent.item(0);
                    if (ListPriceNode != null) {
                        NodeList AmoutContent = ListPriceNode.getChildNodes();
                        Node AmoutNode = AmoutContent.item(0);
                        if (AmoutNode != null) {
                            product.setPrice(Float.parseFloat(AmoutNode.getTextContent()) / 100);
                        }
                    }
                }
                NodeList BrandContent = doc.getElementsByTagName("Brand");
                if (BrandContent != null) {
                    Node BrandNode = BrandContent.item(0);
                    if (BrandNode != null) {
                        String brand = BrandNode.getTextContent();
                        product.setBrand(brand);
                    }
                }
            }
        } catch (ParserConfigurationException | SAXException | IOException ex) {
            Logger.getLogger(AmazonService.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        System.out.println(product.toString());
        return product;
    }
}
