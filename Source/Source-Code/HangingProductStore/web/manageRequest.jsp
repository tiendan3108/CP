<%-- 
    Document   : manageRequest
    Created on : Jul 15, 2015, 10:25:15 AM
    Author     : Robingios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta charset="utf-8"/>
        <title>Quản lí yêu cầu ký gửi</title>
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
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
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
                                <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">${ACCOUNT.fullName}</span>
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
                        <li  class="sidebar-toggler-wrapper">
                            <div class="sidebar-toggler">
                            </div>
                        </li>
                        <li class="start active">
                            <a href="ConsignmentRequestReceive">
                                <i class="icon-rocket"></i>
                                <span class="title">Quản lí yêu cầu</span>
                            </a>                             
                        </li>
                        <li class="start">
                            <a href="LoadProductPage">
                                <i class="icon-handbag"></i>
                                <span class="title">Quản lí sản phẩm</span>
                            </a>
                        </li>
                        <li class="start">
                            <a href="LoadSalesPage">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lí bán hàng</span>
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
                    <input type="hidden" id="currentTab" value="${currentTab}"/>
                    <input type="hidden" id="fromDate" value="${requestScope.fromDate}">
                    <input type="hidden" id="toDate" value="${requestScope.toDate}">
                    <!-- BEGIN PAGE CONTENT-->

                    <div class="row" style="background-color: #01579b; height: 40px" >
                        <div class="col-lg-8 col-md-8" style="font-weight: bold; color: white; font-size: 150%; margin-top: 5px">

                            <i class="icon-rocket icon-lg"></i> Quản lí yêu cầu
                        </div>
                        <div class="col-lg-4 col-md-4" align="right">
                            <button data-toggle="modal" data-target="#modalAddConsignment"
                                    class="btn green" style="margin-top: 3px"><i class="fa fa-plus"></i> Tạo mới ký gửi</button>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <div id="request">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                        <div class="form-horizontal">
                                            <div class="form-group">

                                                <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Trạng thái:</label>
                                                <div class="col-md-5 col-sm-5">

                                                    <select class="form-control" id="searchStatus">
                                                        <option value="Tất cả" selected>Tất cả</option>
                                                        <option value="Chờ xử lý">Chờ xử lý</option>
                                                        <option value="Chấp nhận yêu cầu">Chấp nhận yêu cầu</option>
                                                        <option value="Từ chối yêu cầu">Từ chối yêu cầu</option>
                                                        <option value="Từ chối nhận hàng">Từ chối nhận hàng</option>
                                                        <option value="Yêu cầu đã hủy">Yêu cầu đã hủy</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <table id="requestTable" class="table table-bordered table-hover">
                                    <thead>
                                        <tr role="row" class="heading">
                                            <th>
                                                STT
                                            </th>
                                            <th>
                                                Tên Sản Phẩm
                                            </th>
                                            <th style="display: none">
                                                Mã ký gửi
                                            </th>
                                            <th>
                                                Tên khách hàng
                                            </th>
                                            <th>
                                                Ngày hẹn
                                            </th>
                                            <th>
                                                Giá (Ngàn đồng)
                                            </th>
                                            <th>
                                                Trạng thái
                                            </th>
                                            <th>
                                                Chi Tiết
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach var="c" items="${REQUEST}" varStatus="counter">
                                            <tr class="odd gradeX">
                                                <td style="font-weight: bold">${counter.count}</td>
                                                <td>
                                                    ${c.product.name}
                                                </td>
                                                <td style="display: none">
                                                    ${c.consigmentID}
                                                </td>
                                                <td>
                                                    ${c.name}
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty c.appointmentDate}">
                                                            ${c.hour}|${c.appointmentDate}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${c.fromDate}&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;${c.toDate}
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td>
                                                <td>
                                                    <fmt:formatNumber 
                                                        value="${c.desirePrice}" 
                                                        maxFractionDigits="1"/>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.consignmentStatusID == 1}">
                                                            <b><font color="green">Chờ xử lý</font></b>
                                                            </c:when>

                                                        <c:when test="${c.consignmentStatusID == 2}">
                                                            <c:choose>
                                                                <c:when test="${not empty c.reviewProductDate}">
                                                                    <b><font color="red">Từ chối nhận hàng</font></b>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                    <b><font color="red">Từ chối yêu cầu</font></b>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>

                                                        <c:when test="${c.consignmentStatusID == 3}">
                                                            <b><font color="blue">Chấp nhận yêu cầu</font></b>
                                                            </c:when>
                                                            <c:when test="${c.consignmentStatusID == 7}">
                                                            <b><font color="red">Yêu cầu đã hủy</font></b>
                                                            </c:when>

                                                    </c:choose>
                                                </td>

                                                <td align="center">
                                                    <c:choose>
                                                        <c:when test="${c.consignmentStatusID == 1 or c.consignmentStatusID == 3}">
                                                            <button type="button" class="btn btn-info" style="width: 70px; height: 30px" 
                                                                    name="requestAcceptDetails" value="${c.consigmentID}">Xem</button>        
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRefuseCancel"
                                                                    name="refuseCancelDetails" value="${c.consigmentID}">Xem</button>
                                                        </c:otherwise>
                                                    </c:choose>


                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                    <!-- END PAGE CONTENT-->
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->

        <!--BEGIN MODAL -->

        <c:set var="fCate" value="${FCATE}" />
        <c:set var="category" value="${CATEGORY}" />    

        <!--BEGIN MODAL -->
        <!-- Large modal -->

        <c:if test="${not empty requestScope.REQUEST}">

            <div id="modalRequestAccept" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #89C4F4 ">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                            <h3 class="modal-title" id="r_name" style="font-weight: bold">Thông tin chi tiết</h3>

                        </div>
                        <div class="modal-body">
                            <form id="r_form" action="ConsignmentRequestReceive" method="POST">
                                <!-- BEGIN PAGE CONTENT-->
                                <div class="row">


                                    <!-- BEGIN PRODUCT DESCRIPTION -->
                                    <div class="col-lg-8 col-md-8">

                                        <!--table-striped-->
                                        <div class="form-horizontal">
                                            <!--                                        <table class="table table-hover" style="border: none">-->
                                            <div class="form-group">
                                                <label for="txtFullName" class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Tên sản phẩm <font id="re_r_productName" color="red">*</font></label>
                                                <div id='r_productNameInput' class="col-md-9 col-sm-9">
                                                    <input id="r_productName" name="txtProductName" maxlength="100" required="true" type="text" class="form-control"/>
                                                </div>
                                                <div id='r_productNameText' class="col-md-9 col-sm-9" style="padding-top: 8px; font-size: 115%; display: none"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Loại <font id="re_r_category" color="red">*</font></label>
                                                <div class="col-md-3 col-sm-3" id="r_categoryInput">

                                                    <select id="r_category" name="txtCategoryID"  class="form-control">
                                                        <option value='' disabled selected style='display:none;'>Chọn...</option>

                                                        <c:forEach var="father" items="${fCate}">
                                                            <optgroup label="${father.categoryName}">
                                                                <c:forEach var="child" items="${category}">
                                                                    <c:if test="${child.parentId == father.categoryId}">

                                                                        <option value="${child.categoryId}">${child.categoryName}</option>




                                                                    </c:if>
                                                                </c:forEach>
                                                                <!--                                                            <a href="../src/java/hps/servlet/TrackProductStatusServlet.java"></a>-->
                                                            </optgroup>

                                                        </c:forEach>

                                                    </select>

                                                </div>
                                                <div id='r_categoryText' class="col-md-3 col-sm-3" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                                <label class="col-md-2 col-sm-2 control-label" style="font-weight: bold">Hãng</label>
                                                <div class="col-md-4 col-sm-4" id="r_brandInput"><input id="r_brand" name="txtBrand" type="text" class="form-control" ></div>
                                                <div id='r_brandText' class="col-md-3 col-sm-3" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Mô tả</label>
                                                <div class="col-md-9 col-sm-9" id="r_descriptionInput">
                                                    <textarea id="r_description" name="txtDescription" class="form-control" maxlength="225" rows="3"></textarea>
                                                </div>
                                                <div id='r_descriptionText' class="col-md-9 col-sm-9" style="padding-top: 8px; font-size: 110%; display: none"></div>

                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Độ mới <font id="re_r_newStatus" color="red">*</font></label>
                                                <div class="col-md-3 col-sm-3" id="r_newStatusInput">
                                                    <div class="input-group">
                                                        <input id="r_newStatus" name="txtNewStatus" maxlength="100" type="text" class="form-control"/> <span class="input-group-addon"><b>%</b>
                                                    </div>
                                                </div>
                                                <div id="r_newStatusText" class="col-md-3 col-sm-3" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                                <label id="label_r_isSpecial" class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Đặc biệt</label>
                                                <div id="div_r_isSpecial" class="col-md-1 col-sm-1 checkbox-list">
                                                    <label class="checkbox-inline" >
                                                        <input id="r_isSpecial" type="checkbox" name="txtIsSpecial" value="special"> 
                                                    </label>
                                                </div>
                                            </div>


                                        </div>


                                        <!--START HIDDEN ACTION VALUE -->
                                        <input id="r_ActionValue" type="hidden" name="consignmentID"/>
                                        <input id="r_productID" type="hidden" name="productID"/>
                                        <input id="r_btnAction" type="hidden" name="btnAction"/>
                                        <!--END HIDDEN ACTION VALUE -->
                                    </div>
                                    <!-- END PRODUCT DESCRIPTION -->

                                    <!-- BEGIN CAROUSEL -->
                                    <div class="col-lg-3 col-md-3 col-lg-offset-1 col-md-offset-1 front-carousel" align="left">

                                        <div class="carousel slide" id="myCarousel">
                                            <!-- Carousel items -->
                                            <div class="carousel-inner">
                                                <div class="item active">
                                                    <img id="r_image" alt="" style="max-height: 220px">
                                                    <div class="carousel-caption">
                                                        <p></p>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <!-- END CAROUSEL -->


                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày ký gửi</label>
                                                <div id='r_createdDate' class="col-md-4 col-sm-4" style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="r_divFromDateToDate">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày hẹn</label>
                                                <div class="col-md-8 col-sm-8" id="r_fromDateToDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>


                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Cách giao hàng</label>
                                                <div class="col-md-8 col-sm-8 radio-list" id="r_rdDeliveryMethodInput">
                                                    <label class="radio-list" >
                                                        <input type="radio" name="r_rdDeliveryMethod" value="store"  checked> <font color="blue">Cửa hàng đến nhận</font></label>
                                                    <label class="radio-list">
                                                        <input type="radio" name="r_rdDeliveryMethod" value="customer"> <font color="green">Tự mang đến</font></label>
                                                </div>
                                                <div id="r_rdDeliveryMethodText" class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                            <div class="form-group" id="div_r_receivedDate">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày giao hàng <font id="re_r_receivedDate" color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8" id="ar_divReceivedDateInput">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <!--                                                            <div id="r_divReceivedDate" class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="0d">-->
                                                            <input  id="r_receivedDate" type="text" class="form-control form-control-inline input-medium date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="0d" name="txtReceivedDate" value="">
                                                            <!--                                                                <span class="input-group-btn">
                                                                                                                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                                                                            </span>                                                                                                                        </div>-->
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <div id="r_divHour" class="input-group">
                                                                <input id="r_hour" name="txtHour" type="text" class="form-control timepicker timepicker-24">
                                                                <span class="input-group-btn">
                                                                    <button class="btn default" type="button"><i class="fa fa-clock-o"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>
                                                <div class="col-md-8 col-sm-8" id="ar_divReceivedDate" style="padding-top: 8px; font-size: 110%; display: none">

                                                </div>

                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá tham khảo</label>
                                                <div class="col-md-8 col-sm-8" id="r_price" style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá mong muốn</label>
                                                <div class="col-md-8 col-sm-8" id="r_desirePrice" style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                            <div class="form-group" id="ar_price" style="display: none;">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá thỏa thuận <font id="re_ar_negotiatedPrice" color="red">*</font></label>
                                                <div class="col-md-6 col-sm-6">
                                                    <input type="text" id="ar_negotiatedPrice" name="txtNegotiatedPrice" class="form-control" > (Ngàn đồng)

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal" id="r_divPersonalInfo" >
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Họ tên <font id="re_r_fullName" color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8" id="r_txtFullNameInput">
                                                    <input type="text" id="r_txtFullName" name="txtFullName"  class="form-control" maxlength="50"/>
                                                </div>
                                                <div id='r_txtFullNameText' class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại <font id="re_r_phone" color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8" id="r_txtPhoneInput">
                                                    <input type="text" id="r_txtPhone" name="txtPhone" class="form-control"/>
                                                </div>
                                                <div id='r_txtPhoneText' class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email</label>
                                                <div class="col-md-8 col-sm-8" id="r_txtEmailInput">
                                                    <input type="text" id="r_txtEmail" name="txtEmail" class="form-control"  placeholder="example@abc.com" />
                                                </div>
                                                <div id='r_txtEmailText' class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Địa chỉ</label>
                                                <div class="col-md-8 col-sm-8" id="r_txtAddressInput">
                                                    <textarea id="r_txtAddress" name="txtAddress" class="form-control" maxlength="225" rows="2"></textarea>
                                                </div>
                                                <div id="r_txtAddressText" class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                            <div class="form-group" id="div_r_rdPayment">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Cách thanh toán</label>
                                                <div class="col-md-8 col-sm-8 radio-list">
                                                    <label class="radio-inline">
                                                        <input type="radio" name="r_rdPayment"  value="direct" checked> Tiền mặt </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="r_rdPayment"  value="cc"> Tài khoản paypal </label>
                                                </div>
                                            </div>
                                            <div class="form-group" id="r_divCCNumber" style="display: none">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Mã tài khoản <font id="re_r_paypalAccount" color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8" id="r_txtPaypalAccountInput">
                                                    <input type="text" id="r_txtPaypalAccount" name="txtPaypalAccount" class="form-control" />
                                                </div>
                                                <div id='r_txtPaypalAccountText' class="col-md-8 col-sm-8" style="padding-top: 8px; font-size: 110%; display: none"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </form>
                        </div>
                        <div class="modal-footer">
                            <div id="r_footer" >

                                <button id="r_btnSubmit" class="btn btn-primary">Đồng ý</button>
                                <button name="btnRefuse" data-toggle="modal" data-target="#modalConfirm" value="r_refuse" class="btn btn-warning">Từ chối</button>
                                <button class="btn btn-default" data-dismiss="modal">Đóng</button>
                            </div>
                            <div id="ar_footer" style="display: none;">
                                <button id="ar_btnUpdateRequest" class="btn btn-success">Cập nhật</button>
                                <button id="ar_btnSubmit" class="btn btn-primary">Nhận hàng</button>
                                <button name="btnRefuse" data-toggle="modal" data-target="#modalConfirm" value="ar_refuse" class="btn btn-warning">Từ chối</button>
                                <button class="btn btn-default" data-dismiss="modal">Đóng</button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- END MODAL -->

        <!-- BEGIN MODAL -->
        <c:if test="${not empty requestScope.REQUEST}">
            <div id="modalConfirm" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #dfba49 ">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="modal-title" style="font-weight: bold">Xác nhận từ chối</h3>
                        </div>
                        <div class="modal-body">
                            <!--                            <div id="r_body_confirm">
                                                            <h3>Xin nhập lí do từ chối sản phẩm</h3>
                                                        </div>-->
                            <div id="ar_body_confirm" class="form-horizontal">

                                <div class="form-group">
                                    <label class="col-md-2 col-sm-3  control-label" style="font-weight: bold">Lí do <font color="red">*</font></label>
                                    <div class="col-md-8 col-sm-7">
                                        <textarea id="refuse_reason" type="text" class="form-control" rows="3"></textarea>
                                        <span id="ar_erReason" class="help-block">
                                        </span>
                                    </div>
                                </div>
                                <input type="hidden" id="refuse_consignmentID" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div id="r_footer_confirm">
                                <button id="r_btnRefuse" value="r_refuse" class="btn btn-warning">Xác nhận</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button> 
                            </div>
                            <div id="ar_footer_confirm">
                                <button id="ar_btnRefuse" value="ar_refuse" class="btn btn-warning">Xác nhận</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button>
                            </div>

                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </c:if>




        <!-- -->
        <div id="modalError" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #dfba49">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" style="font-weight: bold">Thông báo</h3>
                    </div>
                    <div class="modal-body" align="center">

                        <h3>Yêu cầu này đã được xử lý</h3>


                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default">Đóng</button> 
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <!-- -->



        <!--BEGIN MODAL -->
        <!-- Large modal -->
        <c:if test="${not empty requestScope.REQUEST}">
            <div id="modalRefuseCancel" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: snow">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                            <h3 class="modal-title" id="rc_name" style="font-weight: bold"></h3>
                            <div class="row">
                                <div class="col-lg-3 col-md-3"><b>Email: </b><span id="rc_email"></span></div>
                                <div class="col-lg-3 col-md-3"><b>ĐT: </b><span id="rc_phone"></span></div>
                                <div class="col-lg-5 col-md-5"><b>Địa chỉ: </b><span id="rc_address"></span></div>

                            </div>

                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <!-- BEGIN PAGE CONTENT-->
                                <div>
                                    <!-- BEGIN CAROUSEL -->
                                    <div class="col-lg-4 col-md-4 front-carousel">

                                        <div class="carousel slide" id="myCarousel">
                                            <!-- Carousel items -->
                                            <div class="carousel-inner">
                                                <div class="item active">
                                                    <img id="rc_image" alt="" style="max-height: 300px">
                                                    <div class="carousel-caption">
                                                        <p></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Carousel nav -->
                                            <a data-slide="prev" href="#myCarousel" class="carousel-control left">
                                                <i class="fa fa-angle-left"></i>
                                            </a>
                                            <a data-slide="next" href="#myCarousel" class="carousel-control right">
                                                <i class="fa fa-angle-right"></i>
                                            </a>
                                        </div>

                                    </div>
                                    <!-- END CAROUSEL -->

                                    <!-- BEGIN PRODUCT DESCRIPTION -->
                                    <div class="col-lg-8 col-md-8">


                                        <table style="font-size: 110%" class="table table-hover">
                                            <tr>
                                                <th width="30%">Tên sản phẩm</th>
                                                <td id="rc_productName"></td>
                                            </tr>

                                            <tr>
                                                <th>Độ mới</th>
                                                <td id="rc_newStatus">

                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Mô tả</th>
                                                <td id="rc_description">

                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Ngày ký gửi</th>
                                                <td id='rc_createdDate'></td>
                                            </tr>
                                            <tr >
                                                <th>Giá mong muốn</th>
                                                <td id="rc_price"></td>
                                            </tr>
                                            <!--                                        <tr>
                                                                                        <th>Ngày hẹn</th>
                                                                                        <td id='rc_fromDateToDate'></td>
                                                                                    </tr>-->
                                            <tr>
                                                <th>Trạng thái</th>
                                                <td id='rc_status'>
                                                </td>
                                            </tr>
                                            <tr id="rc_trReason">
                                                <th>Lí do</th>
                                                <td id="rc_reason">

                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                    <!-- END PRODUCT DESCRIPTION -->
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button  data-dismiss="modal" class="btn btn-default">Đóng</button>

                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- END MODAL -->


        <!--BEGIN MODAL -->
        <!-- Large modal -->

        <div id="modalAddConsignment" class="modal fade bs-example-modal-lg" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #35aa47">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" style="font-weight: bold">Tạo sản phẩm</h3>
                    </div>
                    <div class="modal-body">

                        <form id="addConsignment_form" action="AddConsignment" method="POST" enctype="multipart/form-data">
                            <div class="row">    

                                <div class="col-md-7 col-sm-7">
                                    <div class="form-horizontal">

                                        <div class="form-group">
                                            <label for="txtProductName" class="col-md-3 col-sm-3 control-label">Tên sản phẩm<font color="red">*</font></label> <!--<span class="required">*</span> -->
                                            <div class="col-md-9 col-sm-9">
                                                <input id="addConsignment_txtProductName"  name="txtProductName" type="text" class="form-control" maxlength="100" />
                                                <p class="help-block" id="erProductName">  </p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="txtSerial" class="col-md-3 col-sm-3 control-label">Mã số</label>
                                            <div class="col-md-4 col-sm-4">
                                                <input id="addConsignment_txtSerialNumber" type="text" class="form-control" name="txtSerialNumber" />
                                                <p class="help-block" id="erSerialNumber"> </p>
                                            </div>
                                            <label class="col-md-2 col-sm-2 control-label">Đặc biệt</label>
                                            <div class="col-md-2 col-sm-2 checkbox-list">
                                                <label class="checkbox-inline" >
                                                    <input type="checkbox" name="txtIsSpecial" value="special"> 
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3">Loại <font color="red">*</font></label>
                                            <div class="col-md-4 col-sm-4">
                                                <select id="addConsignment_txtCategoryID" name="txtCategoryID"  class="form-control" >
                                                    <option value='' disabled selected style='display:none;'>Chọn...</option>

                                                    <c:forEach var="father" items="${fCate}">
                                                        <optgroup label="${father.categoryName}">
                                                            <c:forEach var="child" items="${category}">
                                                                <c:if test="${child.parentId == father.categoryId}">

                                                                    <option value="${child.categoryId}">${child.categoryName}</option>




                                                                </c:if>
                                                            </c:forEach>
                                                        </optgroup>

                                                    </c:forEach>

                                                </select>
                                                <span class="help-block" id="erCategoryID">
                                                </span>
                                            </div>
                                            <label class="control-label col-md-1 col-sm-1">Hãng</label>
                                            <div class="col-md-4 col-sm-4">
                                                <input id="addConsignment_txtBrand" name="txtBrand" type="text" class="form-control" maxlength="50" value="${product.brand}"/>

                                                <span class="help-block" id="erBrand">
                                                </span>
                                            </div>
                                        </div>

                                        <!--                                            <div class="form-group">
                                                                                        <label class="control-label col-md-3 col-sm-3">Hãng</label>
                                                                                        <div class="col-md-3 col-sm-3">
                                                                                            <input id="addConsignment_txtBrand" name="txtBrand" type="text" class="form-control" maxlength="50" value="${product.brand}"/>
                                        
                                                                                            <span class="help-block" id="erBrand">
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>-->


                                        <div class="form-group">
                                            <label  class="col-md-3 col-sm-3 control-label"> Mô tả </label>
                                            <div class="col-md-9 col-sm-9">
                                                <textarea id="addConsignment_txtDescription" name="txtDescription" class="form-control" maxlength="225" rows="5" placeholder="" value="${product.description}"/>${product.description}</textarea>
                                                <span class="help-block" id="erDescription">
                                                </span>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                                <div class="col-md-5 col-sm-5">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="control-label col-md-1 col-sm-1"><font color="red"></font></label>
                                            <div class="col-md-10 col-sm-10" align="center">

                                                <div id="addConsignment_divImage" class="fileinput fileinput-new" data-provides="fileinput">
                                                    <div class="fileinput-new thumbnail" style="max-width: 250px; max-height: 200px;">
                                                        <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDI0MiAyMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjkzIiB5PSIxMDAiIHN0eWxlPSJmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MTFwdDtkb21pbmFudC1iYXNlbGluZTpjZW50cmFsIj4yNDJ4MjAwPC90ZXh0PjwvZz48L3N2Zz4=" alt=""/>
                                                    </div>
                                                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 200px;">
                                                    </div>
                                                    <div >
                                                        <span class="btn btn-info btn-file">
                                                            <span class="fileinput-new btn " >
                                                                CHỌN ẢNH </span>
                                                            <span class="fileinput-exists btn">
                                                                THAY ẢNH </span>
                                                            <input  type="file" accept='image/*' name="txtImage" />
                                                        </span>

                                                    </div>
                                                </div>


                                                <span class="help-block" id="erImage">

                                                </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4">Độ mới <font color="red">*</font></label>
                                            <div class="col-md-7 col-sm-7">
                                                <div class="input-group">
                                                    <input id="addConsignment_newStatus" name="txtNewStatus" maxlength="100" type="text" class="form-control"/> <span class="input-group-addon"><b>%</b>
                                                </div>
                                                <span class="help-block" id="erNewStatus"> </span>
                                            </div>
                                        </div>


                                    </div>
                                </div>

                            </div>
                            <hr/>
                            <div class="row">
                                <div class="col-md-6 col-sm-6">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="addConsignment_txtFullName" class="col-md-4 col-sm-4 control-label">Họ tên<font color="red">*</font></label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" id="addConsignment_txtFullName" name="txtFullName"  class="form-control" maxlength="50"  placeholder="">

                                                <p class="help-block" id="erFullName"> </p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="addConsignment_txtAddress" class="col-md-4 col-sm-4 control-label">Địa chỉ</label>
                                            <div  class="col-md-8 col-sm-8">
                                                <textarea id="addressInput" name="txtAddress" class="form-control" maxlength="225" rows="3"  placeholder="" ></textarea>
                                                <span class="help-block" id="erAddress">
                                                </span>
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="addConsignment_txtPhone" class="col-md-4 col-sm-4 control-label">Điện thoại<font color="red">*</font> </label>
                                            <div class="col-md-5 col-sm-7">
                                                <input type="text" id="addConsignment_txtPhone" name="txtPhone" class="form-control"/>
                                                <p class="help-block" id="erPhone"></p>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="addConsignment_txtEmail" class="col-md-4 col-sm-4 control-label">Email</label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" id="txtEmail" name="txtEmail" class="form-control"  placeholder="example@abc.com">
                                                <p class="help-block" id="erEmail"></p>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="" class="col-md-4 col-sm-4 control-label">Cách thanh toán</label>

                                            <div class="radio-list col-md-8 col-sm-8">

                                                <label class="radio-inline">
                                                    <input type="radio" name="rdPayment" id="optionsRadios7" value="direct" checked> Tiền mặt </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="rdPayment" id="optionsRadios8" value="cc"> Tài khoản paypal </label>



                                            </div>
                                        </div>
                                        <div id="addConsignment_divCCNumber" class="form-group" style="display: none" >
                                            <label class="col-md-4 col-sm-4 control-label">Tên tài khoản<font color="red">*</font></label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" id="addConsignment_txtPaypalAccount" name="txtPaypalAccount" class="form-control"   placeholder=""/>

                                                <p class="help-block" id="erPaypalAccount"></p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4">Giá thỏa thuận</label>
                                            <div class="col-md-5 col-sm-6">
                                                <input id="addConsignment_txtNegotiatedPrice" name="txtNegotiatedPrice" type="text" class="form-control" maxlength="50"/>

                                                <span class="help-block" id="erNegotiatedPrice">(Ngàn đồng)
                                                </span>
                                            </div>
                                        </div>
                                    </div></div>            
                            </div>
                            <input type="hidden" name="ar_searchValue" value="${param.ar_searchValue}"/>
                        </form> 

                    </div>
                    <div class="modal-footer">

                        <button id="btnAddConsignment" class="btn green">Thêm</button>
                        <button  data-dismiss="modal" class="btn btn-default">Đóng</button>


                    </div>
                </div>
            </div>
        </div>

        <!-- END MODAL -->

        <!--BEGIN MODAL-->
        <div id="modalAlert" data-backdrop="static" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #dfba49">

                        <h3 class="modal-title" style="font-weight: bold">Thông báo</h3>
                    </div>
                    <div class="modal-body" align="center">
                        <h3 id="alert_content"></h3>
                    </div>
                    <div class="modal-footer">

                        <button id="btnOK" data-dismiss="modal" class="btn btn-warning">OK</button> 
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <!--END MODAL-->


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

        <!-- START AUTO COMPLETE CSS AND JS -->

        <link rel="stylesheet" href="js/jquery-ui.css">
        <!--        <style>
                    .ui-autocomplete-loading {
                        background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
                    }
                </style>-->
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <!-- END AUTO COMPLETE -->

        <script>
            jQuery(document).ready(function () {
                // initiate layout and plugins
                Metronic.init(); // init metronic core components
                Layout.init(); // init current layout
                QuickSidebar.init(); // init quick sidebar
                Demo.init(); // init demo features
                TableManaged.init();
                ComponentsPickers.init();
            });
        </script>
        <script type="text/javascript">

            $(document).ready(function () {

//                var currentTab = window.location.hash.substring(1);
//                if (currentTab == "") {
//                    currentTab = $('#currentTab').val();
//                }
//                $('div#' + currentTab).fadeIn(400).siblings().hide();
//                $('div.portlet-title').show();
//                $('li#' + currentTab).addClass('open').siblings().removeClass('open');
//                $('html,body').scrollTop(0);


                //setEnableFieldWhenLoadRequestAcceptDetails();
                //setRequireOnRequestAcceptModal();
            });
            $(function () {
                $("#r_brand").autocomplete({
                    source: "BrandAutocomplete",
                    minLength: 1, select: function (event, ui) {
                    }
                });
            });
            $(function () {
                $("#addConsignment_txtBrand").autocomplete({
                    source: "BrandAutocomplete",
                    minLength: 1, select: function (event, ui) {
                    }
                });
            });
            function loadRefuseCancelDetails(id) {
                $.get('ConsignmentRequestReceive', {btnAction: 'consignmentdetails', id: id}, function (data) {

                    $("#rc_name").html("<small>Khách hàng: </small> " + data.name);
                    $("#rc_productName").html(data.product.name);
                    $("#rc_image").attr("src", data.product.image.replace(/\\/g, '/'));
                    $("#rc_newStatus").html(data.product.newStatus + "%");
                    $("#rc_description").html(data.product.description);
                    $("#rc_createdDate").html(data.createdDate);
                    $("#rc_email").html(data.email);
                    $("#rc_phone").html(data.phone);
                    $("#rc_address").html(data.address);                     //$("#rc_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);


                    $("#rc_price").html(formatDollar(data.desirePrice) + " (Ngàn đồng)");




                    $("#rc_trReason").hide();
                    $("#rc_reason").html("");
                    if (data.product.productStatusID == 6) {
                        $("#rc_status").html("<b><font color='red'>ĐĂNG KÝ HỦY</font></b>");
                    }
                    else {
                        if (data.consignmentStatusID == 1) {
                            $("#rc_status").html("<b><font color='blue'>CHỜ XỬ LÝ</font></b>");
                        } else if (data.consignmentStatusID == 3) {
                            $("#rc_status").html("<b><font color='green'>ĐÃ CHẤP NHẬN</font></b>");
                        } else if (data.consignmentStatusID == 2) {
                            if (data.reviewProductDate != null) {
                                $("#rc_status").html("<b><font color='red'>TỪ CHỐI KHI NHẬN HÀNG</font></b>");
                            } else {
                                $("#rc_status").html("<b><font color='red'>TỪ CHỐI KHI DUYỆT HÀNG</font></b>");
                            }

                            $("#rc_trReason").show();
                            $("#rc_reason").html(data.reason);
                        } else if (data.consignmentStatusID == 4) {
                            $("#rc_status").html("<b><font color='blue'>HOÀN THÀNH</font></b>");
                        } else if (data.consignmentStatusID == 6) {
                            $("#rc_status").html("<b><font color='red'>ĐÃ HẾT HẠN</font></b>");
                        }
                        else if (data.consignmentStatusID == 5) {
                            if (data.product.productStatusID == 2) {
                                $("#rc_status").html("<b><font color='blue'>ĐÃ NHẬN HÀNG</font></b>");
                            }
                            else if (data.product.productStatusID == 3) {
                                $("#rc_status").html("<b><font color='blue'>ĐAND TRÊN WEB</font></b>");
                            }
                            else if (data.product.productStatusID == 4) {
                                $("#rc_status").html("<b><font color='blue'>ĐÃ ĐƯỢC ĐẶT</font></b>");
                            }
                            else if (data.product.productStatusID == 5) {
                                $("#rc_status").html("<b><font color='blue'>ĐÃ BÁN</font></b>");
                            }
                        }
                        else if (data.consignmentStatusID == 7) {
                            $("#rc_status").html("<b><font color='red'>HOÀN TẤT HỦY</font></b>");
                        }
                    }
                });
            }

            function setEnableFieldForNewRequest() {
                $("#r_productNameText").show();
                $('#r_categoryText').show();
                $("#r_brandText").show();
                $("#r_descriptionText").show();
                $("#r_newStatusText").show();
                $("#r_rdDeliveryMethodText").show();

                $("#r_newStatusInput").hide();
                $("#r_productNameInput").hide();
                $('#r_categoryInput').hide();
                $("#r_brandInput").hide();
                $("#r_descriptionInput").hide();
                //$("#r_newStatusInput").hide();
                //$("input[name='r_rdDeliveryMethod']").attr("disabled", true);
                $("#r_rdDeliveryMethodInput").hide();


                $("#r_txtFullNameText").show();
                $("#r_txtAddressText").show();
                $("#r_txtPhoneText").show();
                $("#r_txtEmailText").show();
                $("#r_txtPaypalAccountText").show();

                $("#r_txtFullNameInput").hide();
                $("#r_txtAddressInput").hide();
                $("#r_txtPhoneInput").hide();
                $("#r_txtEmailInput").hide();
                $("#r_txtPaypalAccountInput").hide();
                //$("input[name='r_rdPayment']").attr("disabled", true);

                $("#div_r_rdPayment").hide();


                $("#div_r_isSpecial").hide();
                $("#label_r_isSpecial").hide();
            }

            function setEnableFieldForAcceptedRequest() {
                $("#r_productNameText").hide();
                $('#r_categoryText').hide();
                $("#r_brandText").hide();
                $("#r_descriptionText").hide();
                $("#r_newStatusText").hide();
                $("#r_rdDeliveryMethodText").hide();

                $("#r_newStatusInput").show();
                $("#r_productNameInput").show();
                $('#r_categoryInput').show();
                $("#r_brandInput").show();
                $("#r_descriptionInput").show();
                $("#r_newStatusInput").show();
                //$("input[name='r_rdDeliveryMethod']").attr("disabled", true);
                $("#r_rdDeliveryMethodInput").show();


                $("#r_txtFullNameText").hide();
                $("#r_txtAddressText").hide();
                $("#r_txtPhoneText").hide();
                $("#r_txtEmailText").hide();
                $("#r_txtPaypalAccountText").hide();

                $("#r_txtFullNameInput").show();
                $("#r_txtAddressInput").show();
                $("#r_txtPhoneInput").show();
                $("#r_txtEmailInput").show();
                $("#r_txtPaypalAccountInput").show();
                //$("input[name='r_rdPayment']").attr("disabled", true);

                $("#div_r_rdPayment").show();


                $("#div_r_isSpecial").show();
                $("#label_r_isSpecial").show();
            }

            function loadRequestAcceptDetails(id) {
                $.get('ConsignmentRequestReceive', {btnAction: 'consignmentdetails', id: id}, function (data) {
                    if (data.product.productStatusID == 6) {
                        $("#modalError").modal("show");
                    }
                    else {
                        if (data.consignmentStatusID == 1 || data.consignmentStatusID == 3) {
                            //$("#r_name").html("<small>Khách hàng: </small> " + data.name);

                            $("#r_image").attr("src", data.product.image.replace(/\\/g, '/'));
                            $("#r_createdDate").html(data.createdDate);
                            $("#r_fromDateToDate").html(data.fromDate + "&nbsp;<i class='fa fa-long-arrow-right'></i>&nbsp;" + data.toDate);

                            if (data.minPrice > 0 && data.maxPrice > 0) {
                                $("#r_price").html(formatDollar(data.minPrice) + "  ~  " + formatDollar(data.maxPrice) + " (Ngàn đồng)");
                            } else {
                                $("#r_price").html("<font color='red'>Không có giá </font>");
                            }
                            $("#r_desirePrice").html(formatDollar(data.desirePrice) + " (Ngàn đồng)");


                            //$("#r_productID").val(data.product.productID);
                            $("#r_ActionValue").val(data.consigmentID);


                            //$("#r_divPersonalInfo").hide();
                            $("#refuse_consignmentID").val(data.consigmentID);

                            if (data.consignmentStatusID == 1 && data.product.productStatusID == 1) {
                                setEnableFieldForNewRequest();
                                setRequireOnRequestdModal();
                                $("#r_productNameText").html(data.product.name);
                                $('#r_category').val(data.product.categoryID).change();
                                $('#r_categoryText').html($('#r_category option:selected').text());
                                $("#r_brandText").html(data.product.brand);

                                if ($("#r_brandText").html() == "") {
                                    $("#r_brandText").html("---");
                                }

                                $("#r_descriptionText").html(data.product.description);
                                if ($("#r_descriptionText").html() == "") {
                                    $("#r_descriptionText").html("---");
                                }
                                //alert(data.product.newStatus);
                                $("#r_newStatusText").html("<b>" + data.product.newStatus + "%</b>");


                                $("#r_txtFullNameText").html(data.name);
                                $("#r_txtPhoneText").html(data.phone);

                                $("#r_txtEmailText").html(data.email);
                                if ($("#r_txtEmailText").html().length == 0) {
                                    $("#r_txtEmailText").html("----");
                                }
                                $("#r_txtAddressText").html(data.address);

                                if ($("#r_txtAddressText").html().length == 0) {
                                    $("#r_txtAddressText").html("----");
                                }

                                if (data.paypalAccount != null) {
                                    $("#r_txtPaypalAccountText").html(data.paypalAccount);
                                    $("#r_divCCNumber").show();
                                } else {
                                    $("#r_txtPaypalAccountText").html("");
                                    $("#r_divCCNumber").hide();
                                }

                                if (data.deliveryMethod == 0) {
                                    $("#r_rdDeliveryMethodText").html("<font color='blue'>Cửa hàng đến nhận</font>");
                                } else {
                                    $("#r_rdDeliveryMethodText").html("<font color='green'>Tự mang đến</font>");
                                }


                                $("#r_footer").show();
                                $("#ar_footer").hide();
                                $("#ar_price").hide();
                                $("#r_btnAction").val("r_accept");

                                //$("#r_receivedDate").val(getCurrentDate());
                                if (compareToCurrentDate(data.fromDate)) {
                                    $("#r_receivedDate").val(data.fromDate);
                                } else {
                                    if (compareToCurrentDate(data.toDate)) {
                                        $("#r_receivedDate").val(data.toDate);
                                    } else {
                                        $("#r_receivedDate").val(getCurrentDate());
                                    }
                                }

                                $("#div_r_receivedDate").show();


                                $("#modalRequestAccept").modal("show");

                                //$("#r_divPersonalInfo").show();
                            } else if (data.consignmentStatusID == 3 && data.product.productStatusID == 1) {
                                setEnableFieldForAcceptedRequest();
                                setRequireOnAcceptedModal();
                                $("#r_productName").val(data.product.name);
                                $('#r_category').val(data.product.categoryID).change();
                                $("#r_brand").val(data.product.brand);
                                $("#r_description").val(data.product.description);
                                $("#r_newStatus").val(data.product.newStatus);
                                if (data.deliveryMethod == 0) {
                                    $("input[name='r_rdDeliveryMethod'][value='store']").attr("checked", true).parent().addClass("checked");
                                    $("input[name='r_rdDeliveryMethod'][value='customer']").attr("checked", false).parent().removeClass("checked");
                                } else {
                                    $("input[name='r_rdDeliveryMethod'][value='customer']").attr("checked", true).parent().addClass("checked");
                                    $("input[name='r_rdDeliveryMethod'][value='store']").attr("checked", false).parent().removeClass("checked");
                                }
                                if (data.product.isSpecial > 0) {
                                    $("input#r_isSpecial").attr("checked", true).parent().addClass("checked");
                                } else {
                                    $("input#r_isSpecial").attr("checked", false).parent().removeClass("checked");
                                }


                                $('#ar_negotiatedPrice').val("");

                                $("#ar_footer").show();
                                $("#r_footer").hide();
                                $("#ar_price").show();
                                $("#r_btnAction").val("ar_accept");

                                $("#r_receivedDate").val(data.appointmentDate);
                                $("#r_hour").val(data.hour);

                                //$("#r_divPersonalInfo").show();
                                $("#r_txtFullName").val(data.name);
                                $("#r_txtAddress").val(data.address);
                                $("#r_txtPhone").val(data.phone);
                                $("#r_txtEmail").val(data.email);

                                if (data.paypalAccount != null) {
                                    $("#r_txtPaypalAccount").val(data.paypalAccount);
                                    $("input[name='r_rdPayment'][value='cc']").attr("checked", true).parent().addClass("checked");
                                    $("input[name='r_rdPayment'][value='direct']").attr("checked", false).parent().removeClass("checked");
                                    $("#r_divCCNumber").show();
                                } else {
                                    $("#r_txtPaypalAccount").val("");
                                    $("input[name='r_rdPayment'][value='direct']").attr("checked", true).parent().addClass("checked");
                                    $("input[name='r_rdPayment'][value='cc']").attr("checked", false).parent().removeClass("checked");
                                    $("#r_divCCNumber").hide();
                                }

                                if (formatDate(new Date()) == data.appointmentDate) {
                                    //$("#ar_btnUpdateRequest").hide();
                                    $("#ar_divReceivedDateInput").hide();
                                    $("#ar_divReceivedDate").show();
                                    $("#ar_divReceivedDate").html(data.hour + "|" + data.appointmentDate);
                                    $("#re_r_receivedDate").hide();
                                    //$("input[name='r_rdDeliveryMethod']").attr("disabled", true);

                                } else {
                                    //$("#ar_btnUpdateRequest").show();
                                    $("#ar_divReceivedDateInput").show();
                                    $("#ar_divReceivedDate").hide();
                                    //$("ar_divReceivedDate").html(data.hour + "|" + data.appointmentDate);
                                    $("#re_r_receivedDate").show();
                                    //$("input[name='r_rdDeliveryMethod']").attr("disabled", false);
                                }

                                $("#modalRequestAccept").modal("show");

                            } else {
                                $("#modalError").modal("show");
                            }
                        }
                        else {
                            $("#modalError").modal("show");
                        }

                    }
                });

                //$("#modalRequestAccept").modal("show");

            }

            $('button[name="requestAcceptDetails"]').click(function () {
                var id = $(this).val();
                loadRequestAcceptDetails(id);
            });
            $('button[name="refuseCancelDetails"]').click(function () {
                var id = $(this).val();
                loadRefuseCancelDetails(id);
            });
            $('button[name="btnRefuse"]').click(function () {
                //                var action = $(this).val();
                if ($(this).val() == "ar_refuse") {
                    $('#ar_footer_confirm').show();
                    $('#r_footer_confirm').hide();
                } else if ($(this).val() == "r_refuse") {
                    $('#ar_footer_confirm').hide();
                    $('#r_footer_confirm').show();
                }
            });

            $('#r_btnRefuse').click(function () {
                if ($("#refuse_reason").val().trim() == "") {
                    $("#ar_erReason").html("<font color='red'>Xin nhập lí do</font>");
                    return;
                }
                $("#ar_erReason").html("");
                refuseRequest();
            });

            $('#ar_btnRefuse').click(function () {
                var reason = $("#refuse_reason").val();
                if ($("#refuse_reason").val().trim() == "") {
                    $("#ar_erReason").html("<font color='red'>Xin nhập lí do</font>");
                    return;
                }
                $("#ar_erReason").html("");
                refuseProduct();

            });


            $('#r_btnSubmit').click(function () {
                var check = true;
//                if ($('#r_productName').val().length <= 0 || $('#r_productName').val().length > 100) {
//                    check = false;
//                }
                if ($('#r_hour').val().length == 0) {
                    check = false;
                }
                if ($('#r_receivedDate').val().length == 0) {
                    check = false;
                }
//                if ($('#r_txtFullName').val().length <= 0 || $('#r_txtFullName').val().length > 50) {
//                    check = false;
//                }
//
//                if ($('#r_txtPhone').val().length < 10 || $('#r_txtPhone').val().substring(0, 1) != "0") {
//                    check = false;
//                }
//                if ($("input[name='r_rdPayment'][value='cc']").is(":checked")) {
//                    if ($('#r_txtPaypalAccount').val().length == 0) {
//                        check = false;
//                    }
//                }

                if (check) {
                    //$('form#r_form').submit();
                    acceptRequest();
                } else {
                    showAlert("Xin nhập đúng thông tin");
                }

            });
            $('#ar_btnSubmit').click(function () {
                var check = true;
                if ($('#r_productName').val().length == 0 || $('#r_productName').val().length > 100) {
                    check = false;
                }
                if ($('#r_hour').val().length == 0) {
                    check = false;
                }
                if ($('#r_receivedDate').val().length == 0) {
                    check = false;
                }
                if ($('#r_txtFullName').val().length <= 0 || $('#r_txtFullName').val().length > 50) {
                    check = false;
                }

                if ($('#r_txtPhone').val().length < 10 || $('#r_txtPhone').val().substring(0, 1) != "0") {
                    check = false;
                }
                if ($("input[name='r_rdPayment'][value='cc']").is(":checked")) {
                    if ($('#r_txtPaypalAccount').val().length == 0) {
                        check = false;
                    }
                }

                var newStatus = $('#r_newStatus').val();
                if (newStatus.length == 0) {
                    check = false;
                } else {
                    if (isNaN(newStatus)) {
                        check = false;
                    } else {
                        if (newStatus.indexOf(".") > -1) {
                            check = false;
                        } else {
                            var numStatus = parseInt(newStatus);
                            if (numStatus > 100 || numStatus < 0) {
                                check = false;
                            }
                        }
                    }
                }

                if (check) {
                    var negotiatedPrice = $('#ar_negotiatedPrice').val();
                    if (!isNaN(negotiatedPrice) && negotiatedPrice.length > 0) {
                        //$('form#r_form').submit();
                        if (parseFloat(negotiatedPrice) > 0) {
                            acceptProduct();
                        } else {
                            showAlert("Giá thỏa thuận phải lớn hơn 0!");
                        }


                    } else {
                        showAlert("Xin nhập đúng giá thỏa thuận!")
                    }
                } else {

                    showAlert("Xin nhập đầy đủ thông tin");
                }
            });
            $('#ar_btnUpdateRequest').click(function () {
                var check = true;
                if ($('#r_productName').val().length == 0 || $('#r_productName').val().length > 100) {
                    check = false;
                }
                if ($('#r_hour').val().length == 0) {
                    check = false;
                }
                if ($('#r_receivedDate').val().length == 0) {
                    check = false;
                }
                if ($('#r_txtFullName').val().length <= 0 || $('#r_txtFullName').val().length > 50) {
                    check = false;
                }

                if ($('#r_txtPhone').val().length < 10 || $('#r_txtPhone').val().substring(0, 1) != "0") {
                    check = false;
                }
                if ($("input[name='r_rdPayment'][value='cc']").is(":checked")) {
                    if ($('#r_txtPaypalAccount').val().length == 0) {
                        check = false;
                    }
                }

                var newStatus = $('#r_newStatus').val();
                if (newStatus.length == 0) {
                    check = false;
                } else {
                    if (isNaN(newStatus)) {
                        check = false;
                    } else {
                        if (newStatus.indexOf(".") > -1) {
                            check = false;
                        } else {
                            var numStatus = parseInt(newStatus);
                            if (numStatus > 100 || numStatus < 0) {
                                check = false;
                            }
                        }
                    }
                }

                if (check) {
                    updateRequest();
                } else {
                    showAlert("Xin nhập đầy đủ thông tin")
                }
            });

            function updateRequest() {
                showAlert("Đang xử lí...");
                $("#btnOK").hide();
                var consignmentID = $("#r_ActionValue").val();
                var productName = $("#r_productName").val();
                var categoryID = $("#r_category").val();
                var brand = $("#r_brand").val();
                var description = $("#r_description").val();
                var appointmentDate = $("#r_receivedDate").val();
                var hour = $("#r_hour").val();
                var isSpecial = 0;
                if ($("input#r_isSpecial").is(":checked")) {
                    isSpecial = 1;
                }
                var fullName = $("#r_txtFullName").val();
                var address = $("#r_txtAddress").val();
                var phone = $("#r_txtPhone").val();
                var email = $("#r_txtEmail").val();
                var paypalAccount = $("#r_txtPaypalAccount").val();
                if ($("input[name='r_rdPayment'][value='direct']").is(":checked")) {
                    paypalAccount = "";
                }
                var deliveryMethod = $("input[name='r_rdDeliveryMethod']:checked").val();
                var newStatus = $("#r_newStatus").val();

                $.get('ConsignmentRequestReceive',
                        {btnAction: 'updateRequest', consignmentID: consignmentID, productName: productName,
                            categoryID: categoryID, brand: brand, description: description,
                            appointmentDate: appointmentDate, hour: hour, deliveryMethod: deliveryMethod,
                            isSpecial: isSpecial, fullName: fullName, address: address, phone: phone,
                            email: email, paypalAccount: paypalAccount, newStatus: newStatus},
                function (data) {
                    if (data == "success") {
                        var consignmentTD = $("td:contains('" + consignmentID + "')");
                        consignmentTD.prev().html(productName);
                        consignmentTD.next().html(hour + "|" + appointmentDate);
                        if (deliveryMethod == "customer") {
                            consignmentTD.next().next().html("<b><font color='green'>Tự mang đến</font></b>");
                        } else {
                            consignmentTD.next().next().html("<b><font color='blue'>Cửa hàng đến nhận</font></b>");
                        }
                        //consignmentTD.next().next().next().html(hour + "|" + appointmentDate);
                        changeContentAlert("Cập nhật thành công");
                    } else if (data == "fail") {
                        changeContentAlert("Cập nhật thất bại");
                    }
                    else if (data == "error") {
                        changeContentAlert("Yêu cầu đã được xử lý");
                    }
                    $("#btnOK").show();
                });
            }

            function acceptProduct() {
                showAlert("Đang xử lí...");
                $("#btnOK").hide();
                var consignmentID = $("#r_ActionValue").val();
                var productName = $("#r_productName").val();
                var categoryID = $("#r_category").val();
                var brand = $("#r_brand").val();
                var description = $("#r_description").val();
                var appointmentDate = $("#r_receivedDate").val();
                var hour = $("#r_hour").val();
                var isSpecial = 0;
                if ($("input#r_isSpecial").is(":checked")) {
                    isSpecial = 1;
                }
                var fullName = $("#r_txtFullName").val();
                var address = $("#r_txtAddress").val();
                var phone = $("#r_txtPhone").val();
                var email = $("#r_txtEmail").val();
                var paypalAccount = $("#r_txtPaypalAccount").val();
                if ($("input[name='r_rdPayment'][value='direct']").is(":checked")) {
                    paypalAccount = "";
                }
                var deliveryMethod = $("input[name='r_rdDeliveryMethod']:checked").val();
                var negotiatedPrice = $("#ar_negotiatedPrice").val();

                var newStatus = $("#r_newStatus").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: 'ar_accept', consignmentID: consignmentID, productName: productName,
                            categoryID: categoryID, brand: brand, description: description,
                            negotiatedPrice: negotiatedPrice, appointmentDate: appointmentDate, hour: hour,
                            deliveryMethod: deliveryMethod, isSpecial: isSpecial,
                            fullName: fullName, address: address, phone: phone, email: email,
                            paypalAccount: paypalAccount, newStatus: newStatus},
                function (data) {
                    $("#btnOK").show();
                    if (data == "success") {
                        changeContentAlert("Đã nhận sản phẩm");
                        location.reload();
                    } else if (data == "fail") {
                        changeContentAlert("Không thể nhận sản phẩm");
                    }
                    else if (data == "error") {
                        changeContentAlert("Yêu cầu đã được xử lý");
                    }
                });
            }

            function refuseProduct() {
                showAlert("Đang xử lí...");
                $("#btnOK").hide();
                var consignmentID = $("#refuse_consignmentID").val();
                var reason = $("#refuse_reason").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: "ar_refuse", consignmentID: consignmentID, reason: reason, },
                        function (data) {
                            $("#btnOK").show();
                            if (data == "success") {
                                showAlert("Đã từ chối sản phẩm");
                                location.reload();
                            } else if (data == "fail") {
                                showAlert("Có lỗi xảy ra");
                            }
                            else if (data == "error") {
                                showAlert("Yêu cầu đã được xử lý");
                            }
                        });
            }
            function acceptRequest() {
                showAlert("Đang xử lí...");
                $("#btnOK").hide();
                var consignmentID = $("#r_ActionValue").val();
                var deliveryMethod = $("input[name='r_rdDeliveryMethod']:checked").val();
                var appointmentDate = $("#r_receivedDate").val();
                var hour = $("#r_hour").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: 'r_accept', consignmentID: consignmentID, deliveryMethod: deliveryMethod,
                            appointmentDate: appointmentDate, hour: hour},
                function (data) {
                    $("#btnOK").show();
                    if (data == "success") {
                        changeContentAlert("Đã chấp nhận yêu cầu");
                        location.reload();
                    } else if (data == "fail") {
                        changeContentAlert("Cập nhật thất bại");
                    }
                    else if (data == "error") {
                        changeContentAlert("Yêu cầu đã được xử lý");
                    }
                });
            }

            function refuseRequest() {
                showAlert("Đang xử lí...");
                $("#btnOK").hide();
                var consignmentID = $("#refuse_consignmentID").val();
                var reason = $("#refuse_reason").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: "r_refuse", consignmentID: consignmentID, reason: reason, },
                        function (data) {
                            $("#btnOK").show();
                            if (data == "success") {
                                changeContentAlert("Đã từ chối yêu cầu");
                                location.reload();
                            } else if (data == "fail") {
                                changeContentAlert("Có lỗi xảy ra");
                            }
                            else if (data == "error") {
                                changeContentAlert("Yêu cầu đã được xử lý");
                            }
                        });
            }

            $('input:radio[name="rdPayment"]').change(function () {
                if ($(this).val() == "cc") {
                    $("#addConsignment_divCCNumber").show();
                }
                else {
                    $("#addConsignment_divCCNumber").hide();
                }
            });

            $('input:radio[name="r_rdPayment"]').change(function () {
                if ($(this).val() == "cc") {
                    $("#r_divCCNumber").show();
                }
                else {
                    $("#r_divCCNumber").hide();
                }
            });

            function formatDollar(num) {
                var p = num.toFixed(0);
                return  p.split("").reverse().reduce(function (acc, num, i, orig) {
                    return  num + (i && !(i % 3) ? "," : "") + acc;
                }, "");
            }

            function getCurrentDate() {
                var d = new Date(), month = '' + (d.getMonth() + 1),
                        day = '' + (d.getDate()),
                        year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [day, month, year].join('-');
            }

            $('#btnAddConsignment').click(function () {
                var check = true;
                if ($('#addConsignment_txtProductName').val().trim().length < 5 || $('#addConsignment_txtProductName').val().trim().length > 100) {
                    $('#erProductName').html("<font color='red'>Yệu cầu 5-100 ký tự</font>");
                    check = false;
                }
                else {
                    $('#erProductName').html("");
                }
                if ($('#addConsignment_txtCategoryID').val() == null) {
                    $('#erCategoryID').html("<font color='red'>Xin chọn loại hàng</font>");
                    check = false;
                } else {
                    $('#erCategoryID').html("");
                }


                if ($('#addConsignment_txtFullName').val().trim().length < 5 || $('#addConsignment_txtFullName').val().trim().length > 50) {
                    $('#erFullName').html("<font color='red'>Yêu cầu 5-50 ký tự</font>");
                    check = false;
                }
                else {
                    $('#erFullName').html("");
                }


                if ($('#addConsignment_txtPhone').val().trim().length < 10) {
                    $('#erPhone').html("<font color='red'>Xin nhập số điện thoại ít nhất 10 chữ số</font>");
                    check = false;
                }
                else {
                    $('#erPhone').html("");
                }

                var payment = $('input:radio[name="rdPayment"]:checked').val();
                if (payment == "cc") {
                    if ($('#addConsignment_txtPaypalAccount').val().trim().length == 0) {
                        $('#erPaypalAccount').html("<font color='red'>Xin nhập tài khoản</font>");
                        check = false;
                    }
                    else {
                        $('#erPaypalAccount').html("");
                    }
                }


                if ($('#addConsignment_divImage').attr("class") == "fileinput fileinput-new") {
                    $('#erImage').html("<font color='red'>Xin đăng ảnh thật của sản phẩm</font>");
                    check = false;
                } else {
                    $('#erImage').html("");
                }


                var newStatus = $('#addConsignment_newStatus').val();
                if (newStatus.length == 0) {
                    $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-100</font>");
                    check = false;
                } else {
                    if (isNaN(newStatus)) {
                        $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-100</font>");
                        check = false;
                    } else {
                        if (newStatus.indexOf(".") > -1) {
                            $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-100</font>");
                            check = false;
                        } else {
                            var numStatus = parseInt(newStatus);
                            if (numStatus > 100 || numStatus < 1) {
                                $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-100</font>");
                                check = false;
                            } else {
                                $('#erNewStatus').html("");
                            }
                        }
                    }
                }
                var negotiatedPrice = $('#addConsignment_txtNegotiatedPrice').val();
                if (negotiatedPrice.length > 0 && !isNaN(negotiatedPrice)) {
                    if (parseFloat(negotiatedPrice) > 0) {
                        $('#erNegotiatedPrice').html("");
                    } else {
                        $('#erNegotiatedPrice').html("<font color='red'>Giá phải lớn hơn 0</font>");
                        check = false;
                    }
                }
                else {
                    $('#erNegotiatedPrice').html("<font color='red'>Xin nhập kiểu số</font>");
                    check = false;
                }


                if (check) {
                    $('form#addConsignment_form').submit();
                }

            });

            function formatDate(date) {
                var d = new Date(date), month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [day, month, year].join('-');
            }

