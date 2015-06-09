<%-- 
    Document   : manageProductStatus
    Created on : May 31, 2015, 10:30:13 AM
    Author     : Tien Dan
--%>

<template:shopbasic htmlTitle="Manage Product Status - Review Cancel" bodyTitle="">
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
        <div>
            <div>
                <c:set var="product" value="${requestScope.product}"></c:set>
                <c:set var="consignor" value="${requestScope.consignor}"></c:set>
                Product Information </br>
                <li>Product Name : <input type="text" readonly="readonly" value="${product.name}"></li>
                <li>Brand : <input type="text" readonly="readonly" value="${product.brand}"></li>
                <li>Description : <input type="text" readonly="readonly" value="${product.description}"></li>
                <li>Consigned Price : <input type="text" readonly="readonly" value="${consignor.consignedPrice}"></li>
            </div>
            <div>
                Consignor Information </br>
                <li>Full Name : <input type="text" readonly="readonly" value="${consignor.fullName}"></li>
                <li>Address : <input type="text" readonly="readonly" value="${consignor.address}"></li>
                <li>Email : <input type="text" readonly="readonly" value="${consignor.email}"></li>
                <li>Phone : <input type="text" readonly="readonly" value="${consignor.phone}"></li>
            </div>
            <form action="CancelProductServlet" method="POST">
                <input type="hidden" name="productID" value="${requestScope.productID}">
                <button class="btn btn-warning" name="action" type="submit" value="cancel" onclick="return confirm('Are you sure to cancel this consignment?')">Cancel Consignment</button>
            </form>
            <form action="LoadManageProductPageServlet" method="POST">
                <button class="btn btn-defaul" name="action" type="submit" value="back">Back</button>
            </form>
        </div>
    </jsp:body>
</template:shopbasic>
