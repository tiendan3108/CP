<%-- 
    Document   : storebasic
    Created on : May 28, 2015, 6:52:59 AM
    Author     : ACER
--%>

<%@tag description="2nd level template for store frontend" pageEncoding="UTF-8"
       body-content="scriptless"%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="extraHeadContent" fragment="true" required="false"%>
<%@attribute name="extraBottomContent" fragment="true" required="false"%>
<%@attribute name="extraNavigationContent" fragment="true" required="false"%>
<%@include file="/WEB-INF/jsp/base.jspf" %>
<template:main htmlTitle="${htmlTitle}" bodyTitle="${bodyTitle}">
    <jsp:attribute name="headContent">
        <!-- Theme styles START -->
        <link href="assets/style/myStyle.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style.css" rel="stylesheet">
        <link href="assets/frontend/pages/css/style-shop.css" rel="stylesheet" type="text/css">
        <link href="assets/frontend/pages/css/style-layer-slider.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style-responsive.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/themes/red.css" rel="stylesheet" id="style-color">
        <link href="assets/frontend/layout/css/custom.css" rel="stylesheet">
        <!-- Theme styles END -->
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>
    <jsp:attribute name="bottomContent">
        <jsp:invoke fragment="extraBottomContent" />
    </jsp:attribute>
    <jsp:attribute name="navigationContent">
        <li><a href="./consignor">Consignment <span class="badge">1</span></a>
        </li>
        <li><a href="shop-account.html">Order <span class="badge">1</span></a>
        </li>
        <li><a href="shop-account.html">Inventory</a>
        </li>
        <li><a href="./statistic">Statistic</a>
        </li>
        <li><a href="shop-account.html">My Account</a>
        </li>
        <li><a href="shop-account.html">My Management <span class="badge">4</span></a>
        </li>
        <li><a href="page-login.html">Log Out</a>
        </li>
        <jsp:invoke fragment="extraNavigationContent" />
    </jsp:attribute>
    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</template:main>