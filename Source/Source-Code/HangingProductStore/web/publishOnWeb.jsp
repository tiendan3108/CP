<%-- 
    Document   : manageProductStatus
    Created on : May 31, 2015, 4:32:41 PM
    Author     : Tien Dan
--%>

<template:shopbasic htmlTitle="Pay Consignor" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <li id="nofi">
            <a href="#">
                <i class="icon-bell"></i>
                <span class="badge badge-default">3</span>           
            </a>
            <ul class="fallback">
                <li style="margin-left: -40px"><a href="#">notification 1</a></li>
                <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                <li style="margin-left: -40px"><a href="#">notification 4</a></li>
            </ul>
        </li>
    </jsp:attribute>
    <jsp:body>
        <div class="tab-content">
            <c:set var="product" value="${requestScope.product}"></c:set>
            <form action="ProcessServlet" method="POST">
                <div class="row">
                    <div class="col-sm-6"></div>
                    <div class="col-sm-6">
                        Product's information
                        <div class="form-horizontal">
                            <div class="form-group">
                                <input type="hidden" name="productID" value="${product.productID}">
                                Name : <input type="text" value="${product.name}"> </br>
                                Description : <input type="text" value="${product.description}"> </br>
                                Consignment Price : <input type="text" value="${requestScope.price}"> </br>
                                Received Date : <input type="text" value="${product.receivedDay}"> </br>
                                Selling Price : <input type="text" value="" name="txtSellingPrice">
                            </div>
                        </div>
                    </div>
                </div>
                                <button class="btn btn-primary" name="action" type="submit" value="manage">Cancel</button>
                                <button class="btn btn-primary" name="action" type="submit" value="finalPublish">Publish</button>
            </form>
        </jsp:body>
    </template:shopbasic>
