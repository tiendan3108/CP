<%-- 
    Document   : accountManagement
    Created on : Jul 14, 2015, 11:27:24 AM
    Author     : HoangNHSE61007
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>Quản lí</title>
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
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME STYLES -->
        <link href="assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
        <link href="assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
        <link id="style_color" href="assets/admin/layout/css/themes/blue.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/select2/select2.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
        <c:set var="account" value="${sessionScope.ACCOUNT}"/>       
        <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a style="text-decoration: none;color:white;font-size: 18px;line-height: 25px;margin-top: 10px" href="ViewAccountServlet">
                        Hanging Product Store
                    </a>
                </div>

                <div class="top-menu">
                    <c:if test="${not empty account}">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                    <span class="username username-hide-on-mobile">${account.fullName}</span>
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-default">
                                    <li>
                                        <a href="extra_profile.html">
                                            <i class="icon-user"></i> thông tin cá nhân </a>
                                    </li>
                                </ul>                           
                            </li>
                            <li class="dropdown dropdown-user">
                                <a href="LogoutServlet" class="dropdown-toggle">
                                    <span class="username username-hide-on-mobile">Đăng xuất</span>
                                </a>                      
                            </li>
                        </ul> 
                    </c:if>                   
                </div>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END HEADER INNER -->
        </div>
        <!-- END HEADER -->
        <div class="clearfix">
        </div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <c:if test="${empty account || account.role != 'admin'}">
                <h2>Không có quyền để truy cập trang này</h2>
            </c:if>
            <!-- BEGIN SIDEBAR -->
            <c:if test="${not empty account && account.role == 'admin'}">
                <div class="page-sidebar-wrapper">
                    <div class="page-sidebar navbar-collapse collapse">
                        <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                            <li class="sidebar-toggler-wrapper">
                                <div class="sidebar-toggler">
                                </div>->
                            </li>
                            <li class="start">
                                <a href="ViewAccountServlet">
                                    <i class="icon-user"></i>
                                    <span class="title">Quản lí tài khoản</span>
                                    <span class="arrow "></span>
                                </a>
                            </li>								
                        </ul>
                        <!-- END SIDEBAR MENU -->
                    </div>
                </div>
                <!-- END SIDEBAR -->
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <c:set var="accounts" value="${requestScope.DATA}"/>  
                    <div class="page-content">
                        <h3 class="page-title">
                            Quản lí tài khoản 
                        </h3>
                        <a data-toggle="modal" data-target="#addAccountModel"  style="margin-bottom: 20px;float: right" class="btn btn-primary">Thêm tài khoản</a>
                        <!-- END PAGE HEADER-->
                        <!-- BEGIN PAGE CONTENT-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="portlet box blue">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-globe"></i>Quản lí yêu cầu
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <table class="table table-striped table-hover" id="sample_1">
                                            <thead>
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Tên đăng nhập</th>
                                                    <th>Status</th>
                                                    <th>Tên</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Điện thoại</th>
                                                    <th>Email</th>
                                                    <th>Tài khoản Paypal</th>
                                                    <th>Quyền hạn</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${not empty accounts}">
                                                    <c:forEach var="account" items="${accounts}" varStatus="counter">
                                                        <tr class="odd gradeX">
                                                            <td>${counter.count}</td>
                                                            <td>${account.accountID}</td> 
                                                            <td>${account.status}</td>
                                                            <td>${account.fullName}</td>
                                                            <td>${account.address}</td>
                                                            <td>${account.phone}</td>
                                                            <td>${account.email}</td>
                                                            <td>${account.paypalAccount}</td>
                                                            <td>
                                                                <c:if test="${account.role == 'storeOwner'}">
                                                                    Chủ cửa hàng
                                                                </c:if>
                                                                <c:if test="${account.role == 'member'}">
                                                                    Người dùng
                                                                </c:if>                              
                                                            </td>    
                                                            <td>
                                                                <a data-status ="${account.status}" data-account ="${account.accountID}" data-email="${account.email}" data-paypal ="${account.paypalAccount}" data-phone ="${account.phone}" data-address ="${account.address}" data-name ="${account.fullName}" data-toggle="modal" data-target="#EditAccountModel" class="btn btn-danger editAccount">
                                                                    Sửa
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>                              
                            </div>
                        </div>
                        <!-- END PAGE CONTENT-->
                    </div>
                </div>
                <div id="addAccountModel" class="modal face bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h1 class="text-center">Thêm Tài Khoản</h1>
                            </div>
                            <div style="margin-bottom: 50px" class="modal-body">
                                <div class="row">
                                    <form id="form_sample_2" class="form-horizontal form-without-legend" action="AddAccountServlet" method="GET"> 
                                        <div class="form-body">
                                            <div class="alert alert-danger display-hide">
                                                <button class="close" data-close="alert"></button>
                                                Thông tin nhập bị lỗi, vui lòng kiểm tra lại.
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-lg-2"> Tên đăng nhập:<span class="require">*</span> </label>
                                                <div class="col-md-3 col-lg-3">
                                                    <div class="input-icon right">
                                                        <i class="fa"></i>
                                                        <input class="form-control" name="accountID" type="text">
                                                    </div>                                                  
                                                </div>
                                                <label class="control-label col-md-2 col-lg-2"> Mật Khẩu: <span class="require">*</span></label>
                                                <div class="col-md-3 col-lg-3">
                                                    <div class="input-icon right">
                                                        <i class="fa"></i>
                                                        <input class="form-control" name="password" type="text">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-lg-2"> Điện thoại: </label>
                                                <div class="col-md-3 col-lg-3">
                                                    <div class="input-icon right">
                                                        <i class="fa"></i>
                                                        <input class="form-control" name="phone" type="text">
                                                    </div>                                                  
                                                </div>
                                                <label class="control-label col-md-2 col-lg-2"> Email: </label>
                                                <div class="col-md-4 col-lg-4">
                                                    <div class="input-icon right">
                                                        <i class="fa"></i>
                                                        <input class="form-control" name="email" type="text">
                                                    </div>                   
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-lg-2"> Tên: </label>
                                                <div class="col-md-3 col-lg-3">
                                                    <input class="form-control" name="fullName" type="text">
                                                </div>
                                                <label class="control-label col-md-2 col-lg-2"> Địa chỉ: </label>
                                                <div class="col-lg-4 col-md-4">
                                                    <textarea  rows="3" name="address" type="text" class="form-control"></textarea>
                                                </div>
                                            </div>   
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-lg-2"> Tài khoản PayPal: </label>
                                                <div class="col-md-3 col-lg-3">
                                                    <input class="form-control" name="paypalAccount" type="text">
                                                </div>
                                                <label class="control-label col-md-2 col-lg-2"> Quyền hạn:  <span class="require">*</span></label>
                                                <div class="col-md-4 col-lg-4">                                                       <select name="role" class="form-control">
                                                            <option value="storeOwner">Chủ cửa hàng</option>
                                                            <option value="member">Thành viên</option>
                                                        </select>                     
                                                </div>
                                            </div>
                                            <button style="float: right;margin-right: 75px;margin-top: 20px;width: 150px" class="btn btn-primary" type="submit">Hoàn tất</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="EditAccountModel" class="modal face bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h1 id="aTitle" class="text-center">Sửa Tài Khoản</h1>
                            </div>
                            <div style="margin-bottom: 50px" class="modal-body">
                                <div class="row">
                                    <form class="form-horizontal form-without-legend" action="EditAccountServlet" method="POST">                       
                                        <div class="form-group">
                                            <label class="control-label col-md-2 col-lg-2"> Điện thoại: </label>
                                            <div class="col-md-3 col-lg-3">
                                                <input name="accountID" id="aAccount" type="hidden"/>
                                                <input id="aPhone" class="form-control" name="phone" type="text">
                                            </div>
                                            <label class="control-label col-md-2 col-lg-2"> Email: </label>
                                            <div class="col-md-4 col-lg-4">
                                                <input id="aEmail" class="form-control" name="email" type="text">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-2 col-lg-2"> Tên: </label>
                                            <div class="col-md-3 col-lg-3">
                                                <input id="aName" class="form-control" name="fullName" type="text">
                                            </div>
                                            <label class="control-label col-md-2 col-lg-2"> Địa chỉ: </label>
                                            <div class="col-lg-4 col-md-4">
                                                <textarea id="aAddress"  rows="3" name="address" type="text" class="form-control"></textarea>
                                            </div>
                                        </div>   
                                        <div class="form-group">
                                            <label class="control-label col-md-2 col-lg-2"> Tài khoản PayPal: </label>
                                            <div class="col-md-3 col-lg-3">
                                                <input id="aPaypal" class="form-control" name="paypalAccount" type="text">
                                            </div>
                                        </div>                   
                                        <button style="float: right;margin-right: 75px;margin-top: 20px;width:150px" class="btn btn-danger" type="submit">Hoàn tất</button>
                                        <div id="activeAccount">
                                        </div>                                                               
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer">
            <div class="page-footer-inner">
                2015 &copy; Group 8 Capstone Project
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>

        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
        <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
        <script src="assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>

        <script type="text/javascript" src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/jquery-validation/js/additional-methods.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>

        <!-- END CORE PLUGINS -->
        <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
        <script src="assets/scripts/accountTable.js"></script>
        <script src="assets/scripts/validateManageAccount.js"></script>
        <script>
            jQuery(document).ready(function () {
                // initiate layout and plugins
                Metronic.init(); // init metronic core components
                Layout.init(); // init current layout
                QuickSidebar.init(); // init quick sidebar
                Demo.init(); // init demo features
                TableManaged.init();
                FormValidation.init();
            });
        </script>
    </body>
</html>
<script>
    $(document).on("click", ".editAccount", function () {
        $('#aPhone').val($(this).data('phone'));
        $('#aEmail').val($(this).data('email'));
        $('#aName').val($(this).data('name'));
        $('#aAddress').val($(this).data('address'));
        $('#aPaypal').val($(this).data('paypal'));
        $('#aAccount').val($(this).data('account'));
        $('#aTitle').html('Sửa tài khoản  ' + $(this).data('account'));
        var status = $(this).data('status');
        var accountID = $(this).data('account');
        if (status == 'active') {
            $('#activeAccount').html('<a href="DeactiveAccountServlet?accountID=' + accountID + '" style="float: right;margin-right: 30px;margin-top: 20px;width:150px" class="btn btn-primary">Hủy kích hoạt</a>');
        } else if (status == 'deactive') {
            $('#activeAccount').html('<a href="ActiveAccountServlet?accountID=' + accountID + '" style="float: right;margin-right: 30px;margin-top: 20px;width:150px" class="btn btn-primary">Kích hoạt</a>');
        }
    });
</script>
