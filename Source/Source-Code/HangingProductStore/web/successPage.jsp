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
        Thực hiện thao tác thành công.
        Click <a class="label-info" href="LoadManageProductPageServlet">vào đây</a> để trở về trang quản lý
    </jsp:body>
</template:shopbasic>
