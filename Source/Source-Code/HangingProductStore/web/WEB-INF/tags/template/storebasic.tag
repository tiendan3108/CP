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
<template:main htmlTitle="${htmlTitle}" bodyTitle="">
    <jsp:attribute name="headContent">
        <!-- Theme styles START -->
        <link href="assets/style/myStyle.css" rel="stylesheet">
        <link href="assets/global/css/components.css" rel="stylesheet">
        <link href="assets/global/css/plugins.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style-responsive.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/themes/red.css" rel="stylesheet" id="style-color">
        <link href="assets/frontend/layout/css/custom.css" rel="stylesheet">
        <!-- Theme styles END -->
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>
    <jsp:attribute name="bottomContent">
        <jsp:invoke fragment="extraBottomContent" />
        <script src="assets/frontend/layout/scripts/layout.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                $("#nofi").click(function () {
                    $("#nav ul li ul.fallback").css("display", "block");
                    $('html').click(function (event) {
                        if ($(event.target).parents('#nofi').length == 0) {
                            $("#nav ul li ul.fallback").css("display", "none");
                            $(this).unbind(event);
                        }

                    })
                });
                $(".removeColapse").removeClass("collapsed");

            });
        </script>
    </jsp:attribute>
    <jsp:attribute name="navigationContent">
        <jsp:invoke fragment="extraNavigationContent" />
        <li><a href="page-login.html">Log Out</a>
        </li>
        <li><a href="shop-account.html">Account</a>
        </li>
        <li><a href="shop-account.html">Management</a>
        </li>        
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
        <jsp:doBody />
    </jsp:body>
</template:main>