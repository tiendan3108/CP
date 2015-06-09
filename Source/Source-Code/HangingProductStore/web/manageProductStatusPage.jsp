<%-- 
    Document   : manageProductStatus
    Created on : May 31, 2015, 10:30:13 AM
    Author     : Tien Dan
--%>

<template:shopbasic htmlTitle="Manage Product Status" bodyTitle="">
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
        <div id="searchDiv" class="col-md-9 col-sm-7">
            <form action="SearchProductStatusServlet" method="POST">
                <input type="text" name="txtKeywords" value="">
                <select name="typeSearch" >
                    <option>All</option>
                    <option>Product Name</option>
                    <option>Received Date</option>
                    <option>Order ID</option>
                    <option>Status</option>
                </select>
                <button class="btn btn-primary" name="action" type="submit" value="searchStatus">Search</button>
            </form>
        </div>
        <div id="searchResult" class="col-md-9 col-sm-7">
            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Product Name</th>
                        <th>Received Date</th>
                        <th>Order ID</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="result" value="${requestScope.result}"/>
                    <c:if test="${not empty result}">
                        <c:forEach var="item" items="${result}" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${item.name}</td>
                                <td>${item.receivedDate}</td>
                                <td>${item.consignmentID}</td>
                                <td>${item.consignedPrice} USD</td>
                                <td>
                                    <c:set var="status" value="${item.status}"/>
                                    <c:choose>
                                        <c:when test="${status==2}">
                                            <form action="LoadPaymentPageServlet" method="GET">
                                                <button class="btn btn-info" type="submit">Sold</button>
                                                <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                            </form>
                                        </c:when>
                                        <c:when test="${status==1}">
                                            <form action="LoadCustomerPageServlet" method="GET">
                                                <button class="btn btn-info" type="submit">Ordered</button>
                                                <input name="productID" type="hidden" value="${item.productID}">
                                            </form>
                                        </c:when>
                                        <c:when test="${status==3}">
                                            <a href="ViewProductDetailServlet?productID=${item.productID}" class="label-primary">On web</a>
                                        </c:when>
                                        <c:when test="${status==4}">
                                            <label class="label-danger">Owned</label>
                                        </c:when>
                                        <c:when test="${status==5}">
                                            <label class="label-danger">Out of Date</label>
                                        </c:when>
                                        <c:when test="${status==6}">
                                            <label class="label-danger">Cancel by Consignor</label>
                                        </c:when>
                                        <c:when test="${status==7}">
                                            <label class="label-danger">Returned</label>
                                        </c:when>
                                        <c:when test="${status==8}">
                                            <label class="label-danger">Completed</label>
                                        </c:when>
                                        <c:when test="${status==8}">
                                            <label class="label-danger">Cancel by Consignor</label>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${status==3}">
                                        <form action="LoadCancelProductPageServlet" method="POST">
                                            <button class="btn btn-warning" name="action" type="submit" value="cancel">Cancel</button>
                                            <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                            <input name="productID" type="hidden" value="${item.productID}">
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
    </jsp:body>
</template:shopbasic>
