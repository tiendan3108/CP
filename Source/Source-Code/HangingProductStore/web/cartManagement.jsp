<%-- 
    Document   : cartManagement
    Created on : Jun 8, 2015, 7:15:50 PM
    Author     : HoangNHSE61007
--%>

<template:shopbasic htmlTitle="Home" bodyTitle="">
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
                <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                <li style="margin-left: -40px"><a href="#">notification 4</a></li>
            </ul>
        </li>
    </jsp:attribute>
    <jsp:body>      
        <div class="row margin-bottom-40">
            <!-- BEGIN CONTENT -->
            <div class="col-md-12 col-sm-12">
                <h1>Shopping cart</h1>
                <div class="goods-page">
                    <div class="goods-data clearfix">
                        <c:set var="items" value="${requestScope.DATA}"/>
                        <c:if test="${not empty items}">
                            <div class="table-wrapper-responsive">
                                <table summary="Shopping cart">
                                    <tr>
                                        <th style="width: 20%">No</th>
                                        <th style="width: 20%">Name</th>
                                        <th style="width: 20%">Brand</th>                               
                                        <th style="width: 20%">Serial Number</th>
                                    </tr>
                                    <c:forEach var="item" items="${items}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td
                                                ><a href="ViewProductDetailServlet?productID=${item.productID}">${item.name}</a>
                                            </td>
                                            <td><h3>${item.brand}</h3></td>
                                            <td>${item.serialNumber}</td>
                                            <td>
                                                <a class="del-goods" href="RemoveProductServlet?productID=${item.productID}">&nbsp;</a>
                                            </td>
                                        </tr>
                                    </c:forEach>                                   
                                </table>
                            </div>
                        </c:if>
                        <c:if test="${empty items}">
                            Your shopping cart is empty!
                        </c:if>
                    </div>
                    <a href="HomeServlet" class="btn btn-default">Continue shopping <i class="fa fa-shopping-cart"></i></a>
                    <a class="btn btn-primary">Checkout <i class="fa fa-check"></i></a>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
    </jsp:body>
</template:shopbasic>
