<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta charset="utf-8"/>
        <title>Quản lý sản phẩm</title>
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
        <link href="assets/frontend/pages/css/style-manage-product.css" rel="stylesheet" type="text/css"/>
        <!-- END THEME STYLES -->
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
        <!-- BEGIN SET PARAMETER -->
        <c:if test="${empty sessionScope.ACCOUNT}">
            <c:redirect url="./login.jsp"/>
        </c:if>
        <c:if test="${sessionScope.ACCOUNT.role != 'storeOwner'}">
            <c:redirect url="./login.jsp"/>
        </c:if>
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
                            </div>
                        </li>
                        <li class="start">
                            <a href="ConsignmentRequestReceive">
                                <i class="icon-tag"></i>
                                <span class="title">Quản lý yêu cầu</span>
                            </a>
                        </li>
                        <li class="start">
                            <a href="LoadProductPage">
                                <i class="icon-handbag"></i>
                                <span class="title">Quản lý sản phẩm</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="LoadSalesPage">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lý bán hàng</span>
                            </a>
                        </li>
                    </ul>
                    <!-- END SIDEBAR MENU -->
                </div>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="row" style="background-color: #01579b; height: 40px" >
                        <div class="col-lg-8 col-md-8" style="font-weight: bold; color: white; font-size: 150%; margin-top: 5px">
                            <i class="icon-basket icon-lg"></i> Quản lý bán hàng
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <!-- BEGIN ALL TAB-->
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Trạng thái:</label>
                                            <div class="col-md-5 col-sm-5">
                                                <select class="form-control" id="consignmentOption">
                                                    <option value="all" selected="selected">Tất cả</option>
                                                    <option value="Đã được đặt">Đã được đặt</option>
                                                    <option value="Đã bán">Đã bán</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" id="saleTable">
                                <thead>
                                    <tr class="heading">
                                        <th>STT</th>
                                        <th>Tên khách hàng</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Số người đặt</th>
                                        <th>Trạng thái</th>
                                        <th style="width: 110px">Chi Tiết</th>
                                        <th style="display: none"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${requestScope.result}" varStatus="counter">
                                        <tr class="odd gradeX">
                                            <td class="center" style="font-weight: bold">${counter.count}</td>
                                            <td>${item.name}</td>
                                            <td>${item.product.name}</td>
                                            <td>${item.quantity}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.product.productStatusID == 4}">
                                                        <font style="color: #7fcc7f; font-weight: bold">Đã được đặt</font>
                                                    </c:when>
                                                    <c:when test="${item.product.productStatusID == 5}">
                                                        <font style="color: #bb0000; font-weight: bold">Đã bán</font>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button style="width: 60px;margin-right: 0px; color: black" class="btn btn-info btn-open-modal" data-toggle="modal" data-id="${item.consigmentID}"><i class="fa fa-eye"></i></button>
                                                <button style="margin-right: 0px;" class="btn yellow btn-detail-modal" data-toggle="modal" data-id="${item.consigmentID}"><i class="fa fa-history"></i></button>
                                            </td>
                                            <td style="display: none">${item.consigmentID}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- END ALL TAB-->
                            <!-- END EXAMPLE TABLE PORTLET-->
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <!-- SOLD MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="soldModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4 ">
                                <h3 class="modal-title" style="font-weight: bold">Thông tin sản phẩm - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>        
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-5 col-md-5">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin người kí gửi</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Họ tên</label>
                                                <div class="col-md-8 col-sm-8" id="sold_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Địa chỉ</label>
                                                <div class="col-md-8 col-sm-8" id="sold_address"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-8 col-sm-8" id="sold_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                            <div class="form-group" id="email_field">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email</label>
                                                <div class="col-md-8 col-sm-8" id="sold_email"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                            <div class="form-group" id="payment_field">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tài khoản paypal</label>
                                                <div class="col-md-8 col-sm-8" id="sold_paypalAccount"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-7 col-md-7">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin sản phẩm</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-8 col-sm-8" id="sold_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Mã kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="sold_consignmentID"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-8 col-sm-8" id="sold_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá bán</label>
                                                <div class="col-md-8 col-sm-8" id="sold_sellingPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="sold_receivedDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tiền trả khách hàng <font color="red">*</font></label>
                                                <div class="col-md-6 col-sm-6">
                                                    <input type="text" id="sold_returnPrice" class="form-control" > 
                                                    <span class="help-block">(ngàn đồng)</span>
                                                    <p class="help-block" id="er_sold_returnPrice" style="color: red">  </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="row">
                                    <div style="float: right; margin: 0px 5px;">
                                        <form action="SoldProduct" method="POST" onsubmit="return checkPaymentValue();">
                                            <input type="hidden" name="txtReturnPrice" id="sold_returnPrice1" value=""/>
                                            <input type="hidden" class="currentTab" name="currentTab" value="">
                                            <input type="hidden" name="txtConsignmentID" id="soldconsignmentID" value=""/>
                                            <button class="btn blue" name="btnAction" type="submit" value="pay">Trả tiền</button>
                                            <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px"/>
                                        </form>
                                    </div>
                                    <div style="float: right" style="display: none" id="paypal_form">
                                        <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="POST" onsubmit="return checkPaymentValue();">
                                            <input type="hidden" name="cmd" value="">
                                            <input type="hidden" name="business" value="">
                                            <input type="hidden" name="return" value="">
                                            <input type="hidden" name="rm" value=""/>
                                            <input type="hidden" name="item_name" value="">
                                            <input type="hidden" name="item_number" value="">
                                            <input type="hidden" name="amount" value="">
                                            <input type="hidden" name="currency_code" value="">
                                            <button class="btn green" type="submit">Thanh toán qua Paypal</button>
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
                                <div class="modal-header" style="background-color: #89C4F4 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin đặt hàng - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">

                                        <div class="col-sm-7">
                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá gửi khách hàng:</label>
                                                    <div class="col-md-8 col-sm-8">
                                                        <input style="width: 120px" id="sendPrice" name="txtSendPrice" type="text" maxlength="50"/><span>&nbsp;&nbsp;(ngàn đồng)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Giá thỏa thuận:</label>
                                                    <div class="col-md-7 col-sm-7" id="ordered_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <table class="table table-striped table-bordered table-hover" id="listOrderedTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th style="text-align: center"><input type="checkbox" class="checkAll"></th>
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
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="txtOrderID" value="" id="ordered_orderID">
                                    <button class="btn btn-warning" name="btnAction" type="submit" value="sendPrice" onclick="return checkCustomer2();" id="btnPrice">Gửi giá</button>
                                    <button class="btn red" name="btnAction" type="submit" value="cancel">Hủy đơn hàng</button>
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input class="btn blue confirmOrderedModal" type="button" data-togle="modal" value="Hoàn tất thanh toán" onclick="return checkCustomer1();">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- ORDERED MODAL END-->
                <!-- CONFIRM ORDERED MODAL BEGIN-->
                <div class="modal fade bs-example-modal-sm" id="confirmOrderedModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <form action="OrderProduct" method="POST">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin giá bán</h3>        
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-10 col-sm-offset-1" align="center">
                                            <label class="control-label">Giá bán (ngàn đồng): <font color="red">*</font></label>
                                            <input class="form-control" id="sellingPrice" type="text" name="txtSellingPrice" value ="">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="txtOrderID" id="order_OrderID">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <button class="btn blue" name="btnAction" type="submit" value="order" onclick="return validateSellingPrice();">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- CONFIRM ORDERED MODAL END-->
                <div class="modal fade bs-example-modal-lg" id="detailModal" aria-hidden="true">
                    <div class="modal-dialog modal-scrollable modal-lg">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4 ">
                                <h3 class="modal-title" style="font-weight: bold">Thông tin chi tiết  - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>
                            </div>
                            <div class="modal-body">
                                <div class="row">


                                    <!-- BEGIN LEFT TAB -->
                                    <div class="col-lg-6 col-md-6">

                                        <!--table-striped-->
                                        <div class="form-horizontal">
                                            <!--                                        <table class="table table-hover" style="border: none">-->
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Loại sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_productCategory"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Hãng</label>
                                                <div class="col-md-7 col-sm-7" id="c_productBrand"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-7 col-sm-7" id="c_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                        </div>

                                    </div>
                                    <!-- END LEFT TAB -->
                                    <!-- BEGIN RIGHT TAB -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Người ký gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-7 col-sm-7" id="c_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Cách thức thanh toán</label>
                                                <div class="col-md-7 col-sm-7" id="c_paypalAccount"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Thời gian kí gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_period"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- END RIGHT TAB -->
                                </div>
                                <hr/>
                                <div class="row">
                                    <!--BEGIN LEFT TAB -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">

                                            <div class="form-group" id="div_c_createdDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày tạo ký gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_createdDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_refuseProductDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày từ chối sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_refuseProductDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_reviewProductDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày nhận sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_reviewProductDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_returnDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày trả tiền khách hàng</label>
                                                <div class="col-md-7 col-sm-7" id="c_returnDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_cancelDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày hủy kí gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_cancelDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--END LEFT TAB -->

                                    <!--BEGIN RIGHT TAB -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_reviewRequestDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày duyệt yêu cầu</label>
                                                <div class="col-md-7 col-sm-7" id="c_reviewRequestDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_refuseRequestDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày từ chối yêu cầu</label>
                                                <div class="col-md-7 col-sm-7" id="c_refuseRequestDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_publishOnWebDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày đăng lên web</label>
                                                <div class="col-md-7 col-sm-7" id="c_publishOnWebDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_receivedDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày hoàn trả sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_receivedDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_sellDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày bán sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_sellDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--END RIGHT TAB -->
                                </div>
                                <div class="row" id="bonus_infor">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_returnedPrice">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Tiền trả khách hàng</label>
                                                <div class="col-md-7 col-sm-7" id="c_returnedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_reason">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Lý do từ chối</label>
                                                <div class="col-md-7 col-sm-7" id="c_reason"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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

        <!--BEGIN PAGE CSS -->
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
        <!--END PAGE CSS -->

        <link rel="stylesheet" type="text/css" href="assets/global/plugins/clockface/css/clockface.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datepicker/css/datepicker3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>

        <script type="text/javascript" src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/clockface/js/clockface.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/moment.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

        <script src="assets/admin/pages/scripts/components-form-tools.js"></script>
        <script src="assets/admin/pages/scripts/components-pickers.js"></script>
        <link rel="stylesheet" href="js/jquery-ui.css">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <!--END PAGE CSS -->
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
            $(document).on("click", ".btn-detail-modal", function () {
                var consignmentID = $(this).data('id');
                $("font.consignmentIDHeader").each(function () {
                    $(this).text(consignmentID);
                })
                loadCompletedProduct(consignmentID);
            })
            $(document).on("click", ".btn-open-modal", function () {
                var consignmentID = $(this).data('id');
                $("font.consignmentIDHeader").each(function () {
                    $(this).text(consignmentID);
                })
                $.get('CheckPopupModal', {consignmentID: consignmentID}, function (response) {
                    if (response == 5) {
                        loadOrderedProduct(consignmentID);
                    }
                    if (response == 6) {
                        loadSoldProduct(consignmentID);
                    }
                });
            });
            function checkCustomer1() {
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
            function checkCustomer2() {
                var price = $("#sendPrice").val().trim();
                var flag = true;
                var n = $('input[name=chkboxCustomer]:checked').length;
                if (n == 0) {
                    alert('Vui lòng chọn ít nhất một khách hàng');
                    return false;
                }
                $('input[name=chkboxCustomer]:checked').each(function () {
                    if (isNaN(price) || price.length == 0 || price <= 0) {
                        var id = '#' + $(this).val();
                        var sendPrice = $("" + id).val();
                        if (flag && (isNaN(sendPrice) || sendPrice.length == 0 || sendPrice <= 0)) {
                            alert('Vui lòng nhập giá gửi khách hàng');
                            flag = false;
                        }
                    }
                })
                return flag;
            }
            function validateSellingPrice() {
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
            function loadPaypalInformation() {
                var consignmentID = $("#soldconsignmentID").val();
                var price = $("#sold_returnPrice").val();
                $.get('LoadPaypalInformation', function (result) {
                    $("input[name=cmd]").val(result.cmd);
                    $("input[name=business]").val(result.business);
                    $("input[name=return]").val(result.returnURL + "?txtConsignmentID=" + consignmentID + "&txtReturnPrice=" + price + "&paymentMethod=paypal&currentTab=sold");
                    $("input[name=rm]").val(result.rm);
                    $("input[name=item_name]").val(result.item_name + consignmentID);
                    $("input[name=item_number]").val(result.item_number);
                    $("input[name=currency_code]").val(result.currency_code);
                    $("input[name=amount]").val((price * 1000 / result.exchangeRate).toFixed(2));
                });
            }
            function loadSoldProduct(consignmentID) {
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
                $.get('LoadSoldProduct', {consignmentID: consignmentID}, function (response) {
                    var product = response.product;
                    var price = (response.negotiatedPrice * 9 / 10).toFixed(0);
                    $("#sold_fullName").text(response.name);
                    $("#sold_address").text(response.address);
                    $("#sold_phone").text(response.phone);
                    $("#sold_email").text(response.email);
                    $("#sold_productName").text(product.name);
                    $("#sold_consignmentID").text(response.consigmentID);
                    $("#sold_negotiatedPrice").text(response.negotiatedPrice.toMoney(0) + " (ngàn đồng)");
                    $("#sold_sellingPrice").text(response.returnPrice.toMoney(0) + " (ngàn đồng)");
                    $("#sold_receivedDate").text(response.reviewProductDate);
                    $("#sold_paypalAccount").text(response.paypalAccount);
                    $("#soldconsignmentID").val(response.consigmentID);
                    $("#sold_returnPrice").val(price);
                    $("#sold_returnPrice1").val(price);
                    $("#sold_name").val(product.name);
                    if (typeof response.email === "undefined" || response.email == '') {
                        $("#email_field").hide();
                    } else {
                        $("#email_field").show();
                    }
                    if (typeof response.paypalAccount === "undefined" || response.paypalAccount == '') {
                        $("#payment_field").hide();
                        $("#paypal_form").hide();
                    } else {
                        $("#payment_field").show();
                        loadPaypalInformation();
                        $("#paypal_form").show();
                    }
                });
                $('#soldModal').modal('show');
            }
            function loadOrderedProduct(consignmentID) {
                $.get('LoadOrderedProduct', {consignmentID: consignmentID}, function (response) {
                    var isSpecial = response.isSpecial;
                    if (isSpecial > 0) {// =1 la phai gui gia
                        $("#sendPriceLabel").removeAttr("style");
                        $("#btnPrice").removeAttr("style");
                        $("#theadDetail").removeAttr("style");
                    } else {
                        $("#sendPriceLabel").attr("style", "display:none;");
                        $("#btnPrice").attr("style", "display:none;");
                        $("#theadDetail").attr("style", "display:none;");
                    }
                    var orderList = response.orderList;
                    $('#ordered_orderID').val(response.orderList[0].orderID);
                    $('#ordered_negotiatedPrice').text(response.negotiatedPrice.toMoney(0) + " (ngàn đồng)");
                    $('#listOrderedTable tbody').empty();
                    for (var i = 0, max = orderList.length; i < max; i++) {
                        var row = "";
                        if (isSpecial > 0) {
                            if (orderList[i].sendPrice == 0) {
                                row = '<tr><td style="text-align: center"><input type="checkbox" name="chkboxCustomer" value="' +
                                        orderList[i].orderID + '"><input style="width : 60px;margin-left:20px" type="text" id="' + orderList[i].orderID + '" name="' + orderList[i].orderID + '"> </td><td>' +
                                        orderList[i].fullName + '</td><td>' +
                                        orderList[i].orderedDate + '</td><td>' +
                                        orderList[i].phone + '</td><td>Chưa gửi giá</td></tr>';
                            } else {
                                row = '<tr><td style="text-align: center"><input type="checkbox" name="chkboxCustomer" value="' +
                                        orderList[i].orderID + '"><input style="width : 60px;margin-left:20px" type="text" id="' + orderList[i].orderID + '" name="' + orderList[i].orderID + '"> </td><td>' +
                                        orderList[i].fullName + '</td><td>' +
                                        orderList[i].orderedDate + '</td><td>' + orderList[i].phone + '</td><td>Đã gửi giá : ' +
                                        orderList[i].sendPrice.toMoney(0) + ' (ngàn đồng)</td></tr>';
                            }
                        }
                        else {
                            row = '<tr><td style="text-align: center"><input type="checkbox" name="chkboxCustomer" value="' +
                                    orderList[i].orderID + '"></td><td>' +
                                    orderList[i].fullName + '</td><td>' +
                                    orderList[i].orderedDate + '</td><td>' +
                                    orderList[i].phone + '</td></tr>';
                        }
                        $('#table_body_ordered').append(row);
                    }
                })
                $('#orderedModal').modal('show');
            }
            $("#consignmentOption").change(function () {
                var currentTab = $("#consignmentOption").val();
                if (currentTab == "Đã được đặt") {
                    currentTab = "ordered";
                }
                if (currentTab == "Đã bán") {
                    currentTab = "sold";
                }
                if (currentTab == "all") {
                    currentTab = "all";
                }
                $(".currentTab").each(function () {
                    $(this).val(currentTab)
                })
                console.log(currentTab);
                if (currentTab == "all") {
                    window.location.hash = "all";
                } else if (currentTab == "ordered") {
                    window.location.hash = "ordered";
                } else if (currentTab == "sold") {
                    window.location.hash = "sold";
                }
                var table = $("#saleTable").DataTable();
                table.draw();
            })
            $(document).ready(function () {
                var currentTab = window.location.hash.substring(1);
                if (currentTab.length > 0) {
                    if (currentTab == "all") {
                        $('#consignmentOption').val("all").change();
                    } else if (currentTab == "ordered") {
                        $('#consignmentOption').val("Đã được đặt").change();
                    } else if (currentTab == "sold") {
                        $('#consignmentOption').val("Đã bán").change();
                    }
                    var table = $('#saleTable').DataTable();
                    table.draw();
                } else {
                    $('#consignmentOption').val("all").change();
                    var table = $('#saleTable').DataTable();
                    table.draw();
                }
            });
            $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var option = $('#consignmentOption').val();
                        var status = data[4];
                        if (option.localeCompare('all') == 0) {
                            return true;
                        } else if (option.localeCompare(status) == 0) {
                            return true
                        } else {
                            return false;
                        }
                    });
            function loadCompletedProduct(consignmentID) {
                $.get('LoadDetailConsignment', {consignmentID: consignmentID}, function (respone) {
                    $('#c_fullName').text(respone.name);
                    $('#c_productName').text(respone.product.name);
                    $('#c_productCategory').text(respone.product.categoryName);
                    $('#c_productBrand').text(respone.product.brand);
                    $('#c_phone').text(respone.phone);

                    if (typeof respone.paypalAccount === "undefined" || respone.paypalAccount === '') {
                        $('#c_paypalAccount').text("Tiền mặt");
                    } else {
                        $('#c_paypalAccount').text("Chuyển tiền qua tài khoản " + respone.paypalAccount);
                    }
                    $('#c_period').text(respone.period + ' ngày');
                    $('#c_negotiatedPrice').text(respone.negotiatedPrice.toMoney(0) + ' (ngàn đồng)');
                    $('#c_createdDate').text(respone.createdDate);

                    $('#div_c_refuseProductDate').hide();
                    $('#div_c_reviewProductDate').hide();
                    $('#div_c_returnDate').hide();
                    $('#div_c_cancelDate').hide();
                    $('#div_c_receivedDate').hide();
                    $('#div_c_reviewRequestDate').hide();
                    $('#div_c_refuseRequestDate').hide();
                    $('#div_c_publishOnWebDate').hide();
                    $('#div_c_sellDate').hide();
                    $('#div_c_reason').hide();
                    $('#div_c_returnedPrice').hide();

                    $('#c_reviewRequestDate').text(respone.reviewRequestDate);
                    $('#c_reviewProductDate').text(respone.reviewProductDate);
                    $('#c_refuseRequestDate').text(respone.reviewRequestDate);
                    $('#c_refuseProductDate').text(respone.reviewProductDate);
                    $('#c_returnDate').text(respone.returnDate);
                    $('#c_cancelDate').text(respone.cancelDate);
                    $('#c_receivedDate').text(respone.agreeCancelDate);
                    $('#c_sellDate').text(respone.product.sellDate);
                    $('#c_publishOnWebDate').text(respone.raiseWebDate);
                    $('#c_reason').text(respone.reason);
                    $('#c_returnedPrice').text(respone.returnPrice.toMoney(0) + ' (ngàn đồng)');

                    if (respone.consignmentStatusID == 2 && respone.reviewProductDate != "") {//refuse request
                        $('#div_c_refuseProductDate').show();
                        $('#div_c_reviewRequestDate').show();
                    }
                    if (respone.consignmentStatusID == 2 && respone.reviewProductDate == "") {//retuse product
                        $('#div_c_refuseRequestDate').show();
                    }
                    if (respone.consignmentStatusID == 3) {
                        $('#div_c_reviewRequestDate').show();
                        if (respone.product.productStatusID == 6) {
                            if (respone.reviewProductDate != "") {
                                $('#div_c_reviewProductDate').show();
                            }
                            $('#div_c_cancelDate').show();
                        }
                    }
                    if (respone.consignmentStatusID == 5) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        if (respone.product.productStatusID == 3 || respone.product.productStatusID == 4) {
                            $('#div_c_publishOnWebDate').show();
                        }
                        if (respone.product.productStatusID == 5) {
                            $('#div_c_publishOnWebDate').show();
                            $('#div_c_sellDate').show();
                        }
                        if (respone.product.productStatusID == 6) {
                            $('#div_c_cancelDate').show();
                            $('#div_c_publishOnWebDate').show();
                        }
                    }
                    if (respone.consignmentStatusID == 6) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        $('#div_c_publishOnWebDate').show();
                    }
                    if (respone.consignmentStatusID == 7) {
                        $('#div_c_reviewRequestDate').show();
                        if (respone.reviewProductDate != "") {
                            $('#div_c_reviewProductDate').show();
                        }
                        if (respone.raiseWebDate != "") {
                            $('#div_c_publishOnWebDate').show();
                        }
                        $('#div_c_cancelDate').show();
                    }
                    if (respone.consignmentStatusID == 4) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        $('#div_c_publishOnWebDate').show();
                        if (respone.product.productStatusID == 7) {
                            $('#div_c_sellDate').show();
                            $('#div_c_returnedPrice').show();
                            $('#div_c_returnDate').show();
                        }
                    }
                    if (respone.reason != "") {
                        $('#div_c_reason').show();
                    }
                });
                $('#detailModal').modal('show');
            }
            Number.prototype.toMoney = function (decimals, decimal_sep, thousands_sep)
            {
                var n = this,
                        c = isNaN(decimals) ? 2 : Math.abs(decimals),
                        d = decimal_sep || '.',
                        t = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                        sign = (n < 0) ? '-' : '',
                        i = parseInt(n = Math.abs(n).toFixed(c)) + '',
                        j = ((j = i.length) > 3) ? j % 3 : 0;
                return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '');
            }
            $('input.checkAll').on("click", function () {
                var all = $(this);
                $('input[name=chkboxCustomer]').each(function () {
                    $(this).prop("checked", all.prop("checked"));
                });
            })</script>
    </body>
    <!-- END BODY -->
</html>