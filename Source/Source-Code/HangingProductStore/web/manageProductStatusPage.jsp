<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý hàng kí gửi" bodyTitle="">
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40 ">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-5">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu kí gửi</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="./consignment?search"><i class="fa fa-angle-right"></i> Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix active">
                                <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
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
                <h4>Danh sách hàng kí gửi</h4>
                <div class="content-search margin-bottom-20"> 
                    <form action="SearchProductStatusServlet" method="POST">
                        <div class="row">
                            <div class="col-md-4">
                                <select name="typeSearch" class="bs-select form-control input-small" data-style="blue">
                                    <option>Tất cả</option>
                                    <option>Tên sản phẩm</option>
                                    <option>Ngày nhận hàng</option>
                                    <option>Mã kí gửi</option>
                                    <option>Trạng thái</option>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <input required="true" name="txtKeywords" type="text" placeholder="Search" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btn-primary" type="submit">Tìm Kiếm</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                    <thead>
                        <tr role="row" class="heading">
                            <th>
                                STT
                            </th>
                            <th>
                                Tên sản phẩm
                            </th>
                            <th>
                                Ngày nhận
                            </th>
                            <th>
                                Mã kí gửi
                            </th>
                            <th>
                                Giá kí gửi
                            </th>
                            <th>
                                Trạng thái
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="result" value="${requestScope.result}"/>
                        <c:if test="${not empty result}">
                            <c:forEach var="item" items="${result}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${item.name}</td>
                                    <td>${item.receivedDate}</td>
                                    <td>${item.consignmentID}</td>
                                    <td>${item.consignedPrice} USD</td>
                                    <td>
                                        <c:set var="status" value="${item.productStatusID}"/>
                                        <c:choose>
                                            <c:when test="${status==5}">
                                                <form action="LoadPaymentPageServlet" method="POST">
                                                    <button style="width: 150px" class="btn btn-warning" type="submit">Đã bán</button>
                                                    <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                                </form>
                                            </c:when>
                                            <c:when test="${status==4}">
                                                <form action="LoadCustomerPageServlet" method="POST">
                                                    <button style="width: 150px" class="btn btn-info" type="submit">Đã được đặt</button>
                                                    <input name="productID" type="hidden" value="${item.productID}">
                                                </form>
                                            </c:when>
                                            <c:when test="${status==3}">
                                                <form action="ViewProductDetailServlet" method="POST">
                                                    <button style="width: 150px" class="btn btn-info" type="submit">Trên web</button>
                                                    <input name="productID" type="hidden" value="${item.productID}">
                                                </form>
                                            </c:when>
                                            <c:when test="${status==2}">
                                                <form action="LoadPublishPageServlet" method="POST">
                                                    <button style="width: 150px" class="btn btn-default" type="submit">Chờ duyệt</button>
                                                    <input name="productID" type="hidden" value="${item.productID}">
                                                </form>
                                            </c:when>
                                            <c:when test="${status==6}">
                                                <form action="LoadCancelProductPageServlet" method="POST">
                                                    <button style="width: 150px" class="btn btn-warning" type="submit">Đăng kí hủy</button>
                                                    <input name="productID" type="hidden" value="${item.productID}">
                                                    <input name="consignmentID" type="hidden" value="${item.consignmentID}">
                                                </form>
                                            </c:when>
                                            <c:when test="${status==7}">
                                                <button style="width: 150px" class="btn btn-default"  disabled="true">Hoàn tất</button>
                                                <input name="productID" type="hidden" value="${item.productID}">
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </jsp:body>
</template:shopbasic>