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
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1">
                <div class="row">
                    <div role="tabpanel">

                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs nav-justified" role="tablist" id="myTab">
                            <li role="presentation" class="active"><a href="#tab_request" aria-controls="home" role="tab" data-toggle="tab">Yêu Cầu Kí Gửi</a></li>
                            <li role="presentation"><a href="#tab_accept_request" aria-controls="profile" role="tab" data-toggle="tab">Yêu cầu đã duyệt</a></li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_request">

                                <form class="form-horizontal" role="form" action="ConsignmentRequestReceive">
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
                                                    <button type="button" class="btn btn-primary btn-xs" name="requestDetails" value="${c.consigmentID}">Xem</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>





                            <div role="tabpanel" class="tab-pane fade" id="tab_accept_request">

                                <form class="form-horizontal" role="form" action="ConsignmentRequestReceive">
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
                                                    <button type="button" class="btn btn-primary btn-xs" name="requestDetails" value="${c.consigmentID}">Xem</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>


                        </div>

                    </div>
                </div>


            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->

        <!--BEGIN MODAL -->
        <!-- Large modal -->
        <div id="modalRequest" class="modal face bs-example-modal-lg">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>


                        <h2 class="modal-title" id="r_name"></h2>
                        <div class="row">
                            <div class="col-lg-2 col-md-2">Email: <b><span  id="r_email"></span></b></div>
                            <div class="col-lg-2 col-md-2">ĐT: <b><span  id="r_phone"></span></b></div>
                            <div class="col-lg-4 col-md-4">Địa chỉ: <span  id="r_address"></span></div>
                            
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
                        <form action="ConsignmentRequestReceive" method="POST" onsubmit="return er_validation()">
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


        <button type="button" id="btnRequestDetails" data-toggle="modal" data-target="#modalRequest" style="display: none;" >Mở details</button>
        <button type="button" id="btnMessage" data-toggle="modal" data-target="#modalMessage" style="display: none;">Mở message</button>
    </jsp:body>
</template:shopbasic>

<script type="text/javascript">
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

            $('#btnRequestDetails').click();

        });
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
        if ($("#r_message").html() != "" || $("#ar_message").html() != "") {
            $("#btnMessage").click();
            if ($("#ar_message").html() != "") {
                $('#myTab a[href="#tab_accept_request"]').tab('show'); // Select tab by name
            }
        }
        if ($("#ar_searchInput").val() != "") {
            $('#myTab a[href="#tab_accept_request"]').tab('show'); // Select tab by name
        }
    });

    function er_validation() {
        var minPrice = $("#ar_minPrice").val();
        var maxPrice = $("#ar_maxPrice").val();
        if (minPrice == "" || maxPrice == "") {
            alert("Xin nhập giá.");
            return false;
        }
        $("#ar_inputMinPrice").val(minPrice);
        $("#ar_inputMaxPrice").val(maxPrice);
//        
        //alert($("#ar_inputMinPrice").val() + " - " + $("#ar_inputMaxPrice").val() + " - " + $("#ar_ActionValue").val() + " - " + " - " + $("#ar_inputProductID").val());
        return true;
    }

</script> 