//            $(document).ready(function () {
//                $('#daterangeAccepted').daterangepicker({
//                    format: "DD/MM/YYYY",
//                    startDate: moment(),
//                    endDate: moment(),
//                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
//                });
//                $('#daterangeRequest').daterangepicker({
//                    format: "DD/MM/YYYY",
//                    startDate: moment(),
//                    endDate: moment(),
//                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
//                });
//                $('#daterangeRefuse').daterangepicker({
//                    format: "DD/MM/YYYY",
//                    startDate: moment(),
//                    endDate: moment(),
//                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
//                });
//                $('#daterangeCancel').daterangepicker({
//                    format: "DD/MM/YYYY",
//                    startDate: moment(),
//                    endDate: moment(),
//                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
//                });
//            });
//            $('#daterangeAccepted').on('apply.daterangepicker', function (ev, picker) {
//                var table = $('#acceptedTable').DataTable();
//                var startDate = $('#daterangeAccepted').data('daterangepicker').startDate.format('DD/MM/YYYY');
//                var endDate = $('#daterangeAccepted').data('daterangepicker').endDate.format('DD/MM/YYYY');
//                $('#fromDate').val(startDate);
//                $('#toDate').val(endDate);
//                table.draw();
//            });
//            $('#daterangeRequest').on('apply.daterangepicker', function (ev, picker) {
//                var table = $('#requestTable').DataTable();
//                var startDate = $('#daterangeRequest').data('daterangepicker').startDate.format('DD/MM/YYYY');
//                var endDate = $('#daterangeRequest').data('daterangepicker').endDate.format('DD/MM/YYYY');
//                $('#fromDate').val(startDate);
//                $('#toDate').val(endDate);
//                table.draw();
//            });
//            $('#daterangeRefuse').on('apply.daterangepicker', function (ev, picker) {
//                var table = $('#refuseTable').DataTable();
//                var startDate = $('#daterangeRefuse').data('daterangepicker').startDate.format('DD/MM/YYYY');
//                var endDate = $('#daterangeRefuse').data('daterangepicker').endDate.format('DD/MM/YYYY');
//                $('#fromDate').val(startDate);
//                $('#toDate').val(endDate);
//                table.draw();
//            });
//            $('#daterangeCancel').on('apply.daterangepicker', function (ev, picker) {
//                var table = $('#cancelTable').DataTable();
//                var startDate = $('#daterangeCancel').data('daterangepicker').startDate.format('DD/MM/YYYY');
//                var endDate = $('#daterangeCancel').data('daterangepicker').endDate.format('DD/MM/YYYY');
//                $('#fromDate').val(startDate);
//                $('#toDate').val(endDate);
//                table.draw();
//            });
//            $.fn.dataTable.ext.search.push(
//                    function (settings, data, dataIndex) {
//                        var startDate = $('#fromDate').val();
//                        var endDate = $('#toDate').val();
//                        if (startDate == "" || endDate == "") {
//                            return true;
//                        } else {
//
//                            if ($("#currentTab").val() == "accepted") {
//                                var date = data[3].substring(6);
//                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
//                                    return true;
//                                } else {
//                                    return false;
//                                }
//                            }
//                            else if ($("#currentTab").val() == "request") {
//                                var date = data[3].substring(6);
//                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
//
//                                    return true;
//                                }
//
//                                else
//                                {
//                                    return false;
//                                }
//
//                            } else if ($("#currentTab").val() == "cancel") {
//                                var date = data[4].substring(6);
//                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
//                                    return true;
//                                } else {
//                                    return false;
//                                }
//                            }
//                            else if ($("#currentTab").val() == "refuse") {
//                                var date = data[4].substring(6);
//                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
//                                    return true;
//                                } else {
//                                    return false;
//                                }
//                            }
//                        }
//
//                    }
//            );

