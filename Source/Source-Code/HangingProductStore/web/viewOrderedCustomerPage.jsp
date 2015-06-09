<%-- 
    Document   : manageProductStatus
    Created on : May 31, 2015, 10:30:13 AM
    Author     : Tien Dan
--%>

<template:shopbasic htmlTitle="Success Page" bodyTitle="">
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
        <c:set var="customer" value="${requestScope.customer}"></c:set>
            Customer Information: </br>
            <li>Full Name : <p>${customer.fullName}</p></li>
            <li>Address : <p>${customer.address}</p></li>
            <li>Phone : <p>${customer.phone}</p></li>
            <li>Email : <p>${customer.email}</p></li>
            <li>Ordered Date : </li>
            <form action="LoadManageProductPageServlet" method="POST">
                <button class="btn btn-defaul" name="action" type="submit" value="back">Back</button>
            </form>
    </jsp:body>
    </template:shopbasic>
