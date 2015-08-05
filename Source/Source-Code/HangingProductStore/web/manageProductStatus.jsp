<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
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
        <!-- END THEME STYLES -->
        <!-- END THEME STYLES -->
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
        <!-- BEGIN SET PARAMETER -->
        <c:if test="${empty sessionScope.ACCOUNT}">
            <c:redirect url="./HomeServlet"/>
        </c:if>
        <c:if test="${sessionScope.ACCOUNT.role != 'storeOwner'}">
            <c:redirect url="./HomeServlet"/>
        </c:if>
        <input type="hidden" id="currentTab" value="${requestScope.currentTab}">
        <input type="hidden" id="status" value="${requestScope.status}">
        <c:set var="account" value="${sessionScope.ACCOUNT}"></c:set>
            <!-- END SET PARAMETER -->
            <!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <!-- BEGIN HEADER INNER -->
                <div class="page-header-inner">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a style="text-decoration: none;color:white;font-size: 18px;line-height: 25px;margin-top: 6px" href="#">
                            Hanging Product Store
                        </a>
                    </div>

                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                    <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">${sessionScope.ACCOUNT.fullName}</span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="extra_profile.html">
                                        <i class="icon-user"></i> My Profile </a>
                                </li>
                            </ul>                           
                        </li>
                        <li class="dropdown dropdown-user">
                            <a href="LogoutServlet" class="dropdown-toggle">
                                <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">Đăng xuất</span>
                            </a>                      
                        </li>
                    </ul>
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
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <div class="page-sidebar navbar-collapse collapse">
                    <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                        <li class="sidebar-toggler-wrapper" class="sidebar-toggler-wrapper">
                            <div class="sidebar-toggler">
                            </div>->
                        </li>
                        <li class="start">
                            <a href="javascript:;">
                                <i class="icon-rocket"></i>
                                <span class="title">Quản lí yêu cầu</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li id="request">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=request">Chưa duyệt</a>
                                </li>
                                <li id="accepted">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=accepted">Đã duyệt</a>
                                </li>
                                <li id="refuse">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=refuse">Từ chối</a>
                                </li>
                                <li id="cancel">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=cancel">Đã hủy</a>
                                </li>
                            </ul>
                        </li>
                        <li class="open active">
                            <a href="javascript:;">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lí hàng kí gửi</span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu open">
                                <li id="available">
                                    <a href="ManageProduct?currentTab=available">Chờ duyệt</a>
                                </li>
                                <li id="onWeb">
                                    <a href="ManageProduct?currentTab=onWeb">Trên web</a>
                                </li>
                                <li id="ordered">
                                    <a href="ManageProduct?currentTab=ordered">Đã được đặt</a>
                                </li>
                                <li id="sold">
                                    <a href="ManageProduct?currentTab=sold">Đã bán</a>
                                </li>
                                <li id="canceled">
                                    <a href="ManageProduct?currentTab=canceled">Đăng kí hủy kí gửi</a>
                                </li>
                                <li id="completed">
                                    <a href="ManageProduct?currentTab=completed">Hoàn tất thanh toán</a>
                                </li>
                                <li id="expired">
                                    <a href="ManageProduct?currentTab=expired">Hết hạn kí gửi</a>
                                </li>
                            </ul>
                        </li>
                        <li class="last">
                            <a href="javascript:;">
                                <i class="icon-bar-chart"></i>
                                <span class="title">Thống kê</span>
                                <span class="arrow "></span>
                            </a>
                            <ul class="sub-menu">
                                <li id="consignment">
                                    <a href="Statistics?currentTab=consignment">Yêu cầu kí gửi</a>
                                </li>
                                <li id="product">
                                    <a href="Statistics?currentTab=product">Sản phẩm ký gửi</a>
                                </li>
                            </ul>
                        </li>								
                    </ul>
                    <!-- END SIDEBAR MENU -->
                </div>
                <!-- BEGIN ALERT DIALOG -->
                <div>
                    <div class="alert alert-success" id="success-alert" style="display: none; float: right">
                        <button type="button" class="close" data-dismiss="alert">x</button>
                        <strong>Thao tác thành công!</strong>
                    </div>
                    <div class="alert alert-danger" id="fail-alert" style="display: none; float: right">
                        <button type="button" class="close" data-dismiss="alert">x</button>
                        <strong>Thao tác thất bại!</strong>
                    </div>
                </div>
                <!-- END ALERT DIALOG -->
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <div class="portlet box blue">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-globe"></i>Quản lí sản phẩm 
                                        <c:choose>
                                            <c:when test="${requestScope.currentTab == 'available'}">
                                                chờ duyệt
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'onWeb'}">
                                                trên web
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'ordered'}">
                                                đã được đặt
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'sold'}">
                                                đã bán
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'completed'}">
                                                hoàn tất thanh toán
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'expired'}">
                                                hết hạn kí gửi
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'canceled'}">
                                                đăng kí hủy kí gửi
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <!-- BEGIN EXPIRED TAB-->
                                <div class="portlet-body" id="expired" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=completed"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm hoàn tất thanh toán</a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="expiredTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Tên khách hàng</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Giá kí gửi (Ngàn đồng)</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.expired}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td class="center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td>${item.name}</td>
                                                    <td class="center">${item.reviewProductDate}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td><fmt:formatNumber 
                                                            value="${item.negotiatedPrice}" 
                                                            maxFractionDigits="1"/>
                                                    </td>
                                                    <td><button class="btn btn-info expiredModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END EXPIRED TAB-->
                                <!-- BEGIN AVAILABLE TAB-->
                                <div class="portlet-body" id="available" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="right" style="float: right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=onWeb">Sản phẩm trên web <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="availableTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Tên khách hàng</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Giá kí gửi (Ngàn đồng)</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.available}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td class="center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td>${item.name}</td>
                                                    <td class="center">${item.reviewProductDate}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td>
                                                        <fmt:formatNumber 
                                                            value="${item.negotiatedPrice}" 
                                                            maxFractionDigits="1"/>
                                                    </td>
                                                    <td><button class="btn btn-info availableModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END AVAILABLE TAB-->
                                <!-- BEGIN ONWEB TAB-->
                                <div class="portlet-body" id="onWeb" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=available"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm chờ duyệt</a>
                                        </div>
                                        <div class="col-md-6 col-sm-6" align="right" style="float: right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=ordered">Sản phẩm đã được đặt <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="onWebTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày đăng lên web</th>
                                                <th>Thời gian kí gửi</th>
                                                <th>Mã kí gửi</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.onWeb}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td style="text-align: center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td class="center">${item.raiseWebDate}</td>
                                                    <td>${item.period}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td><button class="btn btn-info onWebModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END ONWEB TAB-->
                                <!-- BEGIN ORDERED TAB-->
                                <div class="portlet-body" id="ordered" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=onWeb"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm trên web</a>
                                        </div>
                                        <div class="col-md-6 col-sm-6" align="right" style="float: right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=sold">Sản phẩm đã bán <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="orderedTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Giá sản phẩm (Ngàn đồng)</th>
                                                <th>Mã kí gửi</th>
                                                <th>Số người đặt</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.ordered}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td class="center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td>
                                                        <fmt:formatNumber 
                                                            value="${item.product.negotiatedPrice}" 
                                                            maxFractionDigits="1"/>
                                                    </td>
                                                    <td>${item.product.consignmentID}</td>
                                                    <td>${item.quantity}</td>
                                                    <td><button class="btn btn-info orderedModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.product.productID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END ORDERED TAB-->
                                <!-- BEGIN CANCEL TAB-->
                                <div class="portlet-body" id="canceled" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=sold"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm đã bán</a>
                                        </div>
                                        <div class="col-md-6 col-sm-6" align="right" style="float: right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=completed">Sản phẩm hoàn tất thanh toán <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="canceledTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày hủy</th>
                                                <th>Ngày nhận hàng</th>
                                                <th>Mã kí gửi</th>
                                                <th>TT liên lạc</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.canceled}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td class="center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td class="center">${item.cancelDate}</td>
                                                    <td class="center">${item.reviewProductDate}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td>
                                                        <c:if test="${item.phone!=null}">
                                                            ${item.phone}
                                                        </c:if>
                                                        <c:if test="${item.phone==null && item.email!=null}">
                                                            ${item.email}
                                                        </c:if>
                                                    </td>
                                                    <td><button class="btn btn-info cancelModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END CANCEL TAB-->
                                <!-- BEGIN COMPLETED TAB-->
                                <div class="portlet-body" id="completed" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=canceled"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm hủy kí gửi</a>
                                        </div>
                                        <div class="col-md-6 col-sm-6" align="right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=expired">Sản phẩm hết hạn kí gửi<i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="completedTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.completed}" varStatus="counter">
                                                <tr>
                                                    <td>${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td class="center">${item.reviewProductDate}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td><c:choose>
                                                            <c:when test="${item.consignmentStatusID==4}">
                                                                Đã bán thành công
                                                            </c:when>
                                                            <c:when test="${item.consignmentStatusID==5}">
                                                                Đã bán thành công
                                                            </c:when>
                                                            <c:when test="${item.consignmentStatusID==6}">
                                                                Khách hàng từ chối gia hạn
                                                            </c:when>
                                                            <c:when test="${item.consignmentStatusID==7}">
                                                                Khách hàng hủy kí gửi
                                                            </c:when>   
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END COMPLETED TAB-->
                                <!-- BEGIN SOLD TAB-->
                                <div class="portlet-body" id="sold" style="display: none;">
                                    <div class="row" >
                                        <div class="col-md-6 col-sm-6" align="left">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=ordered"><i class="m-icon-swapleft m-icon-white"></i> Sản phẩm đã được đặt</a>
                                        </div>
                                        <div class="col-md-6 col-sm-6" align="right">
                                            <a class="btn  btn-primary" href="ManageProduct?currentTab=canceled">Sản phẩm hủy kí gửi <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br>
                                    <table class="table table-striped table-hover" id="soldTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Giá bán (Ngàn đồng)</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.sold}" varStatus="counter">
                                                <tr>
                                                    <td class="center">${counter.count}</td>
                                                    <td>${item.product.name}</td>
                                                    <td>${item.reviewProductDate}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td>
                                                        <fmt:formatNumber 
                                                            value="${item.product.sellingPrice}" 
                                                            maxFractionDigits="1"/>
                                                    </td>
                                                    <td><button class="btn btn-info soldModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END SOLD TAB-->
                            </div>
                            <!-- END EXAMPLE TABLE PORTLET-->
                        </div>
                    </div>
                </div>
                <!-- BEGIN ALL MODALS -->
                <div id="modal">
                    <!-- SOLD MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="soldModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Thông tin sản phẩm</h4>        
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6">
                                            <h5><strong><u>Thông tin người kí gửi</u></strong></h5>
                                            Họ tên : <strong id="sold_fullName"></strong><br>
                                            Địa chỉ : <strong id="sold_address"></strong><br>
                                            Số điện thoại : <strong id="sold_phone"></strong><br>
                                            Email : <strong id="sold_email"></strong><br>
                                            Tài khoản Paypal : <strong id="sold_paypalAccount"></strong>
                                        </div>
                                        <div class="col-sm-6 col-md-6">
                                            <h5><strong><u>Thông tin sản phẩm</u></strong></h5>
                                            Tên sản phẩm : <strong id="sold_productName"></strong><br>
                                            Mã kí gửi : <strong id="sold_consignmentID"></strong><br>
                                            Giá sản phẩm (Ngàn đồng): <strong id="sold_negotiatedPrice"></strong><br>
                                            Giá bán (Ngàn đồng): <strong id="sold_sellingPrice"></strong><br>
                                            Ngày kí gửi : <strong id="sold_receivedDate"></strong><br>
                                            Tiền trả khách hàng (Ngàn đồng): <input type="text" id="sold_returnPrice" disabled="disabled">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <div class="row">
                                        <div style="float: right; margin: 0px 5px;">
                                            <form action="SoldProduct" method="POST">
                                                <input type="hidden" name="txtReturnPrice" id="sold_returnPrice1" value=""/>
                                                <input type="hidden" name="txtConsignmentID" id="soldconsignmentID" value=""/>
                                                <button class="btn btn-primary" name="btnAction" type="submit" value="pay">Trả tiền</button>
                                                <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px"/>
                                            </form>
                                        </div>
                                        <div style="float: right" style="display: none" id="paypal_form">
                                            <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="POST">
                                                <input type="hidden" name="cmd" value="">
                                                <input type="hidden" name="business" value="">
                                                <input type="hidden" name="return" value="">
                                                <input type="hidden" name="rm" value=""/>
                                                <input type="hidden" name="item_name" value="">
                                                <input type="hidden" name="item_number" value="">
                                                <input type="hidden" name="amount" value="">
                                                <input type="hidden" name="currency_code" value="">
                                                <button class="btn btn-default" type="submit">Thanh toán qua Paypal</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- SOLD MODAL END-->
                    <!-- ORDERED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="orderedModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <form action="OrderProduct" method="POST">
                                    <div class="modal-header">
                                        <h4>Thông tin đặt hàng</h4>
                                        Giá kí gửi (Ngàn đồng) : <label id="ordered_negotiatedPrice"></label>
                                        <i id="sendPriceLabel">Giá gửi khách hàng (Ngàn đồng) : <input type="text" id="sendPrice" name="txtSendPrice"></i>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table table-striped table-bordered table-hover" id="listOrderedTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th></th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Ngày đặt mua</th>
                                                    <th>Thông tin liên hệ</th>
                                                    <th id="theadDetail">Chi tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody id="table_body_ordered">
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtOrderID" value="" id="ordered_orderID">
                                        <button class="btn btn-primary" name="btnAction" type="submit" value="sendPrice" onclick="return checkCustomer2();" id="btnPrice">Gửi giá</button>
                                        <button class="btn btn-warning" name="btnAction" type="submit" value="cancel">Hủy đơn hàng</button>
                                        <input class="btn btn-info confirmOrderedModal" type="button" data-togle="modal" value="Hoàn tất thanh toán" onclick="return checkCustomer1();">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- ORDERED MODAL END-->
                    <!-- CONFIRM ORDERED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmOrderedModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <form action="OrderProduct" method="POST">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4>Thông tin giá bán</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <label class="control-label">Giá bán (Ngàn đồng):</label><input id="sellingPrice" type="text" name="txtSellingPrice" value ="" style="width: 300px;">
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtOrderID" id="order_OrderID">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="order" onclick="return validateSellingPrice();">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM ORDERED MODAL END-->
                    <!-- CANCEL MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="cancelModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Thông tin hủy kí gửi</h4>        
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <h5><strong><u>Thông tin người kí gửi</u></strong></h5>
                                            Họ tên : <strong id="cancel_fullName"></strong><br>
                                            Địa chỉ : <strong id="cancel_address"></strong><br>
                                            Số điện thoại : <strong id="cancel_phone"></strong><br>
                                            Email : <strong id="cancel_email"></strong>
                                        </div>
                                        <div class="col-sm-6">
                                            <h5><strong><u>Thông tin hàng kí gửi</u></strong></h5>
                                            Tên sản phẩm : <strong id="cancel_productName"></strong><br>
                                            Mã hàng kí gửi : <strong id="cancel_consignmentID"></strong><br>
                                            Giá kí gửi (Ngàn đồng): <strong id="cancel_negotiatedPrice"></strong><br>
                                            Ngày nhận hàng : <strong id="cancel_consignedDate"></strong><br>
                                            Ngày hủy kí gửi : <strong id="cancel_canceledDate"></strong><br>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <div class="row">
                                        <div style="float: right; margin-right: 25px">
                                            <form action="CancelProduct" method="POST">
                                                <input type="hidden" name="txtConsignmentID" id="cancel_ID" value="">
                                                <button id="btnAgree" class="btn btn-info" name="btnAction" type="submit" value="cancel" style="display: none">Đồng ý hủy</button>
                                                <button id="btnDecline" class="btn btn-warning" name="btnAction" type="submit" value="notCancel" style="display: none">Không đồng ý hủy</button>
                                                <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                            </form>
                                        </div>
                                        <div style="float: right; margin: 0px 5px;">
                                            <button id="btnReturn" class="btn btn-info receiveProductModal" data-toggle="modal" style="display: none">Trả hàng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- CANCEL MODAL END-->
                    <!-- AVAILABLE MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="availableModal" aria-hidden="true">
                        <form action="PublishProduct" method="POST" enctype="multipart/form-data" onsubmit="return getSeasonAvai();">
                            <input type="hidden" value="available" name="btnAction">
                            <input type="hidden" id="avai_ProductID" value="" name="txtProductID">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4>Thông tin sản phẩm</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <div class="tab-content">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label for="txtProductName" class="col-sm-4 control-label">Tên sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_ProductName" type="text" class="form-control" maxlength="50" name="txtProductName"/>
                                                                <p class="help-block" id="er_avai_ProductName" style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txtSerial" class="col-sm-4 control-label">Số seri </label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_SerialNumber" type="text" class="form-control" name="txtSerialNumber"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Ngày mua hàng</label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group date date-picker">
                                                                    <input id="avai_BoughtDate" type="text" class="form-control" name="txtDate" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Loại sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <c:set var="parentCat" value="${requestScope.parentCat}"/>
                                                                <c:set var="allCat" value="${requestScope.allCat}"/>
                                                                <select id="avai_Category" name="txtCategory"style="width: 120px">
                                                                    <c:forEach var="parent" items="${parentCat}">
                                                                        <optgroup label="${parent.categoryName}">
                                                                            <c:forEach var="item" items="${allCat}">
                                                                                <c:if test="${item.parentId == parent.categoryId}">
                                                                                    <option id="${item.categoryId}" value="${item.categoryId}">${item.categoryName}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </optgroup>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Hãng</label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_Brand" type="text" class="form-control" maxlength="26" name="txtBrand"/>
                                                                <p class="help-block" id="er_avai_Brand"style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mùa </label>
                                                            <div class="col-sm-8">
                                                                <c:forEach var="item" items="${requestScope.season}">
                                                                    <div class="col-sm-3 seasonDiv">
                                                                        <label>
                                                                            <input style="width: 8%" id="chkSeason${item.seasonID}"type="checkbox" name="chkSeason" value="${item.seasonID}"/>${item.seasonName}
                                                                        </label>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Tự động gửi giá</label>
                                                            <div class="col-sm-8">
                                                                <label class="radio-inline">
                                                                    <input type="radio" name="rdSendPrice_1" id="rdIsSpecial1" value="isSpecial"> Có </label>
                                                                <label class="radio-inline">
                                                                    <input type="radio" name="rdSendPrice_1" id="rdNotSpecial1" value="notSpecial" checked> Không </label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mô tả </label>
                                                            <div class="col-sm-8">
                                                                <textarea id="avai_Description" class="form-control" maxlength="225" rows="6" placeholder="" name="txtDescription"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-4 col-sm-4">Ảnh sản phẩm</label>
                                                            <div class="col-md-8 col-sm-8" align="center">
                                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                    <div class="fileinput-new thumbnail">
                                                                        <img src="" id="avai_Image"/>
                                                                    </div>
                                                                    <div >
                                                                        <span class="btn btn-info btn-file" style="width: 100%">
                                                                            <input type="file" accept="image/*" name="avai_txtImage" onchange="readURL1(this);" style="max-width: "/>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-info" type="submit">Duyệt</button>
                                        <input type="hidden" name="txtSeasonList" id="avai_seasonID">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- AVAILABLE MODAL END-->
                    <!-- EXPIRED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="expiredModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Thông tin sản phẩm</h4>        
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6" style="padding-left:45px">
                                            <h5><strong><u>Thông tin người kí gửi</u></strong></h5>
                                            Họ tên : <strong id="expired_fullName"></strong><br>
                                            Địa chỉ : <strong id="expired_address"></strong><br>
                                            Số điện thoại : <strong id="expired_phone"></strong><br>
                                            Email : <strong id="expired_email"></strong>
                                        </div>
                                        <div class="col-sm-6" style="padding-right:45px">
                                            <h5><strong><u>Thông tin hàng kí gửi</u></strong></h5>
                                            Tên sản phẩm : <strong id="expired_productName"></strong><br>
                                            Mã hàng kí gửi : <strong id="expired_consignmentID"></strong><br>
                                            Ngày kí gửi : <strong id="expired_consignedDate"></strong><br>
                                            Giá thỏa thuận (Ngàn đồng): <strong id="expired_negotiatedPrice"></strong><br>
                                            Số ngày quá hạn: <strong id="expired_days"></strong> ngày
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form>
                                        <input class="btn btn-info confirmExtendModal" type="button" data-togle="modal" value="Gia hạn">
                                        <input class="btn btn-warning confirmReceiveModal" type="button" data-togle="modal" value="Nhận hàng">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- EXPIRED MODAL END-->
                    <!-- CONFIRM EXTEND MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmExtendModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <form action="ExtendProduct" method="POST">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4>Thời hạn kí gửi</h4>
                                    </div>
                                    <div class="modal-body">
                                        Tiền lưu kho trong <strong id="expired_period"></strong> ngày hết hạn là <strong id="expired_fees"></strong> ngàn đồng.<br>
                                        Sản phẩm sẽ được gia hạn thêm 30 ngày kể từ ngày hôm nay. Bạn có chắc chắn muốn gia hạn sản phẩm này?
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="expired_extendConsignmentID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="extend">Gia hạn</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM EXTEND MODAL END-->
                    <!-- CONFIRM RECEIVE MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmReceiveModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <form action="ExtendProduct" method="POST" onsubmit="return validationPrice();">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4>Thông tin tiền phạt</h4>
                                    </div>
                                    <div class="modal-body">
                                        <label class="control-label">Tiền phạt (Ngàn đồng):</label><input type="text" id="expired_fee" value="" name="txtExpiredFee">
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="expired_receiveConsignmentID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="receive">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM RECEIVE MODAL END-->
                    <!-- CANCEL PRODUCT ONWEB MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="onWebModal" aria-hidden="true">
                        <form action="PublishProduct" method="POST" enctype="multipart/form-data" onsubmit="return getSeasonOnWeb();">
                            <input type="hidden" value="onWeb" name="btnAction">
                            <input type="hidden" id="onWeb_ProductID" value="" name="txtProductID">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4>Thông tin sản phẩm</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <div class="tab-content">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label for="txtProductName" class="col-sm-4 control-label">Tên sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <input id="onWeb_ProductName" type="text" class="form-control" maxlength="50" name="txtProductName"/>
                                                                <p class="help-block" id="er_OnWeb_ProductName"style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txtSerial" class="col-sm-4 control-label">Số seri </label>
                                                            <div class="col-sm-8">
                                                                <input id="onWeb_SerialNumber" type="text" class="form-control" name="txtSerialNumber"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Ngày mua hàng</label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group date date-picker">
                                                                    <input id="onWeb_BoughtDate" type="text" class="form-control" name="txtDate" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Loại sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <c:set var="parentCat" value="${requestScope.parentCat}"/>
                                                                <c:set var="allCat" value="${requestScope.allCat}"/>
                                                                <select id="onWeb_Category" name="txtCategory"style="width: 120px">
                                                                    <c:forEach var="parent" items="${parentCat}">
                                                                        <optgroup label="${parent.categoryName}">
                                                                            <c:forEach var="item" items="${allCat}">
                                                                                <c:if test="${item.parentId == parent.categoryId}">
                                                                                    <option id="onWeb_${item.categoryId}" value="${item.categoryId}">${item.categoryName}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </optgroup>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Hãng</label>
                                                            <div class="col-sm-8">
                                                                <input id="onWeb_Brand" type="text" class="form-control" maxlength="26" name="txtBrand"/>
                                                                <p class="help-block" id="er_OnWeb_Brand"style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mùa </label>
                                                            <div class="col-sm-8">
                                                                <c:forEach var="item" items="${requestScope.season}">
                                                                    <div class="col-sm-3 seasonDiv">
                                                                        <label>
                                                                            <input style="width: 8%" id="onWeb_chkSeason${item.seasonID}" type="checkbox" name="chkSeason" value="${item.seasonID}"/>${item.seasonName}
                                                                        </label>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Tự động gửi giá</label>
                                                            <div class="col-sm-8">
                                                                <label class="radio-inline">
                                                                    <input type="radio" name="rdSendPrice_2" id="sendPriceTrue_2" value="isSpecial"> Có </label>
                                                                <label class="radio-inline">
                                                                    <input type="radio" name="rdSendPrice_2" id="sendPriceFalse_2" value="notSpecial"> Không </label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mô tả </label>
                                                            <div class="col-sm-8">
                                                                <textarea id="onWeb_Description" class="form-control" maxlength="225" rows="6" placeholder="" name="txtDescription"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-4 col-sm-4">Ảnh sản phẩm</label>
                                                            <div class="col-md-8 col-sm-8" align="center">
                                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                    <div class="fileinput-new thumbnail">
                                                                        <img src="" id="onWeb_Image"/>
                                                                    </div>
                                                                    <div >
                                                                        <span class="btn btn-info btn-file" style="width: 100%">
                                                                            <input type="file" name="onweb_txtImage" onchange="readURL2(this);" style="max-width: "/>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input class="btn btn-warning confirmOnWebModal" type="button" data-togle="modal" value="Hủy kí gửi">
                                        <button class="btn btn-primary" type="submit">Cập nhật</button>
                                        <input type="hidden" name="txtSeasonList" id="onWeb_seasonID">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- CANCEL PRODUCT ONWEB MODAL END-->
                    <!-- CONFIRM CANCEL PRODUCT ONWEB MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmOnWebModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <form action="CancelProductOnWeb" method="POST" onsubmit="return validateCancelPrice();">
                                    <div class="modal-header">
                                        <h4>Hủy kí gửi</h4>
                                    </div>
                                    <div class="modal-body">
                                        <h5>Bạn có chắc chắn muốn hủy kí gửi sản phẩm với mã kí gửi <label id="confirmCancel_ConsignmentID1"></label>?</h5>
                                        <h5>Tiền phạt (Ngàn đồng): <input id="confirmCancel_Fee" name="txtCancelFee"></h5>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" value="" name="txtConsignmentID" id="confirmCancel_ConsignmentID2">
                                        <button class="btn btn-success" type="submit" name="btnAction" value="receive">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- CONFIRM CANCEL PRODUCT ONWEB MODAL END-->
                </div>
                <!-- END ALL MODALS -->
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
            <!-- END FOOTER -->
            <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
            <!-- BEGIN CORE PLUGINS -->
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

            <script type="text/javascript" src="assets/global/plugins/select2/select2.min.js"></script>
            <script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
            <script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>

            <!-- END CORE PLUGINS -->
            <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
            <script src="assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
            <script src="assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
            <script src="assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
            <script src="assets/admin/pages/scripts/table-managed.js"></script>
            <!-- END CORE PLUGINS -->
            <script>
                                    jQuery(document).ready(function () {
                                        // initiate layout and plugins
                                        // initiate layout and plugins
                                        Metronic.init(); // init metronic core components
                                        Layout.init(); // init current layout
                                        QuickSidebar.init(); // init quick sidebar
                                        Demo.init(); // init demo features
                                        TableManaged.init();
                                    });
            </script>
            <script>
                //script switch tab
                $(document).ready(function () {
                    var currentTab = window.location.hash.substring(1);
                    if (currentTab == "") {
                        currentTab = $('#currentTab').val();
                    }
                    $('div#' + currentTab).fadeIn(400).siblings().hide();
                    $('div.portlet-title').show();
                    $('li#' + currentTab).addClass('open active').siblings().removeClass('open active');
                    $('html,body').scrollTop(0);
                    var status = $("#status").val();
                    if (status.length > 0) {
                        if (status.localeCompare('success')) {
                            $("#success-alert").fadeTo(2000, 500).slideUp(500, function () {
                                $("#success-alert").alert('close');
                            });
                        } else {
                            $("#fail-alert").fadeTo(2000, 500).slideUp(500, function () {
                                $("#success-alert").alert('close');
                            });
                        }
                    }
                });
                //start cancel modal
                $(document).on("click", ".cancelModal", function () {
                    var consignmentID = $(this).data('id');
                    $.get('LoadCancelProduct', {consignmentID: consignmentID}, function (response) {
                        var product = response.product;
                        $("#cancel_fullName").text(response.name);
                        $("#cancel_address").text(response.address);
                        $("#cancel_phone").text(response.phone);
                        $("#cancel_email").text(response.email);
                        $("#cancel_productName").text(product.name);
                        $("#cancel_consignmentID").text(product.consignmentID);
                        $("#cancel_negotiatedPrice").text(product.negotiatedPrice);
                        $("#cancel_consignedDate").text(product.receivedDate);
                        $("#cancel_canceledDate").text(product.cancelDate);
                        $("#cancel_ID").val(product.consignmentID);
                        if (response.product.productStatusID < 8) {
                            $("#btnAgree").removeAttr("style");
                            $("#btnDecline").removeAttr("style");
                            $("#btnReturn").removeAttr("style");
                            $("#btnReturn").attr("style", "display:none;");
                        } else {
                            $("#btnReturn").removeAttr("style");
                            $("#btnDecline").removeAttr("style");
                            $("#btnDecline").attr("style", "display:none;");
                            $("#btnAgree").removeAttr("style");
                            $("#btnAgree").attr("style", "display:none;");
                        }
                    });
                    $('#cancelModal').modal('show');
                });
                //end cancel modal
                //start available modal
                $(document).on("click", ".availableModal", function () {
                    setSeason();
                    $("#er_avai_ProductName").html('');
                    $("#er_avai_Brand").html('');
                    var productID = $(this).data('id');
                    $.get('LoadAvailableProduct', {productID: productID}, function (response) {
                        $("#avai_ProductName").val(response.name);
                        $("#avai_ProductID").val(response.productID);
                        $("#avai_SerialNumber").val(response.serialNumber);
                        $("#avai_BoughtDate").val(response.purchasedDate);
                        $("#avai_Brand").val(response.brand);
                        $("#avai_Description").val(response.description);
                        $("#avai_Image").attr("src", response.image);
                        var option = "option#" + response.categoryID;
                        $(option).attr("selected", "selected");
                        if (response.isSpecial < 1) {
                            $('#rdIsSpecial1').parent('span').addClass('checked');
                            $('#rdNotSpecial1').parent('span').removeClass('checked');
                        } else {
                            $('#rdIsSpecial1').parent('span').removeClass('checked');
                            $('#rdNotSpecial1').parent('span').addClass('checked');
                        }
                    });
                    $('#availableModal').modal('show');
                });
                function readURL1(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#avai_Image').attr('src', e.target.result);
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }
                ;
                function readURL2(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#onWeb_Image').attr('src', e.target.result);
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }
                ;
                //end available modal
                //start ordered modal
                $(document).on("click", ".orderedModal", function () {
                    var productID = $(this).data('id');
                    $.get('LoadOrderedProduct', {productID: productID}, function (response) {
                        var isSpecial = response.isSpecial;
                        if (isSpecial == 0) {
                            $("#sendPriceLabel").attr("style", "display:block;");
                            $("#btnPrice").removeAttr("style");
                            $("#theadDetail").attr("style", "display:block;");
                        } else {
                            $("#sendPriceLabel").attr("style", "display:none;");
                            $("#btnPrice").attr("style", "display:none;");
                            $("#theadDetail").attr("style", "display:none;");
                        }
                        var orderList = response.orderList;
                        $('#ordered_orderID').val(response.orderList[0].orderID);
                        $('#ordered_negotiatedPrice').text(response.negotiatedPrice);
                        $('#listOrderedTable tbody').empty();
                        for (var i = 0, max = orderList.length; i < max; i++) {
                            var row = "";
                            if (isSpecial == 0) {
                                if (orderList[i].sendPrice == 0) {
                                    row = '<tr><td><input type="checkbox" name="chkboxCustomer" value="' +
                                            orderList[i].orderID + '"></td><td>' +
                                            orderList[i].fullName + '</td><td>' +
                                            orderList[i].orderedDate + '</td><td>' +
                                            orderList[i].phone + '</td><td>Chưa gửi giá</td></tr>';
                                } else {
                                    row = '<tr><td><input type="checkbox" name="chkboxCustomer" value="' +
                                            orderList[i].orderID + '"></td><td>' +
                                            orderList[i].fullName + '</td><td>' +
                                            orderList[i].orderedDate + '</td><td>' +
                                            orderList[i].phone + '</td><td>Đã gửi giá : ' +
                                            orderList[i].sendPrice + '</td></tr>';
                                }
                            }
                            else {
                                row = '<tr><td><input type="checkbox" name="chkboxCustomer" value="' +
                                        orderList[i].orderID + '"></td><td>' +
                                        orderList[i].fullName + '</td><td>' +
                                        orderList[i].orderedDate + '</td><td>' +
                                        orderList[i].phone + '</td></tr>';
                            }
                            $('#table_body_ordered').append(row);
                        }
                    })
                    $('#orderedModal').modal('show');
                });
                //end ordered modal
                //start sold modal
                $(document).on("click", ".soldModal", function () {
                    var productID = $(this).data('id');
                    $("#sold_fullName").text("");
                    $("#sold_address").text("");
                    $("#sold_phone").text("");
                    $("#sold_email").text("");
                    $("#sold_productName").text("");
                    $("#sold_consignmentID").text("");
                    $("#sold_negotiatedPrice").text("");
                    $("#sold_sellingPrice").text("");
                    $("#sold_receivedDate").text("");
                    $("#sold_paypalAccount").text("");
                    $("#soldconsignmentID").val("");
                    $("#sold_returnPrice").val("");
                    $("#sold_name").val("");
                    $.get('LoadSoldProduct', {productID: productID}, function (response) {
                        var product = response.product;
                        var price;
                        if (response.period >= 120) {
                            price = ((response.negotiatedPrice * 70 / 100)).toFixed(0);
                        } else {
                            price = (((response.negotiatedPrice / 100) * (100 - (response.period / 30) * 10))).toFixed(0);
                        }
                        $("#sold_fullName").text(response.name);
                        $("#sold_address").text(response.address);
                        $("#sold_phone").text(response.phone);
                        $("#sold_email").text(response.email);
                        $("#sold_productName").text(product.name);
                        $("#sold_consignmentID").text(response.consigmentID);
                        $("#sold_negotiatedPrice").text(response.negotiatedPrice);
                        $("#sold_sellingPrice").text(response.returnPrice);
                        $("#sold_receivedDate").text(response.reviewProductDate);
                        $("#sold_paypalAccount").text(response.paypalAccount);
                        $("#soldconsignmentID").val(response.consigmentID);
                        $("#sold_returnPrice").val(price);
                        $("#sold_returnPrice1").val(price);
                        $("#sold_name").val(product.name);
                        if (typeof response.paypalAccount === "undefined") {
                            $("#paypal_form").hide();
                        } else {
                            loadPaypalInformation();
                            $("#paypal_form").show();
                        }
                    });
                    $('#soldModal').modal('show');
                });
                function loadPaypalInformation() {
                    var consignmentID = $("#soldconsignmentID").val();
                    var price = $("#sold_returnPrice").val();
                    $.get('LoadPaypalInformation', function (result) {
                        $("input[name=cmd]").val(result.cmd);
                        $("input[name=business]").val(result.business);
                        $("input[name=return]").val(result.returnURL + "?txtConsignmentID=" + consignmentID + "&txtReturnPrice=" + price + "&paymentMethod=paypal");
                        $("input[name=rm]").val(result.rm);
                        $("input[name=item_name]").val(result.item_name + consignmentID);
                        $("input[name=item_number]").val(result.item_number);
                        $("input[name=currency_code]").val(result.currency_code);
                        $("input[name=amount]").val((price * 1000 / result.exchangeRate).toFixed(2));
                    });
                }
                ;
                //end sold modal
                //start expired modal
                $(document).on("click", ".expiredModal", function () {
                    var consignmentID = $(this).data('id');
                    $.get('LoadExpiredProduct', {consignmentID: consignmentID}, function (response) {
                        $("#expired_fullName").text(response.name);
                        $("#expired_address").text(response.address);
                        $("#expired_phone").text(response.phone);
                        $("#expired_email").text(response.email);
                        $("#expired_productName").text(response.product.name);
                        $("#expired_consignmentID").text(consignmentID);
                        $("#expired_extendConsignmentID").val(consignmentID);
                        $("#expired_receiveConsignmentID").val(consignmentID);
                        $("#expired_consignedDate").text(response.reviewProductDate);
                        $("#expired_negotiatedPrice").text(response.negotiatedPrice);
                        $("#expired_days").text(response.expiredDays);
                        $("#expired_fee").val(response.expiredFee);
                    });
                    $('#expiredModal').modal('show');
                });
                $(document).on("click", ".confirmExtendModal", function () {
                    $("#expired_period").text($("#expired_days").text());
                    $("#expired_fees").text($("#expired_fee").val());
                    $('#confirmExtendModal').modal('show');
                });
                $(document).on("click", ".confirmReceiveModal", function () {
                    $('#confirmReceiveModal').modal('show');
                });
                //end expired modal
                //start on web modal
                $(document).on("click", ".onWebModal", function () {
                    $("#er_OnWeb_ProductName").html('');
                    $("#er_OnWeb_Brand").html('');
                    var consignmentID = $(this).data('id');
                    $.get('LoadOnWebProduct', {consignmentID: consignmentID}, function (response) {
                        var season = [];
                        season = response.product.seasonList;
                        for (var i = 1, max = 4; i <= max; i++) {
                            $("input#onWeb_chkSeason" + i).parent("span").removeClass("checked");
                        }
                        for (var i = 0; i < season.length; i++) {
                            $("input#onWeb_chkSeason" + season[i]).parent("span").addClass("checked");
                        }
                        var price = (response.negotiatedPrice * 15 / 100).toFixed(0);
                        $("#confirmCancel_ConsignmentID1").text(consignmentID);
                        $("#confirmCancel_ConsignmentID2").val(consignmentID);
                        $("#confirmCancel_Fee").val(price);
                    });
                    $.get('LoadAvailableProduct', {consignmentID: consignmentID}, function (response) {
                        $("#onWeb_ProductName").val(response.name);
                        $("#onWeb_ProductID").val(response.productID);
                        $("#onWeb_SerialNumber").val(response.serialNumber);
                        $("#onWeb_BoughtDate").val(response.purchasedDate);
                        $("#onWeb_Brand").val(response.brand);
                        $("#onWeb_Description").val(response.description);
                        $("#onWeb_Image").attr("src", response.image);
                        var option = "option#onWeb_" + response.categoryID;
                        $(option).attr("selected", "selected");
                        if (response.isSpecial < 1) {
                            $('#sendPriceTrue_2').parent('span').addClass('checked');
                            $('#sendPriceFalse_2').parent('span').removeClass('checked')
                        } else {
                            $('#sendPriceTrue_2').parent('span').removeClass('checked')
                            $('#sendPriceFalse_2').parent('span').addClass('checked')
                        }
                    });
                    $('#onWebModal').modal('show');
                });
                $(document).on("click", ".confirmOnWebModal", function () {
                    $('#confirmOnWebModal').modal('show');
                });
                $(document).on("click", ".receiveProductModal", function () {
                    var negotiatedPrice = $('#cancel_negotiatedPrice').text();
                    $('#confirmCancel_Fee').val((negotiatedPrice * 15 / 100).toFixed(0));
                    $('#confirmOnWebModal').modal('show');
                });
                //end on web modal
                // validation check customer
                function checkCustomer1()
                {
                    var n = $('input[name=chkboxCustomer]:checked').length;
                    if (n == 0) {
                        alert('Vui lòng chọn ít nhất một khách hàng');
                        return false;
                    }
                    if (n > 1) {
                        alert('Vui lòng chỉ chọn một khách hàng');
                        return false;
                    }
                    if (n == 1) {
                        $('#order_OrderID').val($("input:checked").val());
                        $('#confirmOrderedModal').modal('show');
                    }
                }
                function checkCustomer2()
                {
                    var n = $('input[name=chkboxCustomer]:checked').length;
                    var price = $("#sendPrice").val().trim();
                    if (n == 0) {
                        alert('Vui lòng chọn ít nhất một khách hàng.');
                        return false;
                    }
                    if (price.length == 0) {
                        alert('Vui lòng nhập giá gửi khách hàng.')
                        return false;
                    }
                    if (price < 0) {
                        alert('Giá gửi khách hàng phải là số dương.');
                        return false;
                    }
                    if (isNaN(price)) {
                        alert('Giá gửi khách hàng phải là số.')
                        return false;
                    }
                    return true;
                }
                function validateSellingPrice()
                {
                    var fee = $('#sellingPrice').val().trim();
                    if (fee.length == 0) {
                        alert('Vui lòng nhập giá bán.');
                        return false;
                    }
                    if (isNaN(fee) || fee < 0) {
                        alert('Tiền bán phải là số dương');
                        return false;
                    } else {
                        return true;
                    }
                }
                function validationPrice()
                {
                    var fee = $('#expired_fee').val().trim();
                    if (fee.length == 0) {
                        alert('Vui lòng nhập tiền phạt.');
                        return false;
                    }
                    if (isNaN(fee) || fee < 0) {
                        alert('Tiền phạt phải là số dương');
                        return false;
                    } else {
                        return true;
                    }
                }
                function validateCancelPrice()
                {
                    var fee = $('#confirmCancel_Fee').val().trim();
                    if (fee.length == 0) {
                        alert('Vui lòng nhập tiền phạt.');
                        return false;
                    }
                    if (fee < 0) {
                        alert('Tiền phạt phải là số dương');
                        return false;
                    }
                    if (isNaN(fee)) {
                        alert('Tiền phạt phải là số');
                        return false;
                    } else {
                        return true;
                    }
                }
                //compare date
                function compareDate(source, target) {//return -1 if source < target, 1 if source > target and 0 if source = target
                    if (source.substring(6, 10) > target.substring(6, 10)) {
                        return 1;
                    }
                    if (source.substring(3, 5) > target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                        return 1;
                    }
                    if (source.substring(0, 2) > target.substring(0, 2) && source.substring(3, 5) >= target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                        return 1;
                    }
                    if (source.localeCompare(target) == 0) {
                        return 0;
                    }
                    return -1;
                }
                //set season by time
                function setSeason() {
                    $("div.seasonDiv").siblings().children('label').children('div').children('span').removeClass("checked");
                    var today = new Date();
                    var dd = today.getDate();
                    var mm = today.getMonth() + 1;
                    var yyyy = today.getFullYear();
                    if (dd < 10) {
                        dd = '0' + dd;
                    }
                    if (mm < 10) {
                        mm = '0' + mm;
                    }

                    today = dd + '-' + mm + '-' + yyyy;
                    if (compareDate(today, '23-01-' + yyyy) >= 0 && compareDate(today, '21-06-' + yyyy) < 0) {
                        $("input#chkSeason1").parent("span").addClass("checked");
                    } else if (compareDate(today, '21-06-' + yyyy) >= 0 && compareDate(today, '23-09-' + yyyy) < 0) {
                        $("input#chkSeason2").parent("span").addClass("checked");
                    } else if (compareDate(today, '23-09-' + yyyy) >= 0 && compareDate(today, '22-12-' + yyyy) < 0) {
                        $("input#chkSeason3").parent("span").addClass("checked");
                    } else
                    {
                        $("input#chkSeason4").parent("span").addClass("checked");
                    }
                }
                //get season checkbox
                function getSeasonAvai()
                {
                    var flag = true;
                    var name = $("#avai_ProductName").val();
                    var brand = $("#avai_Brand").val();
                    if (name.length < 5) {
                        flag = false;
                        $("#er_avai_ProductName").html('Vui lòng nhập tên sản phẩm');
                    }
                    if (brand.length <= 0) {
                        flag = false;
                        $("#er_avai_Brand").html('Vui lòng nhập tên sản phẩm');
                    }
                    var selected = [];
                    $('#chkSeason1').parent('span').parent('div').parent('label').parent('div').siblings().addBack().each(function () {
                        if ($(this).children('label').children('div').children('span').hasClass('checked')) {
                            console.log($(this).children('label').children('div').children('span').children('input').attr('value'));
                            selected += ($(this).children('label').children('div').children('span').children('input').attr('value'));
                        }
                    });
                    $('#avai_seasonID').val(selected);
                    return flag;
                }
                function getSeasonOnWeb()
                {
                    var flag = true;
                    var name = $("#onWeb_ProductName").val();
                    var brand = $("#onWeb_Brand").val();
                    if (name.length < 5) {
                        flag = false;
                        $("#er_OnWeb_ProductName").html('Vui lòng nhập tên sản phẩm');
                    }
                    if (brand.length <= 0) {
                        flag = false;
                        $("#er_OnWeb_Brand").html('Vui lòng nhập tên sản phẩm');
                    }
                    var selected = [];
                    $('#onWeb_chkSeason1').parent('span').parent('div').parent('label').parent('div').siblings().addBack().each(function () {
                        if ($(this).children('label').children('div').children('span').hasClass('checked')) {
                            selected += ($(this).children('label').children('div').children('span').children('input').attr('value'));
                        }
                    });
                    $('#onWeb_seasonID').val(selected);
                    return flag;
                }
            </script>
    </body>
    <!-- END BODY -->
</html>