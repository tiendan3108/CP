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
        <style>
            .ui-autocomplete-loading {
                background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extraBottomContent">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script>
            $(function () {
                $("#searchInput").autocomplete({
                    source: "ConsignmentRequestReceive?btnAction=searchName&status=waiting",
                    minLength: 1,
                    select: function (event, ui) {
                    }
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40 ">
            <!--             BEGIN SIDEBAR 
                        <div class="sidebar col-md-3 col-sm-5">
                            <ul class="list-group margin-bottom-25 sidebar-menu">
                                <li class="list-group-item clearfix dropdown active open">
                                    <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                                    <ul class="dropdown-menu">
                                        <li class="list-group-item clearfix">
                                            <a href="./consignment?advand-search"><i class="fa fa-angle-right"></i> Tìm kiếm</a>
                                        </li>
                                        <li class="list-group-item clearfix active">
                                            <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
                                        </li>
                                        <li class="list-group-item clearfix">
                                            <a href="./consignment?accepted"><i class="fa fa-angle-right"></i> Yêu cầu đã duyệt</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="list-group-item clearfix dropdown">
                                    <a><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                                    <ul class="dropdown-menu">
                                        <li class="list-group-item clearfix">
                                            <a href="#"><i class="fa fa-angle-right"></i>Tìm kiếm nâng cao</a>
                                        </li>
                                        <li class="list-group-item clearfix">
                                            <a href="LoadManageProductPageServlet"><i class="fa fa-angle-right"></i>Hàng kí gửi</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="list-group-item clearfix dropdown">
                                    <a><i class="fa fa-angle-right"></i>Thống kê</a>
                                    <ul class="dropdown-menu">
                                        <li class="list-group-item clearfix">
                                            <a href="#"><i class="fa fa-angle-right"></i>Bán hàng</a>
                                        </li>
                                        <li class="list-group-item clearfix">
                                            <a href="#"><i class="fa fa-angle-right"></i>Thanh toán</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                         END SIDEBAR -->
            <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1">
                <h1>Yêu Cầu Kí Gửi</h1>
                <form class="form-horizontal" role="form" action="ConsignmentRequestReceive">
                    <div class="form-body">
                        <div class="form-group">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}">
                                    <span class="input-group-btn">
                                        <button class="btn btn-success" type="submit" name="btnAction" value="search">Tìm</button>
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
                                <c:if test="${empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                </c:if>
                                <c:if test="${not empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.searchValue}".</td>
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
        </div>
        <!-- END SIDEBAR & CONTENT -->

        <!--BEGIN MODAL -->
        <!-- Large modal -->
        <div id="modalRequest" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <p class="modal-title" id="exampleModalLabel"><b>Casio bla bla bla</b> của <b>A Hoàng</b></p>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="recipient-name" class="control-label">Recipient:</label>
                                <input id="r_id" type="text" class="form-control" id="recipient-name">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="control-label">Message:</label>
                                <textarea class="form-control" id="message-text"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Send message</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- END MODAL -->
    </jsp:body>
</template:shopbasic>
<script type="text/javascript">
    $('button[name="requestDetails"]').click(function () {
        var id = $(this).val();
        $("#r_id").val(id);
        $("modalRequest").modal("show");
    });
</script> 