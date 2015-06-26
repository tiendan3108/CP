<%-- 
    Document   : trackProductStatus_Guest
    Created on : Jun 17, 2015, 4:06:37 AM
    Author     : Robingios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý ký gửi" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <!-- Latest compiled and minified CSS -->



        <style>
            .ui-autocomplete-loading {
                background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <c:if test="${acc.role == 'member'}">
                <li><a href="ViewCartServlet">Giỏ Hàng</a></li>  
                <li><a href="ConsignServlet">Kí Gửi</a></li>
                <li id="nofi">
                    <a href="#">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default">3</span>           
                    </a>
                    <ul class="fallback">
                        <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                    </ul>
                </li>
            </c:if>
            <c:if test="${acc.role == 'storeOwner'}">
                <li><a href="ConsignmentRequestReceive">Quản lý</a></li> 
                <li id="nofi">
                    <a href="#">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default">3</span>           
                    </a>
                    <ul class="fallback">
                        <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                    </ul>
                </li>
            </c:if>
        </c:if>
        <c:if test="${empty acc}">
            <li><a href="ViewCartServlet">Giỏ Hàng</a></li>  
            <li><a href="ConsignServlet">Kí Gửi</a></li>
            </c:if>

    </jsp:attribute>

    <jsp:attribute name="extraBottomContent">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1">
                <div class="row">

                    <form class="form-horizontal" role="form" action="TrackProductStatus">
                        <div class="form-body">
                            <div class="form-group">
                                <div class="col-md-8 col-sm-8 col-md-offset-2 col-sm-offset-2">
                                    <div class="input-group">
                                        <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}" placeholder="Điền CODE">
                                        <span class="input-group-btn">
                                            <button class="btn btn-success" type="submit" name="btnAction" value="search">Kiểm tra</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <br/><br/>
                    <c:if test="${empty CONSIGNMENT}">
                        <c:if test="${not empty param.searchValue}">
                            <h2 align="center">Sản phẩm với code này không tồn tại.</h2>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty CONSIGNMENT}">
                        <c:set var="c" value="${CONSIGNMENT}"/>

                        <!-- BEGIN PAGE CONTENT-->
                        <div class="row margin-bottom-25">
                            <!-- BEGIN CAROUSEL -->
                            <h2 class="modal-title"> <small> Từ khách hàng </small> ${c.name}</h2>
                            <div class="row">
                                <div class="col-lg-2 col-md-2">Email: <b><span  id="r_email">${c.email}</span></b></div>
                                <div class="col-lg-2 col-md-2">ĐT: <b><span  id="r_phone">${c.phone}</span></b></div>
                                <div class="col-lg-6 col-md-6">Địa chỉ: <span  id="r_address">${c.address}</span></div>

                            </div>
                                <br/>
                            <div class="col-lg-4 col-md-4 front-carousel">

                                <div class="carousel slide" id="myCarousel">
                                    <!-- Carousel items -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <img id="r_image" alt="${c.product.name}" src="${c.product.image}">
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
                                        <td id='r_productName'><b>${c.product.name}</b></td>
                                    </tr>
                                    <tr>
                                        <th width="30%">Mô tả</th>
                                        <td id='r_description'>${c.product.description}</td>
                                    </tr>
                                    <tr>
                                        <th>Cửa hàng ký gửi</th>
                                        <td id='r_createdDate'><b>${c.storeOwner.fullName}</b></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày ký gửi</th>
                                        <td id='r_createdDate'>${c.createdDate}</td>
                                    </tr>
                                    
                                    <tr >
                                        <th>Giá</th>
                                        <td id="r_price"><fmt:formatNumber type="number"
                                                value="${c.minPrice}" 
                                                maxFractionDigits="0"/>
                                            ~ <fmt:formatNumber type="number"
                                                value="${c.maxPrice}" 
                                                maxFractionDigits="0"/></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày hẹn</th>
                                        <td id='r_fromDateToDate'>
                                            ${c.fromDate} - ${c.toDate}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái</th>
                                        <td id='r_status'> <b>
                                                <c:choose>
                                                    <c:when test="${c.consignmentStatusID == 1}">
                                                        <font color="green"> Chờ xử lý</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 2}">
                                                        <font color="red">Đã từ chối</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 3}">
                                                        <font color="blue">Đã chấp nhận</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 4}">
                                                        <font color="blue">Hoàng thành</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 5}">
                                                        <font color="blue">Đã Nhận Hàng</font>
                                                    </c:when>
                                                </c:choose></b>
                                        </td>
                                    </tr>

                                </table>

                            </div>
                            <!-- END PRODUCT DESCRIPTION -->
                        </div>
                    </c:if>
                </div>


            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->

        <!--BEGIN MODAL -->
        <!-- Large modal -->

        <!-- END MODAL -->

        <div id="modalMessage" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Thông báo</h4>
                    </div>
                    <div class="modal-body">
                        <h1 id="r_message" align="center">${r_message}</h1>
                        <h1 id="ar_message" align="center">${ar_message}</h1>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </jsp:body>
</template:shopbasic>

<script type="text/javascript">

</script> 
