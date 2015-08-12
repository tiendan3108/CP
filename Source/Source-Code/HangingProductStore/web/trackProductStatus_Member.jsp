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
    <jsp:attribute name="extraNavigationContent">  


    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div id="wrapper_manage">
            <div class="row margin-bottom-40">
                <!--BEGIN SIDEBAR -->
                
                <!-- END SIDEBAR -->

                <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1" style="background-color: white; padding-top: 30px ">

                    <form class="form-horizontal" role="form" action="TrackProductStatus">
                        <div class="form-body">
                            <div class="form-group">
                                <div class="col-md-6 col-sm-6">
                                    <div class="input-group">
                                        <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}">
                                        <span class="input-group-btn">
                                            <button class="btn btn-info" type="submit" name="btnAction" value="m_search">Tìm</button>
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
                                    Giá (Ngàn đồng)
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

                                        <c:choose>
                                            <c:when test="${c.negotiatedPrice > 0}">
                                                <fmt:formatNumber 
                                                    value="${c.negotiatedPrice}" 
                                                    maxFractionDigits="1"/>
                                            </c:when>
                                            <c:otherwise>
                                                <b><fmt:formatNumber 
                                                    value="${c.desirePrice}" 
                                                    maxFractionDigits="1"/></b>
                                                </c:otherwise>
                                            </c:choose>
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
                                        <b>
                                            <c:choose>
                                                <c:when test="${c.consignmentStatusID == 1}">
                                                    <font color="green">CHỜ XỬ LÝ</font>
                                                </c:when>
                                                <c:when test="${c.consignmentStatusID == 2}">

                                                    <c:choose>
                                                        <c:when test="${not empty c.reviewProductDate}">
                                                            <font color="red">TỪ CHỐI KHI NHẬN HÀNG</font>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <font color="red">TỪ CHỐI KHI DUYỆT YÊU CẦU</font>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:when test="${c.consignmentStatusID == 3}">
                                                    <font color="blue">ĐÃ CHẤP NHẬN YÊU CẦU</font>
                                                </c:when>
                                                <c:when test="${c.consignmentStatusID == 4}">
                                                    <font color="blue">HOÀN THÀNH</font>
                                                </c:when>
                                                <c:when test="${c.consignmentStatusID == 6}">
                                                    <font color="blue">ĐÃ HẾT HẠN</font>
                                                </c:when>
                                                <c:when test="${c.consignmentStatusID == 7}">
                                                    <font color="red">HOÀN TẤT HỦY</font>
                                                </c:when>

                                                <c:when test="${c.consignmentStatusID == 5}">
                                                    <c:choose>
                                                        <c:when test="${c.product.productStatusID == 2}">
                                                            <font color="blue">ĐÃ NHẬN HÀNG</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 3}">
                                                            <font color="blue">TRÊN WEB</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 4}">
                                                            <font color="blue">ĐÃ ĐƯỢC ĐẶT</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 5}">
                                                            <font color="blue">ĐÃ BÁN</font>
                                                        </c:when>

                                                        <c:when test="${c.product.productStatusID == 6}">
                                                            <font color="red">ĐĂNG KÝ HỦY</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 7}">
                                                            <font color="blue">ĐÃ HOÀN THÀNH</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 8}">
                                                            <font color="blue">CHỜ TRẢ HÀNG</font>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
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
                                                <!--                                                <a data-slide="prev" href="#myCarousel" class="carousel-control left">
                                                                                                    <i class="fa fa-angle-left"></i>
                                                                                                </a>
                                                                                                <a data-slide="next" href="#myCarousel" class="carousel-control right">
                                                                                                    <i class="fa fa-angle-right"></i>
                                                                                                </a>-->
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
                                                    <th width="30%">Độ mới</th>
                                                    <td id='r_newStatus'></td>
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
                                                    <th id="r_priceLabel">Giá</th>
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
                                                <tr id="div_r_reason">
                                                    <th>Lí do</th>
                                                    <td id='r_reason'>
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
                                            <button id="btnCancel" type="submit" name="btnAction" value="m_cancel" class="btn btn-primary">HỦY KÝ GỬI</button>
                                            <button class="btn btn-default" data-dismiss="modal">Đóng</button>
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

        </div>

        <script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
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

        $("#datatable_ajax").dataTable();
    });



    function loadDetails(id) {
        $.get('TrackProductStatus', {btnAction: 'requestdetails', id: id}, function (data) {
            $("#r_name").html("<small>Từ khách hàng</small> " + data.name);
            $("#r_productName").html("<b>" + data.product.name + "</b>");
            $("#r_newStatus").html(data.newStatus + "%");
            $("#r_image").attr("src", data.product.image);
            $("#r_description").html(data.product.description);
            $("#r_createdDate").html(data.createdDate);
            $("#r_email").html(data.email);
            $("#r_phone").html(data.phone);
            $("#r_address").html(data.address);

            if (data.appointmentDate != null) {
                $("#r_fromDateToDate").html(data.hour + "|" + data.appointmentDate);
            } else {
                $("#r_fromDateToDate").html(data.fromDate + "  ~  " + data.toDate);
            }

            if (data.negotiatedPrice > 0) {
                $("#r_priceLabel").html("Giá thương lượng");
                $("#r_price").html(formatDollar(data.negotiatedPrice) + " (Ngàn đồng)");
            } else {
                $("#r_priceLabel").html("Giá mong muốn");
                $("#r_price").html(formatDollar(data.desirePrice) + " (Ngàn đồng)");
            }
            $("#r_ActionValue").val(data.consigmentID);

            $("#div_r_reason").hide();
            $("#btnCancel").hide();
            
            if (data.consignmentStatusID == 1) {
                $("#r_status").html("<b><font color='green'>CHỜ XỬ LÝ</font></b>");
                $("#btnCancel").show();

            } else if (data.consignmentStatusID == 3) {
                $("#r_status").html("<b><font color='blue'>ĐÃ CHẤP NHẬN YÊU CẦU</font></b>");
                $("#btnCancel").show();
            }
            else if (data.consignmentStatusID == 2) {
                if (data.reviewProductDate != null) {
                    $("#r_status").html("<b><font color='red'>TỪ CHỐI KHI NHẬN HÀNG</font></b>");
                } else {
                    $("#r_status").html("<b><font color='red'>TỪ CHỐI KHI DUYỆT YÊU CẦU</font></b>");
                }

                $("#div_r_reason").show();
                $("#r_reason").html(data.reason);
            }
            else if (data.consignmentStatusID == 4) {
                $("#r_status").html("<b><font color='blue'>HOÀN THÀNH</font></b>");             
            }

            else if (data.consignmentStatusID == 6) {
                $("#r_status").html("<b><font color='purple'>ĐÃ HẾT HẠN</font></b>");
            }
            else if (data.consignmentStatusID == 4) {
                $("#r_status").html("<b><font color='blue'>HOÀN TẤT</font></b>");
            }
            
            else if (data.consignmentStatusID == 7) {
                $("#r_status").html("<b><font color='red'>HOÀN TẤT HỦY</font></b>");
            }
            
            else if (data.consignmentStatusID == 5) {
                if (data.product.productStatusID == 2) {
                    $("#r_status").html("<b><font color='blue'>ĐÃ NHẬN HÀNG</font></b>");
                    $("#btnCancel").show();
                }
                else if (data.product.productStatusID == 3) {
                    $("#r_status").html("<b><font color='blue'>ĐAND TRÊN WEB</font></b>");
                    $("#btnCancel").show();
                }
                else if (data.product.productStatusID == 4) {
                    $("#r_status").html("<b><font color='blue'>ĐÃ ĐƯỢC ĐẶT</font></b>");
                }
                else if (data.product.productStatusID == 5) {
                    $("#r_status").html("<b><font color='blue'>ĐÃ BÁN</font></b>");
                }

                else if (data.product.productStatusID == 6) {
                    $("#r_status").html("<b><font color='orange'>ĐĂNG KÝ HỦY</font></b>");
                } else if (data.product.productStatusID == 8) {
                    $("#r_status").html("<b><font color='purple'>CHỜ TRẢ HÀNG LẠI</font></b>");
                }
            }
        });
    }

    function formatDollar(num) {
        var p = num.toFixed(0);
        return  p.split("").reverse().reduce(function (acc, num, i, orig) {
            return  num + (i && !(i % 3) ? "," : "") + acc;
        }, "");
    }

    $('button[name="requestDetails"]').click(function () {
        var id = $(this).val();
        loadDetails(id);
    });
</script>