//            function compareDate(source, target) {//return -1 if source < target, 1 if source > target and 0 if source = target
//                //source = source.substring(6);
//                if (source.substring(6, 10) > target.substring(6, 10)) {
//                    return 1;
//                }
//
//                else if (source.substring(3, 5) > target.substring(3, 5) && source.substring(6, 10) == target.substring(6, 10)) {
//                    return 1;
//                }
//                else if (source.substring(0, 2) > target.substring(0, 2) && source.substring(3, 5) == target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
//                    return 1;
//                } else if (source.substring(0, 2) == target.substring(0, 2)) {
//                    return 1;
//                }
//                return -1;
//            }
            function showAlert(content) {
                $("#modalAlert").modal("show");
                $("#alert_content").html(content);
            }

            function changeContentAlert(content) {
                $("#alert_content").html(content);
            }

            function setRequireOnAcceptedModal() {
                $("#re_r_productName").show();
                $("#re_r_category").show();
                $("#re_r_newStatus").show();
                $("#re_r_receivedDate").show();
                $("#re_r_fullName").show();
                $("#re_r_phone").show();
                $("#re_r_paypalAccount").show();
            }

            function setRequireOnRequestdModal() {

                $("#re_r_productName").hide();
                $("#re_r_category").hide();
                $("#re_r_newStatus").hide();
                $("#re_r_receivedDate").hide();
                $("#re_r_fullName").hide();
                $("#re_r_phone").hide();
                $("#re_r_paypalAccount").hide();
            }

            function compareToCurrentDate(target) {
                var fromParts = target.split("-");
                var date1 = new Date(fromParts[2], // year
                        fromParts[1] - 1, // month, starts with 0
                        fromParts[0]); // day

                var currentDate = new Date();
                if (date1 < currentDate) {
                    return false;
                }
                else {
                    return true;
                }
            }

            $("#searchStatus").change(function () {
                var table = $('#requestTable').DataTable();
                table.draw();
            });

            $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var searchStatus = $("#searchStatus").val();
                        var status = data[6];

                        if(searchStatus == "Tất cả"){
                            return true;
                        }else if (status == searchStatus) {
                            return true;
                        }else{
                            return false;
                        }

                    }
            );
        </script> 


    </body>
    <!-- END BODY -->
</html>
