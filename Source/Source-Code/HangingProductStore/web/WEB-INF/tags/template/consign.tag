<%-- 
    Document   : consign
    Created on : Jun 10, 2015, 9:33:01 AM
    Author     : Robingios
--%>

<%@tag description="2nd level template for shop frontend" pageEncoding="UTF-8"
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

 <!-- Xài bootstrap template đẹp hơn -->
        <!--        <link href="assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>-->
        
        <link href="assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
        <!-- Theme styles END -->  
        
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/select2/select2.css"/>

        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/jquery-tags-input/jquery.tagsinput.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css">
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/typeahead/typeahead.css">


        <link rel="stylesheet" type="text/css" href="assets/global/plugins/clockface/css/clockface.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datepicker/css/datepicker3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>

        <!-- END PAGE LEVEL SCRIPTS -->
        
        
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>
    <jsp:attribute name="bottomContent">
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script type="text/javascript" src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/jquery-validation/js/additional-methods.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
        
        
        <script type="text/javascript" src="assets/global/plugins/select2/select2.min.js"></script>


        <script type="text/javascript" src="assets/global/plugins/fuelux/js/spinner.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
        <script type="text/javascript" src="assets/global/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/jquery.input-ip-address-control-1.0.min.js"></script>

        <script src="assets/global/plugins/bootstrap-pwstrength/pwstrength-bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-tags-input/jquery.tagsinput.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
        <script src="assets/global/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/global/plugins/ckeditor/ckeditor.js"></script>


        <!-- END PAGE LEVEL PLUGINS -->

        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
        <script src="assets/admin/layout2/scripts/layout.js" type="text/javascript"></script>  
        <script src="assets/admin/layout2/scripts/demo.js" type="text/javascript"></script>
        <script src="assets/admin/pages/scripts/form-wizard.js"></script>
        <script src="assets/admin/pages/scripts/components-form-tools.js"></script>


        <script type="text/javascript" src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/clockface/js/clockface.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/moment.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

        <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
        <script src="assets/admin/layout2/scripts/layout.js" type="text/javascript"></script>
        <script src="assets/admin/layout2/scripts/demo.js" type="text/javascript"></script>
        <script src="assets/admin/pages/scripts/components-form-tools.js"></script>
        <script src="assets/admin/pages/scripts/components-pickers.js"></script>

        <!-- END PAGE LEVEL SCRIPTS -->
        <script>
            jQuery(document).ready(function () {
                // initiate layout and plugins
                Metronic.init(); // init metronic core components
                Layout.init(); // init current layout
                Demo.init(); // init demo features


                // initiate layout and plugins
                ComponentsFormTools.init();


                ComponentsPickers.init();


            });
        </script>

        <jsp:invoke fragment="extraBottomContent" />
                
    </jsp:attribute>
    <jsp:attribute name="navigationContent">      
        
         <c:if test="${not empty MEMBER}">
            <li><a href="shop-account.html">Tài khoản</a></li>
            <li><a href="shop-wishlist.html">Danh sách yêu cầu</a></li>
            </c:if>
        <li><a href="TrackProductStatusServlet">Kiểm tra hàng ký gửi</a></li>

        <c:if test="${empty MEMBER}">
            <li><a href="LoginServlet">Đăng nhập</a></li>            
            </c:if>
            <c:if test="${not empty MEMBER}">
            <li><a href="LoginServlet">Đăng xuất</a></li>            
            </c:if>
            <c:if test="${not empty MEMBER}">
            <li id="nofi">
                <a href="#">
                    <i class="icon-bell"></i>
                    <span class="badge badge-default">3</span>           
                </a>
                <ul class="fallback">
                    <li style="margin-left: -40px"><a href="#">thông báo 1</a></li>
                    <li style="margin-left: -40px"><a href="#">thông báo 2</a></li>
                    <li style="margin-left: -40px"><a href="#">thông báo 3</a></li>
                    <li style="margin-left: -40px"><a href="#">thông báo 4</a></li>
                </ul>
            </li>  
        </c:if>
        
        <jsp:invoke fragment="extraNavigationContent" />
    </jsp:attribute>
    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</template:main>