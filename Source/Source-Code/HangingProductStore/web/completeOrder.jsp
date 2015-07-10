<%-- 
    Document   : completeOrder
    Created on : Jun 12, 2015, 11:21:52 AM
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
    </jsp:attribute>
    <jsp:body> 
        <div id="wrapper">
            <div class="row margin-bottom-40">
                <div class="col-md-12 col-sm-12">
                    <c:set var="mess" value="${requestScope.MESS}"/>
                    <c:if test="${not empty mess}">
                        <div class="alert alert-info" style="font-size: 18px">
                           <strong>${mess}</strong> 
                        </div>                     
                    </c:if>                  
                    <a class="btn btn-primary" href="HomeServlet">Trở về trang chủ.</a>
                </div>
            </div>
        </div>
    </jsp:body>
</template:shopbasic>
