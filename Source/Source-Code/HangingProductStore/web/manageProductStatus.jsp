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
                                                    <td class="center">${item.receivedDate}</td>
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
                                                    <td class="center">${item.receivedDate}</td>
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
                                    <table class="table table-striped table-hover" id="canceledTable">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày hủy</th>
                                                <th>Ngày kí gửi</th>
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
                                                    <td class="center">${item.receivedDate}</td>
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
                                                    <td class="center">${item.receivedDate}</td>
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
                                                    <td>${item.receivedDate}</td>
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
                                <form action="SoldProduct" method="POST">
                                    <div class="modal-header">
                                        <h4>Thông tin sản phẩm</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-6 col-md-6">
                                                <h5>Thông tin người kí gửi</h5>
                                                <li>Họ tên : <label id="sold_fullName"></label></li>
                                                <li>Địa chỉ : <label id="sold_address"></label></li>
                                                <li>Số điện thoại : <label id="sold_phone"></label></li>
                                                <li>Email : <label id="sold_email"></label></li>
                                                <li>Tài khoản Paypal : <label id="sold_paypalAccount"></label></li>
                                            </div>
                                            <div class="col-sm-6 col-md-6">
                                                <h5>Thông tin sản phẩm</h5>
                                                <li>Tên sản phẩm : <label id="sold_productName"></label></li>
                                                <li>Mã kí gửi : <label id="sold_consignmentID"></label></li>
                                                <li>Giá sản phẩm (Ngàn đồng): <label id="sold_negotiatedPrice"></label></li>
                                                <li>Giá bán (Ngàn đồng): <label id="sold_sellingPrice"></label></li>
                                                <li>Ngày kí gửi : <label id="sold_receivedDate"></label></li>
                                                <li>Tiền trả khách hàng (Ngàn đồng): <input type="text" name="txtReturnPrice" id="sold_returnPrice"></li>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="soldconsignmentID" value=""/>
                                        <button class="btn btn-primary" name="btnAction" type="submit" value="pay" onclick="return checkSoldProduct();">Trả tiền</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px"/>
                                    </div>
                                </form>
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
                                        Giá bán (Ngàn đồng): <input type="text" name="txtSendPrice" id="sendPrice" value="">
                                        <span id="erSendPrice" class="help-block">
                                        </span>
                                        Giá kí gửi (Ngàn đồng) <label id="ordered_negotiatedPrice"></label>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table table-striped table-bordered table-hover" id="listOrderedTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th></th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Ngày đặt mua</th>
                                                    <th>Thông tin liên hệ</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody id="table_body_ordered">
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtOrderID" value="" id="ordered_orderID">
                                        <button class="btn btn-primary" name="btnAction" type="submit" value="sendPrice" onclick="return checkCustomer2();">Gửi giá</button>
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
                                        <label class="control-label">Giá bán (Ngàn đồng):</label><input type="text" name="txtSellingPrice" value ="" style="width: 300px;">
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtOrderID" id="order_OrderID">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="order">Đồng ý</button>
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
                                            <h5>Thông tin người kí gửi</h5>
                                            <li>Họ tên : <label id="cancel_fullName"></label></li>
                                            <li>Địa chỉ : <label id="cancel_address"></label></li>
                                            <li>Số điện thoại : <label id="cancel_phone"></label></li>
                                            <li>Email : <label id="cancel_email"></label></li>
                                        </div>
                                        <div class="col-sm-6">
                                            <h5>Thông tin hàng kí gửi</h5>
                                            <li>Tên sản phẩm : <label id="cancel_productName"></label></li>
                                            <li>Mã hàng kí gửi : <label id="cancel_consignmentID"></label></li>
                                            <li>Giá kí gửi (Ngàn đồng): <label id="cancel_negotiatedPrice"></label></li>
                                            <li>Ngày kí gửi : <label id="cancel_consignedDate"></label></li>
                                            <li>Ngày hủy kí gửi : <label id="cancel_canceledDate"></label></li>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form action="CancelProduct" method="POST">
                                        <input type="hidden" name="txtConsignmentID" id="cancel_ID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="cancel">Đồng ý hủy</button>
                                        <button class="btn btn-warning" name="btnAction" type="submit" value="notCancel">Không đồng ý hủy</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- CANCEL MODAL END-->
                    <!-- AVAILABLE MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="availableModal" aria-hidden="true">
                        <form action="PublishProduct" method="POST" enctype="multipart/form-data">
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
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mùa </label>
                                                            <div class="col-sm-8">
                                                                <c:forEach var="item" items="${requestScope.season}">
                                                                    <div class="col-sm-3">
                                                                        <input style="width: 8%" type="checkbox" name="chkSeason" value="${item.seasonID}"/>${item.seasonName}
                                                                    </div>
                                                                </c:forEach>
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
                                                                            <input type="file" name="txtImage" onchange="readURL(this);" style="max-width: "/>
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
                                        <div class="col-sm-6">
                                            <h5>Thông tin người kí gửi</h5>
                                            <li>Họ tên : <label id="expired_fullName"></label></li>
                                            <li>Địa chỉ : <label id="expired_address"></label></li>
                                            <li>Số điện thoại : <label id="expired_phone"></label></li>
                                            <li>Email : <label id="expired_email"></label></li>
                                        </div>
                                        <div class="col-sm-6">
                                            <h5>Thông tin hàng kí gửi</h5>
                                            <li>Tên sản phẩm : <label id="expired_productName"></label></li>
                                            <li>Mã hàng kí gửi : <label id="expired_consignmentID"></label></li>
                                            <li>Ngày kí gửi : <label id="expired_consignedDate"></label></li>
                                            <li>Thời gian kí gửi : <label id="expired_period"></label></li>
                                            <li>Số ngày quá hạn: <label id="expired_days"></label></li>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form>
                                        <input class="btn btn-info confirmExtendModal" type="button" data-togle="modal" value="Gia hạn">
                                        <input class="btn btn-info confirmReceiveModal" type="button" data-togle="modal" value="Nhận hàng">
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
                                        Sản phẩm sẽ được gia hạn thêm 30 ngày. Bạn có chắc chắn muốn gia hạn sản phẩm này?
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
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Thông tin sản phẩm</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="input-group">
                                                Tên sản phẩm :<label id="onWeb_ProductName"></label>
                                            </div>
                                            <div class="input-group">
                                                Mã kí gửi : <label id="onWeb_ConsignmentID"></label>
                                            </div>
                                            <div class="input-group">
                                                Ngày nhận hàng : <label id="onWeb_ReceivedDate"></label>
                                            </div>
                                            <div class="input-group">
                                                Giá bán thỏa thuận (Ngàn đồng): <label id="onWeb_NegotiatedPrice"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input class="btn btn-info confirmOnWebModal" type="button" data-togle="modal" value="Hủy kí gửi">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- CANCEL PRODUCT ONWEB MODAL END-->
                    <!-- CONFIRM CANCEL PRODUCT ONWEB MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmOnWebModal" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Hủy kí gửi</h4>
                                </div>
                                <div class="modal-body">
                                    <h5>Bạn có chắc chắn muốn hủy kí gửi sản phẩm với mã kí gửi <label id="confirmCancel_ConsignmentID1"></label>?</h5>
                                    <h5>Tiền phạt (Ngàn đồng): <label id="confirmCancel_Fee"></label></h5>
                                </div>
                                <div class="modal-footer">
                                    <form action="CancelProductOnWeb" method="POST">
                                        <input type="hidden" value="" name="txtConsignmentID" id="confirmCancel_ConsignmentID2">
                                        <button class="btn btn-success" type="submit">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
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
                    });
                    $('#cancelModal').modal('show');
                });
                //end cancel modal
                //start available modal
                $(document).on("click", ".availableModal", function () {
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
                    });
                    $('#availableModal').modal('show');
                });
                function readURL(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#avai_Image').attr('src', e.target.result);
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
                        var orderList = response.orderList;
                        $('#ordered_orderID').val(response.orderList[0].orderID);
                        $('#ordered_negotiatedPrice').text(response.negotiatedPrice);
                        $('#listOrderedTable tbody').empty();
                        for (var i = 0, max = orderList.length; i < max; i++) {
                            var row = '<tr><td><input type="checkbox" name="chkboxCustomer" value="' +
                                    orderList[i].orderID + '"></td><td>' +
                                    orderList[i].fullName + '</td><td>' +
                                    orderList[i].orderedDate + '</td><td>' +
                                    orderList[i].phone + '</td><td>';
                            if (orderList[i].sendPrice == 0) {
                                row = row + 'Chưa gửi giá</td></tr>';
                            } else {
                                row = row + 'Gửi giá ' + orderList[i].sendPrice + '</td></tr>';
                            }
                            $('#table_body_ordered').append(row);
                        }
                    });
                    $('#orderedModal').modal('show');
                });
                //end ordered modal
                //start sold modal
                $(document).on("click", ".soldModal", function () {
                    var productID = $(this).data('id');
                    $.get('LoadSoldProduct', {productID: productID}, function (response) {
                        var product = response.product;
                        var price;
                        if (response.period >= 120) {
                            price = ((response.negotiatedPrice * 70 / 100)).toFixed(0);
                        } else {
                            price = (((response.negotiatedPrice / 100) * (100 - (response.period / 30) * 10))).toFixed(0);
                        }
                        console.log(price);
                        $("#sold_fullName").text(response.name);
                        $("#sold_address").text(response.address);
                        $("#sold_phone").text(response.phone);
                        $("#sold_email").text(response.email);
                        $("#sold_productName").text(product.name);
                        $("#sold_consignmentID").text(response.consigmentID);
                        $("#sold_negotiatedPrice").text(response.negotiatedPrice);
                        $("#sold_sellingPrice").text(response.returnPrice);
                        $("#sold_receivedDate").text(response.receivedDate);
                        $("#sold_paypalAccount").text(response.paypalAccount);
                        $("#soldconsignmentID").val(response.consigmentID);
                        $("#sold_returnPrice").val(price);
                        $("#sold_name").val(product.name);
                    });
                    $('#soldModal').modal('show');
                });
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
                        $("#expired_consignedDate").text(response.receivedDate);
                        $("#expired_period").text(response.period);
                        $("#expired_days").text(response.expiredDays);
                        $("#expired_fee").val(response.expiredFee);
                    });
                    $('#expiredModal').modal('show');
                });
                $(document).on("click", ".confirmExtendModal", function () {
                    $('#confirmExtendModal').modal('show');
                });
                $(document).on("click", ".confirmReceiveModal", function () {
                    $('#confirmReceiveModal').modal('show');
                });
                //end expired modal
                //start on web modal
                $(document).on("click", ".onWebModal", function () {
                    var consignmentID = $(this).data('id');
                    $.get('LoadOnWebProduct', {consignmentID: consignmentID}, function (response) {
                        var price = (response.negotiatedPrice * 15 / 100).toFixed(0);
                        $("#onWeb_ProductName").text(response.product.name);
                        $("#onWeb_ConsignmentID").text(consignmentID);
                        $("#onWeb_ReceivedDate").text(response.receivedDate);
                        $("#onWeb_NegotiatedPrice").text(response.negotiatedPrice);
                        $("#confirmCancel_ConsignmentID1").text(consignmentID);
                        $("#confirmCancel_ConsignmentID2").val(consignmentID);
                        $("#confirmCancel_Fee").text(price);
                    });
                    $('#onWebModal').modal('show');
                });
                $(document).on("click", ".confirmOnWebModal", function () {
                    $('#confirmOnWebModal').modal('show');
                });
                //end on web modal
                // validation check customer
                function checkCustomer1()
                {
                    var n = $("input:checked").length;
                    if (n == 0) {
                        alert('Vui lòng chọn ít nhất một khách hàng');
                        console.log('Ko chon thang nao');
                        return false;
                    }
                    if (n > 1) {
                        alert('Vui lòng chỉ chọn một khách hàng');
                        console.log('Chon hon 1 thang');
                        return false;
                    }
                    if (n == 1) {
                        $('#order_OrderID').val($("input:checked").val());
                        console.log('ok ne');
                        $('#confirmOrderedModal').modal('show');
                    }
                }
                function checkCustomer2()
                {
                    var n = $("input:checked").length;
                    var price = $("#sendPrice").val();
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
                function checkSoldProduct() {
                    var price = $('#sold_returnPrice').val();
                    if (isNaN(price) || price < 0) {
                        alert('Tiền phạt phải là số dương');
                        return false;
                    } else {
                        return true;
                    }
                }
                function validationPrice()
                {
                    var fee = $('#expired_fee').val();
                    if (isNaN(fee) || fee < 0) {
                        alert('Tiền phạt phải là số dương');
                        return false;
                    } else {
                        return true;
                    }
                }
            </script>
    </body>
    <!-- END BODY -->
</html>