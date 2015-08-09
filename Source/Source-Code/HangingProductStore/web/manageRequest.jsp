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
        <title>HPS :: Quản lí yêu cầu ký gửi</title>
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
                    <input type="hidden" id="fromDate" value="${requestScope.fromDate}">
                    <input type="hidden" id="toDate" value="${requestScope.toDate}">
                    <!-- BEGIN PAGE CONTENT-->

                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <div class="portlet box blue">

                                <div class="portlet-title">
                                    <div class="caption col-lg-6 col-md-6" style="font-weight: bold">
                                        <i class="fa fa-globe" ></i>Yêu cầu
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
                                    <c:if test="${requestScope.currentTab == 'accepted'}">
                                        <div align="right">
                                            <button data-toggle="modal" data-target="#modalAddConsignment"
                                                    class="btn green" style="margin-top: 3px"><i class="fa fa-plus"></i> Tạo mới ký gửi</button>
                                        </div>
                                    </c:if>

                                </div>



                                <div id="request" class="portlet-body" style="display: none">
                                    <div class="row" >
                                        <div class="col-md-9 col-sm-9">
                                        </div>
                                        <div class="col-md-3 col-sm-3" align="right">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=accepted" class="btn  btn-primary">Yêu cầu đã duyệt <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>

                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                            <div class="form-horizontal">
                                                <div class="form-group">

                                                    <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Lọc ngày:</label>
                                                    <div class="col-md-5 col-sm-5 input-daterange">

                                                        <input type="text" class="form-control" id="daterangeRequest">
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
                                                    <td style="font-weight: bold">${counter.count}</td>
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
                                                                    maxFractionDigits="1"/>&nbsp; ~ &nbsp;<fmt:formatNumber 
                                                                    value="${c.maxPrice}" 
                                                                    maxFractionDigits="1"/> 
                                                            </c:when>
                                                            <c:otherwise>
                                                                <font color="red">Không có giá</font>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>

                                                        ${c.fromDate}&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;${c.toDate}
                                                    </td>
                                                    <td align="center">

                                                        <button type="button" class="btn blue" style="width: 70px; height: 30px" 
                                                                name="requestAcceptDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>

                                <div id="accepted" class="portlet-body" style="display: none">
                                    <div class="row">

                                        <div class="col-md-4 col-sm-4" align="left">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=request" class="btn  btn-primary"><i class="m-icon-swapleft m-icon-white"></i> Yêu cầu chưa duyệt</a>
                                        </div>
                                        <div class="col-md-4 col-sm-4" align="center">
                                            <!--                                            <button data-toggle="modal" data-target="#modalAddConsignment"
                                                                                                class="btn green "><i class="fa fa-plus"></i> Tạo mới ký gửi</button>-->
                                        </div>
                                        <div class="col-md-4 col-sm-4" align="right">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=refuse" class="btn  btn-primary">Yêu cầu đã từ chối <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                            <div class="form-horizontal">
                                                <div class="form-group">

                                                    <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Lọc ngày:</label>
                                                    <div class="col-md-5 col-sm-5 input-daterange">

                                                        <input type="text" class="form-control" id="daterangeAccepted">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <table id="acceptedTable" class="table table-bordered table-hover">
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
                                                    Ngày duyệt yêu cầu
                                                </th>
                                                <th>
                                                    Giá (Ngàn đồng)
                                                </th>
                                                <th>
                                                    Ngày đến nhận
                                                </th>
                                                <th>
                                                    Cách giao hàng
                                                </th>
                                                <th>
                                                    Chi Tiết
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="c" items="${ACCEPT}" varStatus="counter">
                                                <tr class="odd gradeX">
                                                    <td style="font-weight: bold">${counter.count}</td>
                                                    <td>
                                                        ${c.product.name}
                                                    </td>
                                                    <td>
                                                        ${c.consigmentID}
                                                    </td>
                                                    <td>
                                                        ${c.reviewRequestDate}
                                                    </td>
                                                    <td>

                                                        <c:choose>
                                                            <c:when test="${c.minPrice > 0 and c.maxPrice > 0}">
                                                                <fmt:formatNumber 
                                                                    value="${c.minPrice}" 
                                                                    maxFractionDigits="1"/>&nbsp; ~ &nbsp;<fmt:formatNumber 
                                                                    value="${c.maxPrice}" 
                                                                    maxFractionDigits="1"/> 
                                                            </c:when>
                                                            <c:otherwise>
                                                                <font color="red">Không có giá</font>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td align="center">
                                                        <c:choose>
                                                            <c:when test="${not empty c.appointmentDate}">
                                                                ${c.hour}|${c.appointmentDate}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ---
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${c.deliveryMethod == 0}">
                                                                <font color="blue">Cửa hàng đến nhận</font>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <font color="green">Tự mang đến</font>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td align="center">

                                                        <button type="button" class="btn blue" style="width: 70px; height: 30px" 
                                                                name="requestAcceptDetails" value="${c.consigmentID}">Xem</button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>

                                <div id="refuse" class="portlet-body" style="display: none">
                                    <div class="row" >

                                        <div class="col-md-4 col-sm-4" align="left">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=accepted" class="btn  btn-primary"><i class="m-icon-swapleft m-icon-white"></i> Yêu cầu đã duyệt</a>
                                        </div>
                                        <div class="col-md-4 col-sm-4" align="center">
                                        </div>
                                        <div class="col-md-4 col-sm-4" align="right">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=cancel" class="btn  btn-primary">Yêu cầu đã hủy <i class="m-icon-swapright m-icon-white"></i></a>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                            <div class="form-horizontal">
                                                <div class="form-group">

                                                    <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Lọc ngày:</label>
                                                    <div class="col-md-5 col-sm-5 input-daterange">

                                                        <input type="text" class="form-control" id="daterangeRefuse">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <table id="refuseTable" class="table table-bordered table-hover">
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
                                                    <td style="font-weight: bold">${counter.count}</td>
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
                                                            <c:when test="${not empty c.reviewProductDate}">
                                                                ${c.reviewProductDate}        
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${c.reviewRequestDate}
                                                            </c:otherwise>
                                                        </c:choose>


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

                                <div id="cancel" class="portlet-body" style="display: none">
                                    <div class="row" >

                                        <div class="col-md-4 col-sm-4" align="left">
                                            <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=refuse" class="btn  btn-primary"><i class="m-icon-swapleft m-icon-white"></i> Yêu cầu đã từ chối</a>
                                        </div>

                                    </div>
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-md-offset-6 col-sm-offset-6">
                                            <div class="form-horizontal">
                                                <div class="form-group">

                                                    <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4 control-label">Lọc ngày:</label>
                                                    <div class="col-md-5 col-sm-5 input-daterange">

                                                        <input type="text" class="form-control" id="daterangeCancel">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
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
                                                    <td style="font-weight: bold">${counter.count}</td>
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
                        <div class="modal-header" style="background-color: snow ">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                            <h3 class="modal-title" id="r_name" style="font-weight: bold">THÔNG TIN CHI TIẾT</h3>

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
                                                <label for="txtFullName" class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-9 col-sm-9">
                                                    <input id="r_productName" name="txtProductName" maxlength="100" required="true" type="text" class="form-control" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Loại</label>
                                                <div class="col-md-3 col-sm-3">

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
                                                <label class="col-md-2 col-sm-2 control-label" style="font-weight: bold">Hãng</label>
                                                <div class="col-md-4 col-sm-4"><input id="r_brand" name="txtBrand" type="text" class="form-control" ></div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Mô tả</label>
                                                <div class="col-md-9 col-sm-9">
                                                    <textarea id="r_description" name="txtDescription" class="form-control" maxlength="225" rows="3"></textarea>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-sm-3 control-label" style="font-weight: bold">Độ mới</label>
                                                <div class="col-md-3 col-sm-3">
                                                    <div class="input-group">
                                                        <input id="r_newStatus" name="txtNewStatus" maxlength="100" type="text" class="form-control"/> <span class="input-group-addon"><i class="fa fa-pencil"></i>
                                                    </div>
                                                    </span>
                                                </div>
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
                                            <!--                                             Carousel nav 
                                                                                        <a data-slide="prev" href="#myCarousel" class="carousel-control left">
                                                                                            <i class="fa fa-angle-left"></i>
                                                                                        </a>
                                                                                        <a data-slide="next" href="#myCarousel" class="carousel-control right">
                                                                                            <i class="fa fa-angle-right"></i>
                                                                                        </a>-->
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
                                                <div class="col-md-8 col-sm-8 radio-list">
                                                    <label class="radio-list" >
                                                        <input type="radio" name="r_rdDeliveryMethod" value="store"  checked> Cửa hàng đến nhận</label>
                                                    <label class="radio-list">
                                                        <input type="radio" name="r_rdDeliveryMethod" value="customer"> Tự mang đến</label>

                                                </div>
                                            </div>
                                            <div class="form-group" id="div_r_receivedDate">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày giao hàng</label>
                                                <div class="col-md-8 col-sm-8" id="ar_divReceivedDateInput">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <!--                                                            <div id="r_divReceivedDate" class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="0d">-->
                                                            <input  id="r_receivedDate" type="text" class="form-control form-control-inline input-medium date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="0d" name="txtReceivedDate" value="">
                                                            <!--                                                                <span class="input-group-btn">
                                                                                                                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                                                                            </span>
                                                                                                                        </div>-->
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
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-6 col-sm-6">
                                                    <input type="text" id="ar_negotiatedPrice" name="txtNegotiatedPrice" class="form-control" > (Ngàn đồng)

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal" id="r_divPersonalInfo" >
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Họ tên</label>
                                                <div class="col-md-8 col-sm-8">
                                                    <input type="text" id="r_txtFullName" name="txtFullName"  class="form-control" maxlength="50"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-8 col-sm-8">
                                                    <input type="text" id="r_txtPhone" name="txtPhone" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email</label>
                                                <div class="col-md-8 col-sm-8">
                                                    <input type="text" id="r_txtEmail" name="txtEmail" class="form-control"  placeholder="example@abc.com" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Địa chỉ</label>
                                                <div class="col-md-8 col-sm-8">
                                                    <textarea id="r_txtAddress" name="txtAddress" class="form-control" maxlength="225" rows="2"></textarea>
                                                </div>
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
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Mã tài khoản</label>
                                                <div class="col-md-8 col-sm-8">
                                                    <input type="text" id="r_txtPaypalAccount" name="txtPaypalAccount" class="form-control" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </form>
                        </div>
                        <div class="modal-footer" style="background-color: snow ">
                            <div id="r_footer" >

                                <button id="r_btnSubmit" class="btn btn-primary">Chấp nhận</button>
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
        <c:if test="${not empty requestScope.REQUEST or not empty requestScope.ACCEPT}">
            <div id="modalConfirm" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="modal-title" style="font-weight: bold">XÁC NHẬN TỪ CHỐI</h3>
                        </div>
                        <div class="modal-body">
                            <!--                            <div id="r_body_confirm">
                                                            <h3>Xin nhập lí do từ chối sản phẩm</h3>
                                                        </div>-->
                            <div id="ar_body_confirm" class="form-horizontal">

                                <div class="form-group">
                                    <label class="col-md-2 col-sm-3  control-label" style="font-weight: bold">Lí do: </label>
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
                                <!--                                <form action="ConsignmentRequestReceive" method="POST" onsubmit="return r_confirm_validation();">-->
                                <button id="r_btnRefuse" value="r_refuse" class="btn btn-warning">Xác nhận</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button> 
                                <!--                                    <input type="hidden" id="r_inputReason" name="r_reason"/>
                                                                    <input id="r_ActionValue_confirm" type="hidden" name="r_consignmentID"/>-->
                                <!--                                </form>-->
                            </div>
                            <div id="ar_footer_confirm">
                                <!--                                <form  action="ConsignmentRequestReceive" method="POST" onsubmit="return ar_confirm_validation();">-->
                                <button id="ar_btnRefuse" value="ar_refuse" class="btn btn-warning">Xác nhận</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button>
                                <!--                                    <input type="hidden" id="ar_inputReason" name="ar_reason"/>
                                                                    <input id="ar_ActionValue_confirm" type="hidden" name="ar_consignmentID"/>-->
                                <!--                                </form>-->
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
                    <div class="modal-header">
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
        <c:if test="${not empty requestScope.REFUSE or not empty requestScope.CANCEL}">
            <div id="modalRefuseCancel" class="modal fade bs-example-modal-lg" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
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
                                                    <img id="rc_image" alt="" style="max-height: 400px">
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
                            <button  data-dismiss="modal" class="btn btn-default">Đóng</button>

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
                            <h3 class="modal-title" style="font-weight: bold">Tạo sản phẩm</h3>
                        </div>
                        <div class="modal-body">

                            <form id="addConsignment_form" action="AddConsignment" method="POST" enctype="multipart/form-data">
                                <div class="row">    

                                    <div class="col-md-8 col-sm-8">
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
                                    <div class="col-md-4 col-sm-4">
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
                                                <div class="col-md-7 col-sm-7">
                                                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                        <input  id="txtDate" type="text" class="form-control" name="txtDate" readonly value="${product.purchasedDate}">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
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
                                                <label class="col-md-4 col-sm-4 control-label">Mã tài khoản<font color="red">*</font></label>
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

                            <button id="btnAddConsignment" class="btn btn-primary">Thêm</button>
                            <button  data-dismiss="modal" class="btn btn-default">Đóng</button>


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
                //                if (currentTab == "accepted") {
                //                    var table = $('#acceptedTable').DataTable();
                //                    table.draw();
                //
                //                } else if (currentTab == "request") {
                //                    var table = $('#requestTable').DataTable();
                //                    table.draw();
                //                }else if (currentTab == "cancel") {
                //                    var table = $('#cancelTable').DataTable();
                //                    table.draw();
                //                }else if (currentTab == "refuse") {
                //                    var table = $('#refuseTable').DataTable();
                //                    table.draw();
                //                }


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
                    $("#rc_description").html(data.product.description);
                    $("#rc_createdDate").html(data.createdDate);
                    $("#rc_email").html(data.email);
                    $("#rc_phone").html(data.phone);
                    $("#rc_address").html(data.address);                     //$("#rc_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);

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

            function setEnableFieldWhenLoadRequestAcceptDetails() {
                var currentTab = $("#currentTab").val();
                if (currentTab == "request") {

                    $("#r_labelProductName").attr("disabled", true);
                    $('#r_labelCategory').attr("disabled", true);
                    $("#r_labelBrand").attr("disabled", true);
                    $("#r_labelDescription").attr("disabled", true);
                    $("#r_newStatus").attr("disabled", true);

                    $("#r_productName").attr("disabled", true);
                    $('#r_category').attr("disabled", true);
                    $("#r_brand").attr("disabled", true);
                    $("#r_description").attr("disabled", true);
                    $("#r_newStatus").attr("disabled", true);
                    $("input[name='r_rdDeliveryMethod']").attr("disabled", true);

                    $("#r_txtFullName").attr("disabled", true);
                    $("#r_txtAddress").attr("disabled", true);
                    $("#r_txtPhone").attr("disabled", true);
                    $("#r_txtEmail").attr("disabled", true);
                    $("#r_txtPaypalAccount").attr("disabled", true);
                    $("input[name='r_rdPayment']").attr("disabled", true);
                    $("#div_r_rdPayment").hide();


                    $("#div_r_isSpecial").hide();
                    $("#label_r_isSpecial").hide();
                } else {
                    $("#r_productName").attr("disabled", false);
                    $('#r_category').attr("disabled", false);
                    $("#r_brand").attr("disabled", false);
                    $("#r_description").attr("disabled", false);
                    $("#r_newStatus").attr("disabled", false);
                    $("input[name='r_rdDeliveryMethod']").attr("disabled", false);

                    $("#r_txtFullName").attr("disabled", false);
                    $("#r_txtAddress").attr("disabled", false);
                    $("#r_txtPhone").attr("disabled", false);
                    $("#r_txtEmail").attr("disabled", false);

                    $("#r_txtPaypalAccount").attr("disabled", false);
                    $("input[name='r_rdPayment']").attr("disabled", false);
                    $("#div_r_rdPayment").show();

                    $("#div_r_isSpecial").show();
                    $("#label_r_isSpecial").show();
                }
            }

            function loadRequestAcceptDetails(id) {
                $.get('ConsignmentRequestReceive', {btnAction: 'consignmentdetails', id: id}, function (data) {
                    if (data.product.productStatusID == 6) {
                        $("#modalError").modal("show");
                    }
                    else {
                        if (data.consignmentStatusID == 1 || data.consignmentStatusID == 3) {
                            //$("#r_name").html("<small>Khách hàng: </small> " + data.name);
                            $("#r_productName").val(data.product.name);
                            $('#r_category').val(data.product.categoryID).change();
                            $("#r_brand").val(data.product.brand);
                            $("#r_image").attr("src", data.product.image.replace(/\\/g, '/'));
                            $("#r_description").val(data.product.description);
                            $("#r_createdDate").html(data.createdDate);
                            $("#r_fromDateToDate").html(data.fromDate + "&nbsp;<i class='fa fa-long-arrow-right'></i>&nbsp;" + data.toDate);
                            $("#r_newStatus").val(data.product.newStatus);

                            if (data.deliveryMethod == 0) {
                                $("input[name='r_rdDeliveryMethod'][value='store']").attr("checked", true).parent().addClass("checked");
                                $("input[name='r_rdDeliveryMethod'][value='customer']").attr("checked", false).parent().removeClass("checked");
                            } else {
                                $("input[name='r_rdDeliveryMethod'][value='customer']").attr("checked", true).parent().addClass("checked");
                                $("input[name='r_rdDeliveryMethod'][value='store']").attr("checked", false).parent().removeClass("checked");
                            }


                            if (data.minPrice > 0 && data.maxPrice > 0) {
                                $("#r_price").html(formatDollar(data.minPrice) + "  ~  " + formatDollar(data.maxPrice) + " (Ngàn đồng)");
                            } else {
                                $("#r_price").html("<font color='red'>Không có giá </font>");
                            }
                            $("#r_desirePrice").html(formatDollar(data.desirePrice) + " (Ngàn đồng)");


                            $("#r_productID").val(data.product.productID);
                            $("#r_ActionValue").val(data.consigmentID);
                            if (data.product.isSpecial > 0) {
                                $("input#r_isSpecial").attr("checked", true).parent().addClass("checked");
                            } else {
                                $("input#r_isSpecial").attr("checked", false).parent().removeClass("checked");
                            }
                            //$("#r_divPersonalInfo").hide();
                            $("#refuse_consignmentID").val(data.consigmentID);

                            if (data.consignmentStatusID == 1 && $("#currentTab").val() == "request") {
                                setEnableFieldWhenLoadRequestAcceptDetails();
                                $("#r_footer").show();
                                $("#ar_footer").hide();
                                $("#ar_price").hide();
                                $("#r_btnAction").val("r_accept");

                                $("#r_receivedDate").val(getCurrentDate());
                                $("#div_r_receivedDate").show();

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

                                $("#modalRequestAccept").modal("show");

                                //$("#r_divPersonalInfo").show();
                            } else if (data.consignmentStatusID == 3 && $("#currentTab").val() == "accepted") {
                                setEnableFieldWhenLoadRequestAcceptDetails();
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
                                    $("input[name='r_rdDeliveryMethod']").attr("disabled", true);

                                } else {
                                    //$("#ar_btnUpdateRequest").show();
                                    $("#ar_divReceivedDateInput").show();
                                    $("#ar_divReceivedDate").hide();
                                    $("ar_divReceivedDate").html(data.hour + "|" + data.appointmentDate);
                                    $("input[name='r_rdDeliveryMethod']").attr("disabled", false);
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
                    //alert("Xin nhập lí do");
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
                    alert("Xin nhập đúng thông tin");
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
                    if (!isNaN($('#ar_negotiatedPrice').val()) && $('#ar_negotiatedPrice').val().length > 0) {
                        //$('form#r_form').submit();
                        if ($('#ar_negotiatedPrice').val() > 0) {
                            acceptProduct();
                        } else {
                            alert("Giá thỏa thuận phải lớn hơn 0!");
                        }


                    } else {
                        alert("Xin nhập đúng giá thỏa thuận!");
                    }
                } else {
                    alert("Xin nhập đầy đủ thông tin");
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
                if (isNaN(newStatus)) {
                    check = false;
                } else {
                    if (newStatus > 100 || newStatus < 0) {
                        check = false;
                    }
                }

                if (check) {
                    updateRequest();
                    //alert("Cập nhật thành công");
                } else {
                    alert("Xin nhập đầy đủ thông tin");
                }
            });

            function updateRequest() {
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
                        consignmentTD.next().next().next().html(hour + "|" + appointmentDate);
                        if (deliveryMethod == "customer") {
                            consignmentTD.next().next().next().next().html("<font color='green'>Tự mang đến</font>");
                        } else {
                            consignmentTD.next().next().next().next().html("<font color='blue'>Cửa hàng đến nhận</font>");
                        }
                        consignmentTD.next().next().next().html(hour + "|" + appointmentDate);
                        alert("Cập nhật thành công");
                        //$("#r_name").html("<small>Khách hàng: </small> " + fullName);                         alert("Cập nhật thành công");
                    } else if (data == "fail") {
                        alert("Cập nhật thất bại");
                    }
                    else if (data == "error") {
                        alert("Yêu cầu đã được xử lý");
                    }
                });
            }

            function acceptProduct() {
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
                    if (data == "success") {
                        alert("Đã nhận sản phẩm");
                        location.reload();
                    } else if (data == "fail") {
                        alert("Không thể nhận sản phẩm");
                    }
                    else if (data == "error") {
                        alert("Yêu cầu đã được xử lý");
                    }
                });
            }

            function refuseProduct() {
                var consignmentID = $("#refuse_consignmentID").val();
                var reason = $("#refuse_reason").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: "ar_refuse", consignmentID: consignmentID, reason: reason, },
                        function (data) {
                            if (data == "success") {
                                alert("Đã từ chối sản phẩm");
                                location.reload();
                            } else if (data == "fail") {
                                alert("Có lỗi xảy ra");
                            }
                            else if (data == "error") {
                                alert("Yêu cầu đã được xử lý");
                            }
                        });
            }
            function acceptRequest() {
                var consignmentID = $("#r_ActionValue").val();
                var deliveryMethod = $("input[name='r_rdDeliveryMethod']:checked").val();
                var appointmentDate = $("#r_receivedDate").val();
                var hour = $("#r_hour").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: 'r_accept', consignmentID: consignmentID, deliveryMethod: deliveryMethod,
                            appointmentDate: appointmentDate, hour: hour},
                function (data) {
                    if (data == "success") {
                        alert("Đã chấp nhận yêu cầu");
                        location.reload();
                    } else if (data == "fail") {
                        alert("Cập nhật thất bại");
                    }
                    else if (data == "error") {
                        alert("Yêu cầu đã được xử lý");
                    }
                });
            }
