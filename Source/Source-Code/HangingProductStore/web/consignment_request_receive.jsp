<%-- 
    Document   : consignment_request_receive
    Created on : Jun 16, 2015, 12:54:14 PM
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
                    <li class="list-group-item clearfix dropdown active">
                        <a href="ConsignmentRequestReceive"><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a href="ManageProduct"><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a href="#"><i class="fa fa-angle-right"></i>Thống kê</a>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR -->

            <div class="col-md-9 col-sm-8">
                <input type="hidden" id="currentTab" value="${currentTab}"/>
                <!-- START UPDATE -->
                <div class="tabs row">

                    <!-- Nav tabs -->
                    <ul class=" nav nav-tabs nav-justified" id="myTab">

                        <li id="requestTab"  class="active"><a href="#request">Yêu Cầu Kí Gửi</a></li>
                        <li id="acceptedTab"><a href="#accepted">Yêu cầu đã duyệt</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab active" id="request">

                            <form class="form-horizontal" role="form" action="ConsignmentRequestReceive" method="POST">
                                <div class="form-body">
                                    <div class="form-group">
                                        <div class="col-md-6 col-sm-6">
                                            <div class="input-group">
                                                <input id="r_searchInput" class="form-control" type="text" name="r_searchValue" value="${param.r_searchValue}">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-success" type="submit" name="btnAction" value="r_search">Tìm</button>
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
                                            Giá
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
                                    <c:if test="${empty CONSIGNMENT_REQUEST}">

                                        <tr>
                                            <c:if test="${empty param.r_searchValue}">
                                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                            </c:if>
                                            <c:if test="${not empty param.r_searchValue}">
                                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.r_searchValue}".</td>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="c" items="${CONSIGNMENT_REQUEST}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>
                                                ${c.product.name}
                                            </td>
                                            <td>
                                                ${c.createdDate}
                                                <%--<fmt:formatDate type="date" dateStyle="long" value="${c.requestDate}"/>--%>
                                            </td>
                                            <td>
                                                <%--   <fmt:formatNumber type="currency" currencySymbol="VNĐ" value="${c.maxPrice}" maxFractionDigits="0" /> --%>
                                                <fmt:formatNumber 
                                                    value="${c.minPrice}" 
                                                    maxFractionDigits="1"/>
                                                ~ <fmt:formatNumber 
                                                    value="${c.maxPrice}" 
                                                    maxFractionDigits="1"/>
                                            </td>
                                            <td>

                                                ${c.fromDate} - ${c.toDate}
                                            </td>
                                            <td align="center">
                                                <%--<c:url var="detailUrl" value="ConsignmentRequestReceive">
                                                    <c:param name="id" value="${c.consigmentID}"/>
                                                </c:url>
                                                <a href="${detailUrl}" 
                                                   class="btn btn-primary btn-xs"><b>Xem</b></a> --%>
                                                <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modalRequest"
                                                        name="requestDetails" value="${c.consigmentID}">Xem</button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>





                        <div class="tab" id="accepted">

                            <form class="form-horizontal" role="form" action="ConsignmentRequestReceive" method="POST">
                                <div class="form-body">
                                    <div class="form-group">
                                        <div class="col-md-6 col-sm-6">
                                            <div class="input-group">
                                                <input id="ar_searchInput" class="form-control" type="text" name="ar_searchValue" value="${param.ar_searchValue}">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-success" type="submit" name="btnAction" value="ar_search">Tìm</button>
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
                                            Giá
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
                                    <c:if test="${empty CONSIGNMENT_ACCEPT}">

                                        <tr>
                                            <c:if test="${empty param.ar_searchValue}">
                                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                            </c:if>
                                            <c:if test="${not empty param.ar_searchValue}">
                                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.ar_searchValue}".</td>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="c" items="${CONSIGNMENT_ACCEPT}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>
                                                ${c.product.name}
                                            </td>
                                            <td>
                                                ${c.createdDate}
                                                <%--<fmt:formatDate type="date" dateStyle="long" value="${c.requestDate}"/>--%>
                                            </td>
                                            <td>
                                                <%--   <fmt:formatNumber type="currency" currencySymbol="VNĐ" value="${c.maxPrice}" maxFractionDigits="0" /> --%>
                                                <fmt:formatNumber 
                                                    value="${c.minPrice}" 
                                                    maxFractionDigits="1"/>
                                                ~ <fmt:formatNumber 
                                                    value="${c.maxPrice}" 
                                                    maxFractionDigits="1"/>
                                            </td>
                                            <td>

                                                ${c.fromDate} - ${c.toDate}
                                            </td>
                                            <td align="center">
                                                <%--<c:url var="detailUrl" value="ConsignmentRequestReceive">
                                                    <c:param name="id" value="${c.consigmentID}"/>
                                                </c:url>
                                                <a href="${detailUrl}" 
                                                   class="btn btn-primary btn-xs"><b>Xem</b></a> --%>
                                                <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modalRequest"
                                                        name="requestDetails" value="${c.consigmentID}">Xem</button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>


                    </div>

                </div>



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
                                                <td id="ar_price" style="display: none;">
                                                    <input id="ar_minPrice" type="text" class="form-control"/> ~ <input id="ar_maxPrice" type="text" class="form-control"/>
                                                </td>
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

                            <div id="r_footer" class="modal-footer">
                                <form action="ConsignmentRequestReceive" method="POST">
                                    <button type="submit" name="btnAction" value="r_accept" class="btn btn-lg btn-primary">Chấp nhận</button>
                                    <button type="submit" name="btnAction" value="r_refuse" class="btn btn-lg btn-default">Từ chối</button>
                                    <input id="r_ActionValue" type="hidden" name="r_consignmentID"/>
                                    <input type="hidden" name="r_searchValue" value="${param.r_searchValue}"/>
                                </form>

                            </div>
                            <div id="ar_footer" class="modal-footer" style="display: none;">
                                <form id="ar_form" action="ConsignmentRequestReceive" method="POST" onsubmit="return ar_validation()">
                                    <button type="submit" name="btnAction" value="ar_accept" class="btn btn-lg btn-primary">Nhận hàng</button>
                                    <button type="submit" name="btnAction" value="ar_refuse" class="btn btn-lg btn-default">Từ chối</button>
                                    <input type="hidden" name="ar_searchValue" value="${param.ar_searchValue}"/>
                                    <input id="ar_ActionValue" type="hidden" name="ar_consignmentID"/>
                                    <input id="ar_inputProductID" type="hidden" name="ar_productID"/>
                                    <input id="ar_inputMinPrice" type="hidden" name="ar_minPrice"/>
                                    <input id="ar_inputMaxPrice" type="hidden" name="ar_maxPrice"/>
                                </form>

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
    $(document).ready(function () {
        $('.tabs .nav-justified a').on('click', function (e) {
            var currentAttrValue = $(this).attr('href');
            $('.tabs ' + currentAttrValue).fadeIn(400).siblings().hide();
            $(this).parent('li').addClass('active').siblings().removeClass('active');
            e.preventDefault();
        });
    });
    $(document).ready(function () {
        var currentTab = $('#currentTab').val();
        var currentLi = currentTab + 'Tab';
        $('div#' + currentTab).fadeIn(400).siblings().hide();
        $('li#' + currentLi).addClass('active').siblings().removeClass('active');
    });

    $(function () {
        $("#r_searchInput").autocomplete({
            source: "ConsignmentRequestReceive?btnAction=r_searchName",
            minLength: 1,
            select: function (event, ui) {
            }
        });

        $("#ar_searchInput").autocomplete({
            source: "ConsignmentRequestReceive?btnAction=ar_searchName",
            minLength: 1,
            select: function (event, ui) {
            }
        });

    });

    $('button[name="requestDetails"]').click(function () {
        var id = $(this).val();
        $("#r_id").val(id);
        $.get('ConsignmentRequestReceive', {btnAction: 'requestdetails', id: id}, function (data) {

            $("#r_name").html("<small>Từ khách hàng</small> " + data.name);
            $("#r_productName").html("<b>" + data.product.name + "</b>");
            $("#r_image").attr("src", data.product.image);
            $("#r_description").html(data.product.description);
            $("#r_createdDate").html(data.createdDate);
            $("#r_email").html(data.email);
            $("#r_phone").html(data.phone);
            $("#r_address").html(data.address);
            $("#r_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);
            if (data.consignmentStatusID == 1) {
                $("#r_status").html("<b><font color='red'>Đang chờ xử lý</font></b>");
                $("#r_ActionValue").val(data.consigmentID);
                $("#ar_ActionValue").val("");
                $("#r_footer").show();
                $("#ar_footer").hide();
                $("#r_price").show();
                $("#r_price").html(data.minPrice.toFixed(1) + "  ~  " + data.maxPrice.toFixed(1));
                $("#ar_price").hide();

            } else {
                $("#r_status").html("<b><font color='blue'>Chấp nhận yêu cầu</font></b>");
                $("#ar_ActionValue").val(data.consigmentID);
                $("#r_ActionValue").val("");
                $("#ar_footer").show();
                $("#r_footer").hide();
                $("#r_price").html("");
                $("#r_price").hide();
                $("#ar_price").show();
                $("#ar_minPrice").val(data.minPrice.toFixed(1));
                $("#ar_maxPrice").val(data.maxPrice.toFixed(1));
                $("#ar_inputProductID").val(data.product.productID);
            }

//            $('#btnRequestDetails').click();

        });
    });

    function ar_validation() {
        if(jQuery("#ar_form").context.activeElement.value != "ar_refuse"){
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
        return true;

    }



</script> 