<%-- 
    Document   : login
    Created on : Aug 11, 2015, 6:47:15 PM
    Author     : HoangNHSE61007
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>Đăng Nhập</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <meta content="" name="description"/>
        <meta content="" name="author"/>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link href="assets/global/plugins/select2/select2.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/pages/css/login3.css" rel="stylesheet" type="text/css"/>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME STYLES -->
        <link href="assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
        <link href="assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css" id="style_color"/>
        <link href="assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
    </head>
    <body class="login">
        <!-- BEGIN LOGO -->
        <div class="logo">
        </div>
        <!-- END LOGO -->
        <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
        <div class="menu-toggler sidebar-toggler">
        </div>
        <!-- END SIDEBAR TOGGLER BUTTON -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <form class="login-form" action="LoginServlet" method="POST">
                <h3 style="color:#01579b;font-size: 30px;font-weight: 500" class="form-title">Đăng Nhập</h3>
                <div class="alert alert-danger display-hide">
                    <button class="close" data-close="alert"></button>
                    <span style="font-weight: bold">
                        Vùi lòng nhập tên đăng nhập và mật khẩu. </span>
                </div>
                <div class="form-group">
                    <label>Tên Đăng Nhập</label>
                    <label class="control-label visible-ie8 visible-ie9">Tên Đăng Nhập</label>
                    <div class="input-icon" style="border-left: 2px solid #01579b !important;">
                        <i class="fa fa-user"></i>
                        <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Tên Đăng Nhập" name="username"/>
                    </div>
                </div>
                <div class="form-group">
                    <label>Mật Khẩu</label>
                    <label class="control-label visible-ie8 visible-ie9">Password</label>
                    <div class="input-icon" style="border-left: 2px solid #01579b !important;">
                        <i class="fa fa-lock"></i>
                        <input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="Mật Khẩu" name="password"/>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn green-haze pull-right" style="background-color: #01579b">
                        Đăng Nhập <i class="m-icon-swapright m-icon-white"></i>
                    </button>
                </div>
                <c:set var="err" value="${requestScope.ERR}"/>
                <c:if test="${not empty err}">
                    <p style="font-size: 16px; color: red">${err} </p>
                </c:if>               
                <div class="create-account">
                    <p style="font-size: 18px"><a href="">Tạo Tài Khoản Mới </a>
                    </p>
                </div>
            </form>
        </div>
        <div class="copyright">
            © 2015 Group8 Capstone Project
        </div>
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/global/plugins/select2/select2.min.js"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
        <script src="assets/admin/pages/scripts/login.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <script>
            jQuery(document).ready(function () {
                Metronic.init(); // init metronic core components
                Layout.init(); // init current layout
                Login.init();
                Demo.init();
            });
        </script>
        <!-- END JAVASCRIPTS -->
    </body>
</html>
