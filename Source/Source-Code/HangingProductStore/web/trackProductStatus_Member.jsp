<%-- 
    Document   : trackProductStatus_Member
    Created on : Jun 25, 2015, 10:29:45 PM
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
    <jsp:attribute name="extraBottomContent">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>

    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!--BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-4">
                <ul class="list-group sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a href="#"><i class="fa fa-angle-right"></i>Cá nhân</a>
                    </li>
                    <li class="list-group-item clearfix dropdown active">
                        <a href="TrackProductProduct"><i class="fa fa-angle-right"></i>Ký gửi</a>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a href="#"><i class="fa fa-angle-right"></i>Mua bán</a>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR -->

            <div class="col-md-9 col-sm-8">

                <form class="form-horizontal" role="form" action="TrackProductStatus">
                    <div class="form-body">
                        <div class="form-group">
                            <div class="col-md-6 col-sm-6">
                                <div class="input-group">
                                    <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}">
                                    <span class="input-group-btn">
                                        <button class="btn btn-success" type="submit" name="btnAction" value="m_search">Tìm</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                    <thead>
                        <tr role="row" class="heading">
                            <th>
                                Stt.
                            </th>
                            <th>
                                Tên Sản Phẩm
                            </th>
                            <th>
                                Ngày Gửi
                            </th>
                            <th>
                                Giá (VND)
                            </th>
                            <th>
                                Ngày hẹn
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
                        <c:if test="${empty CONSIGNMENT}">

                            <tr>
                                <c:if test="${empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                </c:if>
                                <c:if test="${not empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.searchValue}".</td>
                                </c:if>
                            </tr>
                        </c:if>
                        <c:forEach var="c" items="${CONSIGNMENT}" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>
                                    ${c.product.name}
                                </td>
                                <td>
                                    ${c.createdDate}

                                </td>
                                <td>

                                    <fmt:formatNumber 
                                        value="${c.minPrice}" 
                                        maxFractionDigits="1"/>
                                    &nbsp;~&nbsp; <fmt:formatNumber 
                                        value="${c.maxPrice}" 
                                        maxFractionDigits="1"/>
                                </td>
                                <td>

                                    ${c.fromDate} - ${c.toDate}
                                </td>
                                <td>
                                    <b>
                                        <c:choose>
                                            <c:when test="${c.product.productStatusID == 6}">
                                                <font color="red">ĐÃ HỦY</font>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${c.consignmentStatusID == 1}">
                                                        <font color="green">CHỜ XỬ LÝ</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 2}">
                                                        <font color="red">ĐÃ TỪ CHỐI</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 3}">
                                                        <font color="blue">ĐÃ CHẤP NHẬN</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 4}">
                                                        <font color="blue">HOÀN THÀNH</font>
                                                    </c:when>
                                                    <c:when test="${c.consignmentStatusID == 5}">
                                                        <c:choose>
                                                            <c:when test="${c.product.productStatusID == 2}">
                                                                <font color="blue">ĐÃ NHẬP HÀNG</font>
                                                            </c:when>
                                                            <c:when test="${c.product.productStatusID == 3}">
                                                                <font color="blue">ĐANG TRÊN WEB</font>
                                                            </c:when>
                                                            <c:when test="${c.product.productStatusID == 4}">
                                                                <font color="blue">ĐÃ ĐƯỢC ĐẶT</font>
                                                            </c:when>
                                                            <c:when test="${c.product.productStatusID == 5}">
                                                                <font color="blue">ĐÃ BÁN</font>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:when>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </b>
                                </td>
                                <td align="center">

                                    <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequest"
                                            name="requestDetails" value="${c.consigmentID}">Xem</button>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>







                <!--BEGIN MODAL -->
                <!-- Large modal -->
                <div id="modalRequest" class="modal fade bs-example-modal-lg" aria-hidden="true">
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
                                <div class="row margin-bottom-25">
                                    <!-- BEGIN CAROUSEL -->
                                    <div class="col-lg-4 col-md-4 front-carousel">

                                        <div class="carousel slide" id="myCarousel">
                                            <!-- Carousel items -->
                                            <div class="carousel-inner">
                                                <div class="item active">
                                                    <img id="r_image" alt="">
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
                                                <td id='r_productName'></td>
                                            </tr>
                                            <tr>
                                                <th width="30%">Mô tả</th>
                                                <td id='r_description'></td>
                                            </tr>
                                            <tr>
                                                <th>Ngày ký gửi</th>
                                                <td id='r_createdDate'></td>
                                            </tr>
                                            <tr >
                                                <th>Giá</th>
                                                <td id="r_price"></td>
                                            </tr>
                                            <tr>
                                                <th>Ngày hẹn</th>
                                                <td id='r_fromDateToDate'></td>
                                            </tr>
                                            <tr>
                                                <th>Trạng thái</th>
                                                <td id='r_status'>


                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                    <!-- END PRODUCT DESCRIPTION -->
                                </div>

                            </div>

                            <div  class="modal-footer">
                                <div id="r_footer">
                                    <form action="TrackProductStatus" method="POST">
                                        <button type="submit" name="btnAction" value="m_cancel" class="btn btn-lg btn-primary">HỦY KÝ GỬI</button>
                                        <!--                                    <button type="submit" name="btnAction" value="r_refuse" class="btn btn-lg btn-default">Từ chối</button>-->
                                        <input id="r_ActionValue" type="hidden" name="actionValue"/>
                                        <input type="hidden" name="searchValue" value="${param.searchValue}"/>
                                    </form>
                                </div>
                                    
                            </div>

                        </div>
                    </div>
                </div>
                <!-- END MODAL -->

            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->


    </jsp:body>
