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
        <li><a href="ViewCartServlet">Giỏ Hàng</a></li>  
        <li><a href="ConsignServlet">Kí Gửi</a></li>
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
            <div class="col-md-12 col-sm-12">
                <h4>Bạn đã đặt hàng thành công, vui lòng kiểm tra mail hoặc tin nhắn để biết thêm thông tin.</h4>
                <a class="btn btn-primary" href="">Trở về trang chủ.</a>
            </div>
        </div>
    </jsp:body>
</template:shopbasic>
