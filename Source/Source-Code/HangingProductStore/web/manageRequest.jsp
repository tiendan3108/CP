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
                                <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">StoreOwner1</span>
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
                        <li style="margin-bottom: 20px" class="sidebar-toggler-wrapper">
                            <div class="sidebar-toggler">
                            </div>
                        </li>
                        <li class="start active">
                            <a href="javascript:;">
                                <i class="icon-rocket"></i>
                                <span class="title">Quản lí yêu cầu</span>
                                <span class="arrow open"></span>
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
                        <li>
                            <a href="javascript:;">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lí hàng kí gửi</span>
                                <span class="arrow "></span>
                            </a>
                            <ul class="sub-menu">
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
                    <input type="hidden" id="currentTab" value="${currentTab}"/>
                    <!-- BEGIN PAGE CONTENT-->

                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <div class="portlet box blue">

                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-globe"></i>Yêu cầu
                                        <c:choose>
                                            <c:when test="${requestScope.currentTab == 'request'}">
                                                chưa duyệt
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'accepted'}">
                                                đã duyệt
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'refuse'}">
                                                đã từ chối
                                            </c:when>
                                            <c:when test="${requestScope.currentTab == 'cancel'}">
                                                đã hủy
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>


                                <div class="portlet-body"  id="request" style="display: none">
                                    <table class="table table-striped table-bordered table-hover" id="requestTable">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>
                                                    STT
                                                </th>
                                                <th>
                                                    Tên Sản Phẩm
                                                </th>
                                                <th>
                                                    Mã ký gửi
                                                </th>
                                                <th>
                                                    Ngày tạo yêu cầu
                                                </th>
                                                <th>
                                                    Giá (Ngàn đồng)
                                                </th>
                                                <th>
                                                    Ngày hẹn
                                                </th>
                                                <th>
                                                    Chi Tiết
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="c" items="${REQUEST}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td>${counter.count}</td>
                                                    <td>
                                                        ${c.product.name}
                                                    </td>
                                                    <td>
                                                        ${c.consigmentID}
                                                    </td>
                                                    <td>
                                                        ${c.createdDate}

                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${c.minPrice > 0 and c.maxPrice > 0}">
                                                                <fmt:formatNumber 
                                                                    value="${c.minPrice}" 
                                                                    maxFractionDigits="1"/>
                                                                &nbsp; ~ &nbsp;
                                                                <fmt:formatNumber 
                                                                    value="${c.maxPrice}" 
                                                                    maxFractionDigits="1"/> 
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b><font color="red">Không có giá</font></b>
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </td>
                                                    <td>

                                                        ${c.fromDate} - ${c.toDate}
                                                    </td>
                                                    <td align="center">

                                                        <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequestAccept"
                                                                name="requestAcceptDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>

                                <div class="portlet-body"  id="accepted" style="display: none">
                                    <div class="row" >

                                        <div class="col-md-10 col-sm-10">

                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <button data-toggle="modal" data-target="#modalAddConsignment"
                                                    class="btn btn-primary btn-block">Tạo mới ký gửi</button>
                                        </div>
                                    </div>
                                    <br/>
                                    <table class="table table-striped table-bordered table-hover" id="acceptedTable">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>
                                                    STT
                                                </th>
                                                <th>
                                                    Tên Sản Phẩm
                                                </th>
                                                <th>
                                                    Mã ký gửi
                                                </th>
                                                <th>
                                                    Ngày tạo yêu cầu
                                                </th>
                                                <th>
                                                    Giá (Ngàn đồng)
                                                </th>
                                                <th>
                                                    Ngày hẹn
                                                </th>
                                                <th>
                                                    Chi Tiết
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="c" items="${ACCEPT}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td>${counter.count}</td>
                                                    <td>
                                                        ${c.product.name}
                                                    </td>
                                                    <td>
                                                        ${c.consigmentID}
                                                    </td>
                                                    <td>
                                                        ${c.createdDate}

                                                    </td>
                                                    <td>

                                                        <c:choose>
                                                            <c:when test="${c.minPrice > 0 and c.maxPrice > 0}">
                                                                <fmt:formatNumber 
                                                                    value="${c.minPrice}" 
                                                                    maxFractionDigits="1"/>
                                                                &nbsp; ~ &nbsp;
                                                                <fmt:formatNumber 
                                                                    value="${c.maxPrice}" 
                                                                    maxFractionDigits="1"/> 
                                                            </c:when>
                                                            <c:otherwise>
                                                                <b><font color="red">Không có giá</font></b>
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </td>
                                                    <td>

                                                        ${c.appointmentDate} &nbsp; ${c.hour}
                                                    </td>
                                                    <td align="center">

                                                        <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequestAccept"
                                                                name="requestAcceptDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>

                                <div class="portlet-body" id="refuse" style="display: none">
                                    <table class="table table-striped table-bordered table-hover" id="refuseTable">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>
                                                    STT
                                                </th>
                                                <th>
                                                    Tên Sản Phẩm
                                                </th>
                                                <th>
                                                    Mã ký gửi
                                                </th>
                                                <th>
                                                    Ngày tạo yêu cầu
                                                </th>
                                                <th>
                                                    Ngày từ chối
                                                </th>
                                                <th>
                                                    Chi Tiết
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="c" items="${REFUSE}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td>${counter.count}</td>
                                                    <td>
                                                        ${c.product.name}
                                                    </td>
                                                    <td>
                                                        ${c.consigmentID}
                                                    </td>
                                                    <td>
                                                        ${c.createdDate}

                                                    </td>
                                                    <td>
                                                        ${c.reviewRequestDate}

                                                    </td>

                                                    <td align="center">

                                                        <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRefuseCancel"
                                                                name="refuseCancelDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="portlet-body" id="cancel" style="display: none">
                                    <table class="table table-striped table-bordered table-hover" id="cancelTable">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>
                                                    STT
                                                </th>
                                                <th>
                                                    Tên Sản Phẩm
                                                </th>
                                                <th>
                                                    Mã ký gửi
                                                </th>
                                                <th>
                                                    Ngày tạo yêu cầu
                                                </th>

                                                <th>
                                                    Ngày hủy
                                                </th>
                                                <th>
                                                    Chi Tiết
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="c" items="${CANCEL}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td>${counter.count}</td>
                                                    <td>
                                                        ${c.product.name}
                                                    </td>
                                                    <td>
                                                        ${c.consigmentID}
                                                    </td>
                                                    <td>
                                                        ${c.createdDate}

                                                    </td>

                                                    <td>

                                                        ${c.cancelDate}
                                                    </td>
                                                    <td align="center">

                                                        <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRefuseCancel"
                                                                name="refuseCancelDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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

        <c:if test="${not empty requestScope.REQUEST or not empty requestScope.ACCEPT}">

            <div id="modalRequestAccept" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                            <h2 class="modal-title" id="r_name"></h2>
                            <div class="row">
                                <div class="col-lg-3 col-md-3"><b>Email: </b><span id="r_email"></span></div>
                                <div class="col-lg-3 col-md-3"><b>ĐT: </b><span id="r_phone"></span></div>
                                <div class="col-lg-5 col-md-5"><b>Địa chỉ: </b><span id="r_address"></span></div>

                            </div>

                        </div>
                        <div class="modal-body">
                            <!-- BEGIN PAGE CONTENT-->
                            <div class="row">
                                <!-- BEGIN CAROUSEL -->
                                <div class="col-lg-4 col-md-4 front-carousel">

                                    <div class="carousel slide" id="myCarousel">
                                        <!-- Carousel items -->
                                        <div class="carousel-inner">
                                            <div class="item active">
                                                <img id="r_image" alt="" style="max-height: 600px">
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
                                    <form id="r_form" action="ConsignmentRequestReceive" method="POST">

                                        <table style="font-size: 110%" class="table table-striped table-hover" >
                                            <tr>
                                                <th width="30%">Tên sản phẩm</th>
                                                <td><input id="r_productName" name="txtProductName" type="text" class="form-control" ></td>
                                            </tr>
                                            <tr>
                                                <th>Loại</th>
                                                <td>

                                                    <select id="r_category" name="txtCategoryID"  class="form-control" >
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

                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Hãng</th>
                                                <td><input id="r_brand" name="txtBrand" type="text" class="form-control" ></td>
                                            </tr>
                                            <tr>
                                                <th>Mô tả</th>
                                                <td>
                                                    <textarea id="r_description" name="txtDescription" class="form-control" maxlength="225" rows="3"></textarea>

                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Ngày ký gửi</th>
                                                <td id='r_createdDate'></td>
                                            </tr>
                                            <tr >
                                                <th>Giá tham khảo (Ngàn đồng) </th>
                                                <td id="r_price"></td>
                                            </tr>
                                            <tr id="ar_price" style="display: none;">
                                                <th>Giá thỏa thuận (Ngàn đồng)</th>
                                                <td>
                                                    <input type="text" id="ar_negotiatedPrice" name="txtNegotiatedPrice" class="form-control" >

                                                </td>
                                            </tr>
                                            <tr id="r_divFromDateToDate">
                                                <th>Ngày hẹn</th>
                                                <td id="r_fromDateToDate"></td>
                                            </tr>
                                            <tr>
                                                <th>Ngày lấy hàng</th>
                                                <td>
                                                    <div id="r_divReceivedDate" class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="0d" style="width: 40%">
                                                        <input  id="r_receivedDate" type="text" class="form-control" name="txtReceivedDate" value="">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>

                                                    <div id="ar_divReceivedDate"></div>

                                                </td>

                                            </tr>
                                            <tr>
                                                <th>Giờ hẹn</th>
                                                <td >
                                                    <div id="r_divHour" class="input-group" style="width: 40%">
                                                        <input id="r_hour" name="txtHour" type="text" class="form-control timepicker timepicker-no-seconds">
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button"><i class="fa fa-clock-o"></i></button>
                                                        </span>
                                                    </div>
                                                    <div id="ar_divHour"></div>
                                                </td>

                                            </tr>
                                            <tr>
                                                <th>Trạng thái</th>
                                                <td id='r_status'>
                                                </td>
                                            </tr>
                                            <tr id="r_trReason">
                                                <th>Lí do</th>
                                                <td id="r_reason">

                                                </td>
                                            </tr>

                                        </table>
                                        <input id="r_ActionValue" type="hidden" name="consignmentID"/>
                                        <input id="r_productID" type="hidden" name="productID"/>
                                        <!--                                                <input id="ar_ActionValue" type="hidden" name="ar_consignmentID"/>-->
                                        <input type="hidden" name="r_searchValue" value="${param.r_searchValue}"/>
                                        <input type="hidden" name="ar_searchValue" value="${param.ar_searchValue}"/>
                                        <input id="r_btnAction" type="hidden" name="btnAction"/>
                                    </form>
                                </div>
                                <!-- END PRODUCT DESCRIPTION -->
                            </div>

                        </div>
                        <div class="modal-footer">
                            <div id="r_footer" >

                                <button id="r_btnSubmit" class="btn btn-lg btn-primary">Chấp nhận</button>
                                <button name="btnRefuse" data-toggle="modal" data-target="#modalConfirm" value="r_refuse" class="btn btn-lg btn-warning">Từ chối</button>
                                <button class="btn btn-lg btn-default" data-dismiss="modal">Đóng</button>
                            </div>
                            <div id="ar_footer" style="display: none;">

                                <button id="ar_btnSubmit" class="btn btn-lg btn-primary">Nhận hàng</button>
                                <button name="btnRefuse" data-toggle="modal" data-target="#modalConfirm" value="ar_refuse" class="btn btn-lg btn-warning">Từ chối</button>
                                <button class="btn btn-lg btn-default" data-dismiss="modal">Đóng</button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- END MODAL -->

        <!-- BEGIN MODAL -->
        <c:if test="${not empty requestScope.REQUEST or not empty requestScope.ACCEPT}">
            <div id="modalConfirm" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Xác nhận</h4>
                        </div>
                        <div class="modal-body" align="center">
                            <!--                            <div id="r_body_confirm">
                                                            <h3>Xin nhập lí do từ chối sản phẩm</h3>
                                                        </div>-->
                            <div id="ar_body_confirm" class="form-horizontal">

                                <div class="form-group">
                                    <label class="col-md-2 col-sm-3 control-label">Lí do: </label>
                                    <div class="col-md-8 col-sm-7">
                                        <textarea id="ar_txtReason" type="text" class="form-control" rows="3"></textarea>
                                        <span id="ar_erReason" class="help-block">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div id="r_footer_confirm">
                                <form action="ConsignmentRequestReceive" method="POST" onsubmit="return r_confirm_validation();">
                                    <button type="submit" name="btnAction" value="r_refuse" class="btn btn-default">Xác nhận</button>
                                    <input type="hidden" id="r_inputReason" name="r_reason"/>
                                    <input id="r_ActionValue_confirm" type="hidden" name="r_consignmentID"/>
                                </form>
                            </div>
                            <div id="ar_footer_confirm">
                                <form  action="ConsignmentRequestReceive" method="POST" onsubmit="return ar_confirm_validation();">
                                    <button type="submit" name="btnAction" value="ar_refuse" class="btn btn-default">Xác nhận</button>
                                    <input type="hidden" id="ar_inputReason" name="ar_reason"/>
                                    <input id="ar_ActionValue_confirm" type="hidden" name="ar_consignmentID"/>
                                </form>
                            </div>

                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </c:if>

        <!--BEGIN MODAL -->
        <!-- Large modal -->
        <c:if test="${not empty requestScope.REFUSE or not empty requestScope.CANCEL}">
            <div id="modalRefuseCancel" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                            <h2 class="modal-title" id="rc_name"></h2>
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
                                                <img id="rc_image" alt="" style="max-height: 600px">
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


                                    <table style="font-size: 110%" class="table table-striped table-hover" >
                                        <tr>
                                            <th width="30%">Tên sản phẩm</th>
                                            <td id="rc_productName"></td>
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
                                            <th>Giá (VND)</th>
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
                            <button  data-dismiss="modal" class="btn btn-lg btn-default">Đóng</button>

                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- END MODAL -->


        <!--BEGIN MODAL -->
        <!-- Large modal -->
        <c:if test="${currentTab == 'accepted'}">
            <div id="modalAddConsignment" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h2 class="modal-title">Tạo sản phẩm</h2>
                        </div>
                        <div class="modal-body">

                            <form id="addConsignment_form" action="AddConsignment" method="POST" enctype="multipart/form-data">
                                <div class="row">    

                                    <div class="col-md-6 col-sm-6">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="txtProductName" class="col-md-4 col-sm-4 control-label">Tên sản phẩm <font color="red">*</font></label> <!--<span class="required">*</span> -->
                                                <div class="col-md-8 col-sm-8">
                                                    <input id="addConsignment_txtProductName"  name="txtProductName" type="text" class="form-control" maxlength="100" />
                                                    <p class="help-block" id="erProductName">  </p>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="txtSerial" class="col-md-4 col-sm-4 control-label"> Mã số </label>
                                                <div class="col-md-5 col-sm-6">
                                                    <input id="addConsignment_txtSerialNumber" type="text" class="form-control" name="txtSerialNumber" />
                                                    <p class="help-block" id="erSerialNumber"> </p>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Loại <font color="red">*</font></label>
                                                <div class="col-md-5 col-sm-6">
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
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Hãng</label>
                                                <div class="col-md-5 col-sm-6">
                                                    <input id="addConsignment_txtBrand" name="txtBrand" type="text" class="form-control" maxlength="50" value="${product.brand}"/>

                                                    <span class="help-block" id="erBrand">
                                                    </span>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label  class="col-md-4 col-sm-4 control-label"> Mô tả </label>
                                                <div class="col-md-8 col-sm-8">
                                                    <textarea id="addConsignment_txtDescription" name="txtDescription" class="form-control" maxlength="225" rows="6" placeholder="" value="${product.description}"/>${product.description}</textarea>
                                                    <span class="help-block" id="erDescription">
                                                    </span>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Hình ảnh <font color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8" align="center">

                                                    <div id="addConsignment_divImage" class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="fileinput-new thumbnail" style="width: 250px; height: 200px;">
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
                                                                <input  type="file" name="txtImage" />
                                                            </span>
                                                            <a href="#" class="btn btn-lg btn-warning fileinput-exists" data-dismiss="fileinput">
                                                                XÓA </a>
                                                        </div>
                                                    </div>


                                                    <span class="help-block" id="erImage">

                                                    </span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Ngày mua</label>
                                                <div class="col-md-4 col-sm-5">
                                                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                        <input  id="txtDate" type="text" class="form-control" name="txtDate" readonly value="${product.purchasedDate}">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
                                                    <!--                                                            <input id="addConsignment_txtDate" type="text" class="form-control" name="txtDate"> -->
                                                    <span class="help-block" id="erDate"> </span>
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
                                                <label for="addConsignment_txtFullName" class="col-md-4 col-sm-4 control-label">Họ tên <font color="red">*</font></label>
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
                                                <label for="addConsignment_txtPhone" class="col-md-4 col-sm-4 control-label"> Điện thoại <font color="red">*</font> </label>
                                                <div class="col-md-5 col-sm-7">
                                                    <input type="text" id="addConsignment_txtPhone" name="txtPhone" class="form-control"/>
                                                    <p class="help-block" id="erPhone"></p>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="addConsignment_txtEmail" class="col-md-4 col-sm-4 control-label">Email </label>
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
                                                <label for="" class="col-md-4 col-sm-4 control-label"> Cách thanh toán </label>

                                                <div class="radio-list col-md-8 col-sm-8">

                                                    <label class="radio-list">
                                                        <input type="radio" name="rdPayment" id="optionsRadios7" value="direct" checked> Tiền mặt </label>
                                                    <label class="radio-list">
                                                        <input type="radio" name="rdPayment" id="optionsRadios8" value="cc"> Tài khoản paypal </label>



                                                </div>
                                            </div>
                                            <div id="addConsignment_divCCNumber" class="form-group" style="display: none" >
                                                <label class="col-md-4 col-sm-4 control-label">Mã tài khoản <font color="red">*</font></label>
                                                <div class="col-md-8 col-sm-8">
                                                    <input type="text" id="addConsignment_txtPaypalAccount" name="txtPaypalAccount" class="form-control"   placeholder=""/>

                                                    <p class="help-block" id="erPaypalAccount"></p>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Giá thỏa thuận</label>
                                                <div class="col-md-5 col-sm-6">
                                                    <input id="addConsignment_txtNegotiatedPrice" name="txtNegotiatedPrice" type="text" class="form-control" maxlength="50"/>

                                                    <span class="help-block" id="erNegotiatedPrice">
                                                    </span>
                                                </div>
                                            </div>
                                        </div></div>            
                                </div>
                                <input type="hidden" name="ar_searchValue" value="${param.ar_searchValue}"/>
                            </form> 

                        </div>
                        <div class="modal-footer">

                            <button id="btnAddConsignment" class="btn btn-lg btn-primary">Thêm</button>
                            <button  data-dismiss="modal" class="btn btn-lg btn-default">Đóng</button>


                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- END MODAL -->


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
        <style>
            .ui-autocomplete-loading {
                background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
            }
        </style>
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

                var currentTab = window.location.hash.substring(1);
                if (currentTab == "") {
                    currentTab = $('#currentTab').val();
                }
                $('div#' + currentTab).fadeIn(400).siblings().hide();
                $('div.portlet-title').show();
                $('li#' + currentTab).addClass('open').siblings().removeClass('open');
                $('html,body').scrollTop(0);
            });


            $(function () {
                $("#r_brand").autocomplete({
                    source: "BrandAutocomplete",
                    minLength: 1,
                    select: function (event, ui) {
                    }
                });
            });


            $(function () {
                $("#addConsignment_txtBrand").autocomplete({
                    source: "BrandAutocomplete",
                    minLength: 1,
                    select: function (event, ui) {
                    }
                });

            });

            function loadRefuseCancelDetails(id) {
                $.get('ConsignmentRequestReceive', {btnAction: 'consignmentdetails', id: id}, function (data) {

                    $("#rc_name").html("<small>Từ khách hàng</small> " + data.name);
                    $("#rc_productName").html(data.product.name);
                    $("#rc_image").attr("src", data.product.image);
                    $("#rc_description").html(data.product.description);
                    $("#rc_createdDate").html(data.createdDate);
                    $("#rc_email").html(data.email);
                    $("#rc_phone").html("0" + data.phone.substring(3));
                    $("#rc_address").html(data.address);
                    //$("#rc_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);
                    if (data.minPrice > 0 && data.maxPrice > 0) {
                        $("#rc_price").html(formatDollar(data.minPrice) + "  ~  " + formatDollar(data.maxPrice));
                    } else {
                        $("#rc_price").html("<font color='red'>Không có giá </font>");
                    }


                    $("#rc_trReason").hide();
                    $("#rc_reason").html("");
                    if (data.product.productStatusID == 6) {
                        $("#rc_status").html("<b><font color='red'>ĐÃ HỦY</font></b>");
                    }
                    else {
                        if (data.consignmentStatusID == 1) {
                            $("#rc_status").html("<b><font color='blue'>CHỜ XỬ LÝ</font></b>");

                        } else if (data.consignmentStatusID == 3) {
                            $("#rc_status").html("<b><font color='green'>ĐÃ CHẤP NHẬN</font></b>");

                        } else if (data.consignmentStatusID == 2) {
                            $("#rc_status").html("<b><font color='red'>ĐÃ TỪ CHỐI</font></b>");
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
                            $("#rc_status").html("<b><font color='red'>ĐÃ TRẢ HÀNG</font></b>");
                        }
                    }
                });
            }

            function loadRequestAcceptDetails(id) {
                $.get('ConsignmentRequestReceive', {btnAction: 'consignmentdetails', id: id}, function (data) {

                    $("#r_name").html("<small>Từ khách hàng</small> " + data.name);
                    $("#r_productName").val(data.product.name);

                    $('#r_category').val(data.product.categoryID).change();
                    $("#r_brand").val(data.product.brand);
                    $("#r_image").attr("src", data.product.image);
                    $("#r_description").val(data.product.description);
                    $("#r_createdDate").html(data.createdDate);
                    $("#r_email").html(data.email);
                    $("#r_phone").html("0" + data.phone.substring(3));
                    $("#r_address").html(data.address);
                    $("#r_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);

                    //$("#r_hour").val(data.hour);

                    if (data.minPrice > 0 && data.maxPrice > 0) {
                        $("#r_price").html(formatDollar(data.minPrice) + "  ~  " + formatDollar(data.maxPrice));
                    } else {
                        $("#r_price").html("<font color='red'>Không có giá </font>");
                    }

                    $("#r_productID").val(data.product.productID);
                    $("#r_ActionValue").val(data.consigmentID);

                    $("#r_trReason").hide();
                    $("#r_reason").html("");
                    $("#r_divFromDateToDate").hide();
                    if (data.product.productStatusID == 6) {
                        $("#r_status").html("<b><font color='red'>ĐÃ HỦY</font></b>");
                        $("#r_footer").hide();
                        $("#ar_footer").hide();
                    }
                    else {
                        if (data.consignmentStatusID == 1) {
                            $("#r_status").html("<b><font color='blue'>CHỜ XỬ LÝ</font></b>");
                            $("#r_ActionValue_confirm").val(data.consigmentID);
                            $("#ar_ActionValue_confirm").val("");
                            $("#r_footer").show();
                            $("#ar_footer").hide();

                            $("#ar_price").hide();
                            $("#r_btnAction").val("r_accept");

                            $("#r_receivedDate").val(data.fromDate);
                            $("#r_hour").val("12:00 PM");
                            $("#ar_divReceivedDate").html("");
                            $("#ar_divHour").html("");

                            $("#r_divReceivedDate").show();
                            $("#r_divHour").show();
                            $("#ar_divReceivedDate").hide();
                            $("#ar_divHour").hide();

                            $("#r_divFromDateToDate").show();

                        } else if (data.consignmentStatusID == 3) {
                            $("#r_status").html("<b><font color='green'>ĐÃ CHẤP NHẬN</font></b>");
                            $("#ar_ActionValue_confirm").val(data.consigmentID);
                            $("#r_ActionValue_confirm").val("");
                            $("#ar_footer").show();
                            $("#r_footer").hide();
                            $("#ar_price").show();

                            $("#r_btnAction").val("ar_accept");
                            $("#r_receivedDate").val("");
                            $("#r_hour").val("");

                            $("#ar_divReceivedDate").html(data.appointmentDate);
                            $("#ar_divHour").html(data.hour);


                            $("#r_divReceivedDate").hide();
                            $("#r_divHour").hide();
                            $("#ar_divReceivedDate").show();
                            $("#ar_divHour").show();

                        } else if (data.consignmentStatusID == 2) {
                            $("#r_status").html("<b><font color='red'>ĐÃ TỪ CHỐI</font></b>");
                            $("#r_footer").hide();
                            $("#ar_footer").hide();
                            $("#r_trReason").show();
                            $("#r_reason").html(data.reason);
                        } else if (data.consignmentStatusID == 4) {
                            $("#r_status").html("<b><font color='blue'>HOÀN THÀNH</font></b>");
                            $("#r_footer").hide();
                            $("#ar_footer").hide();
                        } else if (data.consignmentStatusID == 6) {
                            $("#r_status").html("<b><font color='red'>ĐÃ HẾT HẠN</font></b>");
                            $("#r_footer").hide();
                            $("#ar_footer").hide();
                        }
                        else if (data.consignmentStatusID == 5) {
                            if (data.product.productStatusID == 2) {
                                $("#r_status").html("<b><font color='blue'>ĐÃ NHẬN HÀNG</font></b>");
                                $("#r_footer").hide();
                                $("#ar_footer").hide();
                            }
                            else if (data.product.productStatusID == 3) {
                                $("#r_status").html("<b><font color='blue'>ĐAND TRÊN WEB</font></b>");
                                $("#r_footer").hide();
                                $("#ar_footer").hide();
                            }
                            else if (data.product.productStatusID == 4) {
                                $("#r_status").html("<b><font color='blue'>ĐÃ ĐƯỢC ĐẶT</font></b>");
                                $("#r_footer").hide();
                                $("#ar_footer").hide();
                            }
                            else if (data.product.productStatusID == 5) {
                                $("#r_status").html("<b><font color='blue'>ĐÃ BÁN</font></b>");
                                $("#r_footer").hide();
                                $("#ar_footer").hide();
                            }
                        } else if (data.consignmentStatusID == 7) {
                            $("#r_status").html("<b><font color='red'>ĐÃ TRẢ HÀNG</font></b>");
                            $("#r_footer").hide();
                            $("#ar_footer").hide();
                        }

                    }
                });
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
                var action = $(this).val();
                if (action == "ar_refuse") {
                    //$('#ar_body_confirm').show();
                    //$('#r_body_confirm').hide();
                    $('#ar_footer_confirm').show();
                    $('#r_footer_confirm').hide();
                } else if (action == "r_refuse") {
                    //$('#ar_body_confirm').hide();
                    //$('#r_body_confirm').show();
                    $('#ar_footer_confirm').hide();
                    $('#r_footer_confirm').show();
                }
            });

            $('#r_btnSubmit').click(function () {
                $('form#r_form').submit();
            });
            $('#ar_btnSubmit').click(function () {
                if ($('#ar_negotiatedPrice').val() == "") {
                    alert("Xin nhập giá thỏa thuận!");
                } else {
                    $('form#r_form').submit();
                }
            });

            function ar_validation() {

                var minPrice = $("#ar_minPrice").val();
                var maxPrice = $("#ar_maxPrice").val();
                if (minPrice == "" || maxPrice == "") {
                    alert("Xin nhập giá.");
                    return false;
                }
                $("#ar_inputMinPrice").val(minPrice);
                $("#ar_inputMaxPrice").val(maxPrice);
                return true;
            }

            function ar_confirm_validation() {
                var reason = $("#ar_txtReason").val();
                if (reason.trim() == "") {
                    alert("Xin nhập lí do");
                    return false;
                }
                $("#ar_inputReason").val(reason);
                return true;
            }

            function r_confirm_validation() {
                var reason = $("#ar_txtReason").val();
                if (reason.trim() == "") {
                    alert("Xin nhập lí do");
                    return false;
                }
                $("#r_inputReason").val(reason);
                return true;
            }

            $('input:radio[name="rdPayment"]').change(function () {
                if ($(this).val() == "cc") {
                    $("#addConsignment_divCCNumber").show();
                }
                else {
                    $("#addConsignment_divCCNumber").hide();

                }
            });

            function formatDollar(num) {
                var p = num.toFixed(0);
                return  p.split("").reverse().reduce(function (acc, num, i, orig) {
                    return  num + (i && !(i % 3) ? "," : "") + acc;
                }, "");
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

                if ($('#addConsignment_txtNegotiatedPrice').val().trim().length <= 0) {
                    $('#erNegotiatedPrice').html("<font color='red'>Xin nhập giá</font>");
                    check = false;
                }
                else {
                    $('#erNegotiatedPrice').html("");
                }

                if (check) {
                    $('form#addConsignment_form').submit();
                }

            });

        </script> 


    </body>
    <!-- END BODY -->
</html>
