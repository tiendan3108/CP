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
        <script type="text/javascript">
            $(function () {
                if ($("#txtErr").html() != "") {
                    $("#loginModal2").modal("show");
                }
            });
        </script>
        <jsp:invoke fragment="extraBottomContent" />

    </jsp:attribute>
    <jsp:attribute name="navigationContent">      
        <c:set var="member" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${empty member}">
            <li><a data-toggle="modal" data-target="#loginModal2">Đăng nhập</a></li>            
            </c:if>
            <c:if test="${not empty member}">
            <li>
                <c:url value="/ConsignServlet" var="logoutUrl">
                    <c:param name="btnAction" value="logout" />
                    <c:param name="backlink" value="${requestScope.backlink}" />
                </c:url>
                <a href="${logoutUrl}">Thoát</a>
            </li>         
        </c:if>
        <li><a href="TrackProductStatusServlet">Kiểm tra hàng ký gửi</a></li>
        <li><a href="ViewCartServlet">Giỏ hàng</a></li>
        <li><a href="ConsignServlet">Ký gửi</a></li>



        <c:if test="${not empty member}">
            <li>Chào, <b>${member.fullName}</b></li>            


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

        <c:if test="${empty member}">
            <div id="loginModal2" class="modal face bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h1 class="text-center">Đăng Nhập</h1>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <form class="form col-md-12 center-block" action="ConsignServlet" method="POST">
                                    <div class="form-group">
                                        <input required="true" name="username" type="text" class="form-control input-lg" placeholder="Tên Đăng Nhập" value="${username}"/>
                                    </div>
                                    <div class="form-group">
                                        <input required="true" name="password" type="password" class="form-control input-lg" placeholder="Mật Khẩu" value="${password}"/>
                                        <input type="hidden" name="backlink" value="${backlink}"/>
                                    </div>
                                    <div>
                                        <h5 id="txtErr" style="color:red">${err}</h5>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" name="btnAction" value="login" class="btn btn-primary btn-lg btn-block">Đăng Nhập</button>
                                        <span class="pull-right"><a href="#">Đăng Kí</a></span><span><a href="#">Giúp Đỡ?</a></span>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <jsp:invoke fragment="extraNavigationContent" />
    </jsp:attribute>
    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</template:main>