//            function acceptRequest() {
//                var consignmentID = $("#r_ActionValue").val();
//                var productName = $("#r_productName").val();
//                var categoryID = $("#r_category").val();
//                var brand = $("#r_brand").val();
//                var description = $("#r_description").val();
//                var appointmentDate = $("#r_receivedDate").val();
//                var hour = $("#r_hour").val();
//                var isSpecial = 0;
//                if ($("input#r_isSpecial").is(":checked")) {
//                    isSpecial = 1;
//                }
//                var fullName = $("#r_txtFullName").val();
//                var address = $("#r_txtAddress").val();
//                var phone = $("#r_txtPhone").val();
//                var email = $("#r_txtEmail").val();
//                var paypalAccount = $("#r_txtPaypalAccount").val();
//                if ($("input[name='r_rdPayment'][value='direct']").is(":checked")) {
//                    paypalAccount = "";
//                }
//                var deliveryMethod = $("input[name='r_rdDeliveryMethod']:checked").val();
//
//                $.get('ConsignmentRequestReceive',
//                        {btnAction: 'r_accept', consignmentID: consignmentID, productName: productName,
//                            categoryID: categoryID, brand: brand, description: description, appointmentDate: appointmentDate, hour: hour, deliveryMethod: deliveryMethod, isSpecial: isSpecial,
//                            fullName: fullName, address: address, phone: phone, email: email, paypalAccount: paypalAccount},
//                function (data) {
//                    if (data == "success") {
//                        alert("Đã chấp nhận yêu cầu");
//                        location.reload();
//                    } else if (data == "fail") {
//                        alert("Cập nhật thất bại");
//                    }
//                    else if (data == "error") {
//                        alert("Yêu cầu đã được xử lý");
//                    }
//                });
//            }
            function refuseRequest() {
                var consignmentID = $("#refuse_consignmentID").val();
                var reason = $("#refuse_reason").val();
                $.get('ConsignmentRequestReceive',
                        {btnAction: "r_refuse", consignmentID: consignmentID, reason: reason, },
                        function (data) {
                            if (data == "success") {
                                alert("Đã từ chối yêu cầu");
                                location.reload();
                            } else if (data == "fail") {
                                alert("Có lỗi xảy ra");
                            }
                            else if (data == "error") {
                                alert("Yêu cầu đã được xử lý");
                            }
                        });
            }

            //            function ar_validation() {
            //                var minPrice = $("#ar_minPrice").val();
            //                var maxPrice = $("#ar_maxPrice").val();
            //                if (minPrice == "" || maxPrice == "") {
            //                    alert("Xin nhập giá.");
            //                    return false;
            //                }
            //                $("#ar_inputMinPrice").val(minPrice);
            //                $("#ar_inputMaxPrice").val(maxPrice);
            //                return true;
            //            }


            $('input:radio[name="rdPayment"]').change(function () {
                if ($(this).val() == "cc") {
                    $("#addConsignment_divCCNumber").show();
                }
                else {
                    $("#addConsignment_divCCNumber").hide();
                }
            });

