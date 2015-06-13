<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Consignment Request" bodyTitle="">
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
                    source: "consignment?search",
                    minLength: 2,
                    select: function (event, ui) {
                    }
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40 ">
            <!-- BEGIN SIDEBAR -->
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
            <!-- END SIDEBAR -->
            <div class="col-md-9">
                <h1>Yêu Cầu Kí Gửi</h1>
                <form class="form-horizontal" role="form" action="consignment">
                    <div class="form-body">
                        <div class="form-group">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}">
                                    <span class="input-group-btn">
                                        <button class="btn btn-success" type="submit" name="search">Tìm</button>
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
                                Ngày Giao
                            </th>
                            <th>
                                Chi Tiết
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty consignments}">

                            <tr>
                                <c:if test="${empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                                </c:if>
                                <c:if test="${not empty param.searchValue}">
                                    <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.searchValue}".</td>
                                </c:if>
                            </tr>
                        </c:if>
                        <c:forEach var="c" items="${consignments}" varStatus="counter">
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
                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ" value="${c.maxPrice}" maxFractionDigits="0" />
                                </td>
                                <td>
                                    ${c.fromDate} - ${c.toDate}
                                </td>
                                <td>
                                    <c:url var="detailUrl" value="consignment">
                                        <c:param name="id" value="${c.consigmentID}"/>
                                    </c:url>
                                    <a href="${detailUrl}" 
                                       class="btn btn-primary btn-xs">Xem</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </jsp:body>
</template:shopbasic>