<%-- 
    Document   : consignment_request_receive
    Created on : Jun 16, 2015, 12:54:14 PM
    Author     : Robingios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý ký gửi" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="js/jquery-ui.css">
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
    <jsp:attribute name="extraNavigationContent">

    </jsp:attribute>
    <jsp:body>
        <div id="wrapper_manage">
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
                            <a href="Statistics"><i class="fa fa-angle-right"></i>Thống kê</a>
                        </li>
                    </ul>
                </div>
                <!-- END SIDEBAR -->

                <div class="col-md-9 col-sm-8">
                    <!-- START UPDATE -->
                    <div class="tabs row tab-style-1">

                        <!-- Nav tabs -->
                        <ul class=" nav nav-tabs nav-justified" id="myTab">

                            <li id="requestTab" ><a href="#request"><b>Chưa duyệt</b></a></li>
                            <li id="acceptedTab"><a href="#accepted"><b>Đã duyệt</b></a></li>
                            <li id="refuseTab"><a href="#refuse"><b>Từ chối</b></a></li>
                            <li id="cancelTab"><a href="#cancel"><b>Đã hủy</b></a></li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content" style="background-color: white">
                            <div class="tab active" id="request" style="display: none">
                                <input type="hidden" id="currentTab" value="${currentTab}"/>
                                <form class="form-horizontal" role="form" action="ConsignmentRequestReceive" method="POST">
                                    <div class="form-body">
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6">
                                                <div class="input-group">
                                                    <input id="r_searchInput" class="form-control" type="text" name="r_searchValue" value="${param.r_searchValue}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-info" type="submit" name="btnAction" value="r_search">Tìm</button>
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
                                                STT
                                            </th>
                                            <th>
                                                Tên Sản Phẩm
                                            </th>
                                            <!--                                        <th>
                                                                                        Mã ký gửi
                                                                                    </th>-->
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
                                                Chi Tiết
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty REQUEST}">

                                            <tr>
                                                <c:if test="${empty param.r_searchValue}">
                                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                                </c:if>
                                                <c:if test="${not empty param.r_searchValue}">
                                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.r_searchValue}".</td>
                                                </c:if>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="c" items="${REQUEST}" varStatus="counter">
                                            <tr>
                                                <td>${counter.count}</td>
                                                <td>
                                                    ${c.product.name}
                                                </td>
                                                <!--                                            <td>
                                                ${c.consigmentID}
                                            </td>-->
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
                                                            <b><font color="red">Chưa có giá</font></b>
                                                            </c:otherwise>
                                                        </c:choose>
                                                </td>
                                                <td>

                                                    ${c.fromDate} - ${c.toDate}
                                                </td>
                                                <td align="center">

                                                    <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequest"
                                                            name="requestDetails" value="${c.consigmentID}">Xem</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>





                            <div class="tab" id="accepted" style="display: none">

                                <form class="form-horizontal" role="form" action="ConsignmentRequestReceive" method="POST">
                                    <div class="form-body">
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6">
                                                <div class="input-group">
                                                    <input id="ar_searchInput" class="form-control" type="text" name="ar_searchValue" value="${param.ar_searchValue}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-info" type="submit" name="btnAction" value="ar_search">Tìm</button>
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
                                                STT
                                            </th>
                                            <th>
                                                Tên Sản Phẩm
                                            </th>
                                            <!--                                        <th>
                                                                                        Mã ký gửi
                                                                                    </th>-->
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
                                                Chi Tiết
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty ACCEPT}">

                                            <tr>
                                                <c:if test="${empty param.ar_searchValue}">
                                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                                </c:if>
                                                <c:if test="${not empty param.ar_searchValue}">
                                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.ar_searchValue}".</td>
                                                </c:if>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="c" items="${ACCEPT}" varStatus="counter">
                                            <tr>
                                                <td>${counter.count}</td>
                                                <td>
                                                    ${c.product.name}
                                                </td>
                                                <!--                                            <td>
                                                ${c.consigmentID}
                                            </td>-->
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
                                                            <b><font color="red">Chưa có giá</font></b>
                                                            </c:otherwise>
                                                        </c:choose>
                                                </td>
                                                <td>

                                                    ${c.fromDate} - ${c.toDate}
                                                </td>
                                                <td align="center">

                                                    <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequest"
                                                            name="requestDetails" value="${c.consigmentID}">Xem</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>

                            <div class="tab" id="refuse" style="display: none">
                                <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
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
                                                Ngày Gửi
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
                                        <c:if test="${empty REFUSE}">

                                            <tr>

                                                <td colspan="6">Không có yêu cầu nào </td>

                                            </tr>
                                        </c:if>
                                        <c:forEach var="c" items="${REFUSE}" varStatus="counter">
                                            <tr>
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

                                                    ${c.fromDate} - ${c.toDate}
                                                </td>
                                                <td align="center">

                                                    <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequest"
                                                            name="requestDetails" value="${c.consigmentID}">Xem</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab" id="cancel" style="display: none">
                                <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
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
                                                Ngày Gửi
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
                                        <c:if test="${empty CANCEL}">

                                            <tr>

                                                <td colspan="6">Không có yêu cầu nào </td>

                                            </tr>
                                        </c:if>
                                        <c:forEach var="c" items="${CANCEL}" varStatus="counter">
                                            <tr>
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

                                                    <button type="button" class="btn btn-info" style="width: 70px; height: 30px" data-toggle="modal" data-target="#modalRequest"
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
                                                    <th>Giá (VND)</th>
                                                    <td id="r_price"></td>
                                                    <td id="ar_price" style="display: none;">
                                                        <div class="input-group">
                                                            <input type="text" id="ar_minPrice" class="form-control" >
                                                            <span class="input-group-addon">
                                                                ~ </span>
                                                            <input type="text" id="ar_maxPrice" class="form-control" >    
                                                        </div>  
                                                        <!--                                                    <input id="ar_minPrice" type="text" class="form-control"/> ~ <input id="ar_maxPrice" type="text" class="form-control"/>-->
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
                                <div class="modal-footer">
                                    <div id="r_footer" >
                                        <form action="ConsignmentRequestReceive" method="POST">
                                            <button type="submit" name="btnAction" value="r_accept" class="btn btn-lg btn-primary">Chấp nhận</button>
                                            <button type="submit" name="btnAction" value="r_refuse" class="btn btn-lg btn-default">Từ chối</button>
                                            <input id="r_ActionValue" type="hidden" name="r_consignmentID"/>
                                            <input type="hidden" name="r_searchValue" value="${param.r_searchValue}"/>
                                        </form>

                                    </div>
                                    <div id="ar_footer" style="display: none;">
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
                    </div>
                    <!-- END MODAL -->

                </div>
            </div>
            <!-- END SIDEBAR & CONTENT -->

        </div>
    </jsp:body>
