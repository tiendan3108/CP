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
            <form action="ProcessServlet" method="POST">
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
                                <td>${item.receivedDay}</td>
                                <td>${item.consignmentID}</td>
                                <td>${item.price} USD</td>
                                <td>
                                    <c:set var="status" value="${item.status}"/>
                                    <c:choose>
                                        <c:when test="${status==1}">
                                            <form action="ProcessServlet" method="POST">
                                                <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                                <input name="productID" type="hidden" value="${item.productID}">
                                                <button class="btn btn-info" name="action" type="submit" value="pay">Sold</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${status==2}">
                                            <form action="ProcessServlet" method="POST">
                                                <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                                <input name="productID" type="hidden" value="${item.productID}">
                                                <button class="btn btn-info" name="action" type="submit" value="publish">In Inventory</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${status==3}">
                                            <a href="#" class="label-primary">On web</a>
                                        </c:when>
                                        <c:when test="${status==4}">

                                        </c:when>
                                        <c:when test="${status==5}">

                                        </c:when>
                                        <c:when test="${status==6}">
                                            <label class="label-danger">Cancel by Consignor</label>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${(status==2) || (status==3)}">
                                    <form action="ProcessServlet" method="POST">
                                        <button class="btn btn-warning" name="action" type="submit" value="cancel" onclick="return confirm('Are you sure to cancel this consignment?')">Cancel</button>
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