//            $('input:radio[name="r_rdDeliveryMethod"]').change(function () {
//                if ($(this).val() == "store") {
//                    $("#div_r_receivedDate").show();
//                }
//                else {
//                    $("#div_r_receivedDate").hide();
//                }
//            });

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
                        day = '' + d.getDate(),
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

                if ($('#addConsignment_txtNegotiatedPrice').val().length > 0 && !isNaN($('#addConsignment_txtNegotiatedPrice').val())) {
                    $('#erNegotiatedPrice').html("");
                }
                else {
                    $('#erNegotiatedPrice').html("<font color='red'>Xin nhập đúng giá</font>");
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

            $(document).ready(function () {
                $('#daterangeAccepted').daterangepicker({
                    format: "DD/MM/YYYY",
                    startDate: moment(),
                    endDate: moment(),
                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
                });
                $('#daterangeRequest').daterangepicker({
                    format: "DD/MM/YYYY",
                    startDate: moment(),
                    endDate: moment(),
                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
                });
                $('#daterangeRefuse').daterangepicker({
                    format: "DD/MM/YYYY",
                    startDate: moment(),
                    endDate: moment(),
                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
                });
                $('#daterangeCancel').daterangepicker({
                    format: "DD/MM/YYYY",
                    startDate: moment(),
                    endDate: moment(),
                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
                });
            });
            $('#daterangeAccepted').on('apply.daterangepicker', function (ev, picker) {
                var table = $('#acceptedTable').DataTable();
                var startDate = $('#daterangeAccepted').data('daterangepicker').startDate.format('DD/MM/YYYY');
                var endDate = $('#daterangeAccepted').data('daterangepicker').endDate.format('DD/MM/YYYY');
                $('#fromDate').val(startDate);
                $('#toDate').val(endDate);
                table.draw();
            });
            $('#daterangeRequest').on('apply.daterangepicker', function (ev, picker) {
                var table = $('#requestTable').DataTable();
                var startDate = $('#daterangeRequest').data('daterangepicker').startDate.format('DD/MM/YYYY');
                var endDate = $('#daterangeRequest').data('daterangepicker').endDate.format('DD/MM/YYYY');
                $('#fromDate').val(startDate);
                $('#toDate').val(endDate);
                table.draw();
            });
            $('#daterangeRefuse').on('apply.daterangepicker', function (ev, picker) {
                var table = $('#refuseTable').DataTable();
                var startDate = $('#daterangeRefuse').data('daterangepicker').startDate.format('DD/MM/YYYY');
                var endDate = $('#daterangeRefuse').data('daterangepicker').endDate.format('DD/MM/YYYY');
                $('#fromDate').val(startDate);
                $('#toDate').val(endDate);
                table.draw();
            });
            $('#daterangeCancel').on('apply.daterangepicker', function (ev, picker) {
                var table = $('#cancelTable').DataTable();
                var startDate = $('#daterangeCancel').data('daterangepicker').startDate.format('DD/MM/YYYY');
                var endDate = $('#daterangeCancel').data('daterangepicker').endDate.format('DD/MM/YYYY');
                $('#fromDate').val(startDate);
                $('#toDate').val(endDate);
                table.draw();
            });
            $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var startDate = $('#fromDate').val();
                        var endDate = $('#toDate').val();
                        if (startDate == "" || endDate == "") {
                            return true;
                        } else {

                            if ($("#currentTab").val() == "accepted") {
                                var date = data[5].substring(6);
                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                            else if ($("#currentTab").val() == "request") {
                                var fromDate = data[5].substring(0, 10);
                                var toDate = data[5].substring(12, 22);

                                if (compareDate(fromDate, startDate) >= 0 && compareDate(fromDate, endDate) <= 0)
                                {
                                    return true;
                                }
                                else if (compareDate(toDate, startDate) >= 0 && compareDate(toDate, endDate) <= 0)
                                {
                                    return true;
                                }
                                else
                                {
                                    return false;
                                }

                            } else if ($("#currentTab").val() == "cancel") {
                                var date = data[4].substring(6);
                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                            else if ($("#currentTab").val() == "refuse") {
                                var date = data[4].substring(6);
                                if (compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                        }


                    }
            );

            function compareDate(source, target) {//return -1 if source < target, 1 if source > target and 0 if source = target
                //source = source.substring(6);
                if (source.substring(6, 10) > target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(3, 5) > target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(0, 2) > target.substring(0, 2) && source.substring(3, 5) >= target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                return -1;
            }


        </script> 


    </body>
    <!-- END BODY -->
</html>