</template:shopbasic>
<script type="text/javascript">
    $(function () {
        $("#searchInput").autocomplete({
            source: "TrackProductStatus?btnAction=m_searchName",
            minLength: 1,
            select: function (event, ui) {
            }
        });

    });

    function loadDetails(id) {
        $.get('TrackProductStatus', {btnAction: 'requestdetails', id: id}, function (data) {
            $("#r_name").html("<small>Từ khách hàng</small> " + data.name);
            $("#r_productName").html("<b>" + data.product.name + "</b>");
            $("#r_image").attr("src", data.product.image);
            $("#r_description").html(data.product.description);
            $("#r_createdDate").html(data.createdDate);
            $("#r_email").html(data.email);
            $("#r_phone").html(data.phone);
            $("#r_address").html(data.address);
            $("#r_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);
            $("#r_price").html(data.minPrice.toFixed(0) + "  ~  " + data.maxPrice.toFixed(0) + " VND");
            $("#r_ActionValue").val(data.product.productID);
            if (data.product.productStatusID == 6) {
                $("#r_status").html("<b><font color='red'>ĐÃ HỦY</font></b>");
                $("#r_footer").hide();
            }
            else {
                if (data.consignmentStatusID == 1) {
                    $("#r_status").html("<b><font color='blue'>CHỜ XỬ LÝ</font></b>");
                    $("#r_footer").show();

                } else if (data.consignmentStatusID == 3) {
                    $("#r_status").html("<b><font color='green'>ĐÃ CHẤP NHẬN</font></b>");
                    $("#r_footer").show();
                }
                else if (data.consignmentStatusID == 2) {
                    $("#r_status").html("<b><font color='red'>ĐÃ TỪ CHỐI</font></b>");
                    $("#r_footer").hide();
                }
                else if (data.consignmentStatusID == 4) {
                    $("#r_status").html("<b><font color='blue'>HOÀN THÀNH</font></b>");
                    $("#r_footer").hide();
                }
                else if (data.consignmentStatusID == 5) {
                    if (data.product.productStatusID == 2) {
                        $("#r_status").html("<b><font color='blue'>ĐÃ NHẬN HÀNG</font></b>");
                        $("#r_footer").show();
                    }
                    else if (data.product.productStatusID == 3) {
                        $("#r_status").html("<b><font color='blue'>ĐAND TRÊN WEB</font></b>");
                        $("#r_footer").show();
                    }
                    else if (data.product.productStatusID == 4) {
                        $("#r_status").html("<b><font color='blue'>ĐÃ ĐƯỢC ĐẶT</font></b>");
                        $("#r_footer").hide();
                    }
                    else if (data.product.productStatusID == 5) {
                        $("#r_status").html("<b><font color='blue'>ĐÃ BÁN</font></b>");
                        $("#r_footer").hide();
                    }

                }
            }

        });
    }

    $('button[name="requestDetails"]').click(function () {
        var id = $(this).val();
        loadDetails(id);
    });
</script>