</template:shopbasic>

<script type="text/javascript">
    $(document).ready(function () {
        $('.tabs .nav-tabs a').on('click', function (e) {
            var currentAttrValue = $(this).attr('href');

            $('.tabs ' + currentAttrValue).siblings().hide();
            $(this).parent('li').siblings().removeClass('active');

            $('.tabs ' + currentAttrValue).fadeIn(400);
            $(this).parent('li').addClass('active');

            window.location.hash = $(this).attr('href');
            $('html,body').scrollTop(0);
            e.preventDefault();

        });
    });
    $(document).ready(function () {

        //var currentTab = $('#currentTab').val();
        var currentTab = window.location.hash.substring(1);
        if(currentTab == ""){
            currentTab = $('#currentTab').val();
        }
        var currentLi = currentTab + 'Tab';
        $('div#' + currentTab).siblings().hide();
        $('li#' + currentLi).siblings().removeClass('active');

        $('div#' + currentTab).fadeIn(400);
        $('li#' + currentLi).addClass('active');



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
        $.get('ConsignmentRequestReceive', {btnAction: 'requestdetails', id: id}, function (data) {

            $("#r_name").html("<small>Từ khách hàng</small> " + data.name);
            $("#r_productName").html("<b>" + data.product.name + "</b>");
            $("#r_image").attr("src", data.product.image);
            $("#r_description").html(data.product.description);
            $("#r_createdDate").html(data.createdDate);
            $("#r_email").html(data.email);
            $("#r_phone").html("0" + data.phone.substring(3));
            $("#r_address").html(data.address);
            $("#r_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);
            if (data.product.productStatusID == 6) {
                $("#r_status").html("<b><font color='red'>ĐÃ HỦY</font></b>");
                $("#r_footer").hide();
                $("#ar_footer").hide();
            }
            else {
                if (data.consignmentStatusID == 1) {
                    $("#r_status").html("<b><font color='blue'>CHỜ XỬ LÝ</font></b>");
                    $("#r_ActionValue").val(data.consigmentID);
                    $("#ar_ActionValue").val("");
                    $("#r_footer").show();
                    $("#ar_footer").hide();
                    $("#r_price").show();
                    if (data.minPrice > 0 && data.maxPrice > 0) {


                        $("#r_price").html(data.minPrice.toFixed(0) + "  ~  " + data.maxPrice.toFixed(0) + " VND");
                    } else {
                        $("#r_price").html("");
                    }
                    $("#ar_price").hide();

                } else if (data.consignmentStatusID == 3) {
                    $("#r_status").html("<b><font color='green'>ĐÃ CHẤP NHẬN</font></b>");
                    $("#ar_ActionValue").val(data.consigmentID);
                    $("#r_ActionValue").val("");
                    $("#ar_footer").show();
                    $("#r_footer").hide();
                    $("#r_price").html("");
                    $("#r_price").hide();
                    $("#ar_price").show();
                    $("#ar_minPrice").val(data.minPrice.toFixed(0));
                    $("#ar_maxPrice").val(data.maxPrice.toFixed(0));
                    $("#ar_inputProductID").val(data.product.productID);
                }
                else if (data.consignmentStatusID == 2) {
                    $("#r_status").html("<b><font color='red'>ĐÃ TỪ CHỐI</font></b>");
                    $("#r_footer").hide();
                    $("#ar_footer").hide();
                } else if (data.consignmentStatusID == 4) {
                    $("#r_status").html("<b><font color='blue'>HOÀN THÀNH</font></b>");
                    $("#r_footer").hide();
                    $("#ar_footer").hide();
                } else if (data.consignmentStatusID == 5) {
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
                }
            }

//            $('#btnRequestDetails').click();

        });
    });

    function ar_validation() {
        if (jQuery("#ar_form").context.activeElement.value != "ar_refuse") {
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