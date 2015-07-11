<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý hàng kí gửi" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <!-- Nơi để khai báo page level css, theme, style -->
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <li id="nofi">
                <a href="#">
                    <i class="icon-bell"></i>
                    <span class="badge badge-default">3</span>           
                </a>
                <ul class="fallback">
                    <li style="margin-left: -40px"><a href="#">notification 1</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                </ul>
            </li>
        </c:if>
    </jsp:attribute>
    <jsp:body>
        <div id="wrapper_manage">
            <input type="hidden" id="currentTab" value="${requestScope.currentTab}">
            <!-- BEGIN SIDEBAR & CONTENT -->
            <div class="row margin-bottom-40">
                <!--BEGIN SIDEBAR -->
                <div class="sidebar col-md-3 col-sm-4">
                    <ul class="list-group sidebar-menu" style="font-size: 14px;">
                        <li class="list-group-item clearfix dropdown">
                            <a href="ConsignmentRequestReceive"><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                        </li>
                        <li class="list-group-item clearfix dropdown active">
                            <a href="ManageProduct"><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                        </li>
                        <li class="list-group-item clearfix dropdown">
                            <a href="Statistics"><i class="fa fa-angle-right"></i>Thống kê</a>
                        </li>
                    </ul>
                </div>
                <!-- END SIDEBAR -->
                <!-- BEGIN RIGHT CONTENT -->
                <div class="col-md-9 col-sm-8">
                    <!-- BEGIN TAB -->
                    <div class="tabs row">
                        <!-- BEGIN TAB LINK -->
                        <ul class=" nav nav-tabs nav-justified" id="myTab" style="margin-bottom: 3px">
                            <li id="availableTab"><a href="#available">Chờ duyệt</a></li>
                            <li id="onWebTab"><a href="#onWeb">Trên web</a></li>
                            <li id="orderedTab"><a href="#ordered">Đã được đặt</a></li>
                            <li id="soldTab"><a href="#sold">Đã bán</a></li>
                        </ul>
                        <ul class=" nav nav-tabs nav-justified">
                            <li id="canceledTab"><a href="#canceled">Đăng kí hủy kí gửi</a></li>
                            <li id="completedTab"><a href="#completed">Hoàn tất thanh toán</a></li>
                            <li id="expiredTab"><a href="#expired">Hết hạn kí gửi</a></li>
                        </ul>
                        <!-- END TAB LINK -->
                        <!-- BEGIN TAB CONTENT -->
                        <div class="tab-content col-md-12">
                            <!-- BEGIN EXPIRED TAB -->
                            <div id="expired" class="tab">
                                <c:set var="expired" value="${requestScope.expired}">
                                </c:set>
                                <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                    <div class="form-body">
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6">
                                                <div class="input-group">
                                                    <input type="hidden" name="txtCurrentTab" value="expired">
                                                    <input class="form-control" type="text" name="txtKeywork" value="${keywork7}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${expired == null && requestScope.keywork7 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${requestScope.keywork7}</font>.
                                    </c:when>
                                    <c:when test="${expired!=null}">
                                        <table class="table table-striped table-bordered table-hover"id="availableTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Ngày nhận</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>Giá kí gửi</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${expired}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font>${item.name}</font></td>
                                                        <td><font>${item.receivedDate}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <td><fmt:formatNumber 
                                                                value="${item.minPrice}" 
                                                                maxFractionDigits="1"/>
                                                            &nbsp; ~ &nbsp;
                                                            <fmt:formatNumber 
                                                                value="${item.maxPrice}" 
                                                                maxFractionDigits="1"/>
                                                        </td>
                                                        <td><button class="btn btn-info expiredModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END EXPIRED TAB -->
                            <!-- BEGIN AVAILABLE TAB -->
                            <div id="available" class="tab" style="display: none">
                                <c:set var="available" value="${requestScope.available}">
                                </c:set>
                                <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                    <div class="form-body">
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6">
                                                <div class="input-group">
                                                    <input type="hidden" name="txtCurrentTab" value="available">
                                                    <input class="form-control" type="text" name="txtKeywork" value="${keywork1}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${available == null && requestScope.keywork1 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork1}</font>.
                                    </c:when>
                                    <c:when test="${available!=null}">
                                        <table class="table table-striped table-bordered table-hover"id="availableTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Ngày nhận</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>Giá kí gửi</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${available}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font>${item.name}</font></td>
                                                        <td><font>${item.receivedDate}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <td>
                                                            <fmt:formatNumber 
                                                                value="${item.minPrice}" 
                                                                maxFractionDigits="1"/>
                                                            &nbsp; ~ &nbsp;
                                                            <fmt:formatNumber 
                                                                value="${item.maxPrice}" 
                                                                maxFractionDigits="1"/>
                                                        </td>
                                                        <td><button class="btn btn-info availableModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END AVAILABLE TAB -->
                            <!-- BEGIN ONWEB TAB -->
                            <div id="onWeb" class="tab col-md-12" style="display: none">
                                <c:set var="onWeb" value="${requestScope.onWeb}"></c:set>
                                    <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="input-group">
                                                        <input type="hidden" name="txtCurrentTab" value="onWeb">
                                                        <input class="form-control" type="text" name="txtKeywork" value="${keywork2}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${onWeb == null && requestScope.keywork2 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork2}</font>.
                                    </c:when>
                                    <c:when test="${onWeb!=null}">
                                        <table class="table table-striped table-bordered table-hover" id="onWebTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Ngày đăng lên web</th>
                                                    <th>Thời gian kí gửi</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${onWeb}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font>${item.raiseWebDate}</font></td>
                                                        <td><font>${item.period}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <th><a class="btn btn-info" href="ViewProductDetailServlet?productID=${item.product.productID}">Xem</a></th>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END ONWEB TAB -->
                            <!-- BEGIN ORDERED TAB -->
                            <div id="ordered" class="tab col-md-12" style="display: none">
                                <c:set var="ordered" value="${requestScope.ordered}"></c:set>
                                    <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="input-group">
                                                        <input type="hidden" name="txtCurrentTab" value="ordered">
                                                        <input class="form-control" type="text" name="txtKeywork" value="${keywork3}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${ordered == null && requestScope.keywork3 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork3}</font>.
                                    </c:when>
                                    <c:when test="${ordered!=null}">
                                        <table class="table table-striped table-bordered table-hover" id="orderedTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Giá sản phẩm</th>
                                                    <th>Số người đặt</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${ordered}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td>
                                                            <fmt:formatNumber 
                                                                value="${item.product.minPrice}" 
                                                                maxFractionDigits="1"/>
                                                            &nbsp; ~ &nbsp;
                                                            <fmt:formatNumber 
                                                                value="${item.product.maxPrice}" 
                                                                maxFractionDigits="1"/>
                                                        </td>
                                                        <td><font>${item.quantity}</font></td>
                                                        <td><button class="btn btn-info orderedModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.product.productID}">Xem</button></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END ORDERED TAB -->
                            <!-- BEGIN SOLD TAB -->
                            <div id="sold" class="tab col-md-12" style="display: none">
                                <c:set var="sold" value="${requestScope.sold}"></c:set>
                                    <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="input-group">
                                                        <input type="hidden" name="txtCurrentTab" value="sold">
                                                        <input class="form-control" type="text" name="txtKeywork" value="${keywork4}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${sold == null && requestScope.keywork4 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork4}</font>.
                                    </c:when>
                                    <c:when test="${sold!=null}">
                                        <table class="table table-striped table-bordered table-hover" id="soldTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Ngày nhận</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>Giá bán</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${sold}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font>${item.receivedDate}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <td>
                                                            <fmt:formatNumber 
                                                                value="${item.product.sellingPrice}" 
                                                                maxFractionDigits="1"/>
                                                        </td>
                                                        <td><button class="btn btn-info soldModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END SOLD TAB -->
                            <!-- BEGIN COMPLETED TAB -->
                            <div id="completed" class="tab col-md-12" style="display: none">
                                <c:set var="completed" value="${requestScope.completed}"></c:set>
                                    <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="input-group">
                                                        <input type="hidden" name="txtCurrentTab" value="completed">
                                                        <input class="form-control" type="text" name="txtKeywork" value="${keywork5}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${completed == null && requestScope.keywork5 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork5}</font>.
                                    </c:when>
                                    <c:when test="${completed!=null}">
                                        <table class="table table-striped table-bordered table-hover" id="completedTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Ngày nhận</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>Giá trả khách hàng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${completed}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font>${item.receivedDate}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <td><fmt:formatNumber 
                                                                value="${item.returnPrice}" 
                                                                maxFractionDigits="1"/>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END COMPLETED TAB -->
                            <!-- BEGIN CANCELED TAB -->
                            <div id="canceled" class="tab col-md-12" style="display: none">
                                <c:set var="canceled" value="${requestScope.canceled}"></c:set>
                                    <form class="form-horizontal" role="form" action="ManageProduct" method="POST">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="input-group">
                                                        <input type="hidden" name="txtCurrentTab" value="canceled">
                                                        <input class="form-control" type="text" name="txtKeywork" value="${keywork6}">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-success" type="submit">Tìm</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <c:choose>
                                    <c:when test="${canceled == null && requestScope.keywork6 != null}">
                                        Không có sản phẩm tìm kiếm phù hợp với từ khóa <font style="color: red">${keywork6}</font>.
                                    </c:when>
                                    <c:when test="${canceled!=null}">
                                        <table class="table table-striped table-bordered table-hover" id="canceledTable">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Ngày hủy</th>
                                                    <th>Ngày kí gửi</th>
                                                    <th>Mã kí gửi</th>
                                                    <th>TT liên lạc</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${canceled}" varStatus="counter">
                                                    <tr>
                                                        <td style="text-align: center"><font  >${counter.count}</font></td>
                                                        <td><font>${item.product.name}</font></td>
                                                        <td><font></font></td>
                                                        <td><font>${item.receivedDate}</font></td>
                                                        <td><font>${item.consigmentID}</font></td>
                                                        <td><font>
                                                            <c:if test="${item.phone!=null}">
                                                                ${item.phone}
                                                            </c:if>
                                                            <c:if test="${item.phone==null && item.email!=null}">
                                                                ${item.email}
                                                            </c:if></font></td>
                                                        <td><button class="btn btn-info cancelModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách hiện thời trống
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END CANCELED TAB -->
                        </div>
                        <!-- END TAB CONTENT -->
                    </div>
                    <!-- END TAB -->
                    <!-- END TAB CONTENT -->
                </div>
                <!-- END RIGHT CONTENT -->                                            
                <div id="modal">
                    <!-- SOLD MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="soldModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <form action="SoldProduct" method="POST">
                                    <div class="modal-header">
                                        <h4>Thông tin sản phẩm</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-sm-6">
                                            <h5>Thông tin người kí gửi</h5>
                                            <li>Họ tên : <label id="sold_fullName"></label></li>
                                            <li>Địa chỉ : <label id="sold_address"></label></li>
                                            <li>Số điện thoại : <label id="sold_phone"></label></li>
                                            <li>Email : <label id="sold_email"></label></li>
                                            <li>Tài khoản Paypal : <label id="sold_paypalAccount"></label></li>
                                        </div>
                                        <div class="col-sm-6">
                                            <h5>Thông tin sản phẩm</h5>
                                            <li>Tên sản phẩm : <label id="sold_productName"></label></li>
                                            <li>Mã kí gửi : <label id="sold_consignmentID"></label></li>
                                            <li>Giá sản phẩm : <label id="sold_minPrice"></label> &nbsp; ~ &nbsp; <label id="sold_maxPrice"></label></li>
                                            <li>Giá bán: <label id="sold_sellingPrice"></label></li>
                                            <li>Ngày kí gửi : <label id="sold_receivedDate"></label></li>
                                            <li>Tiền trả khách hàng: <input type="text" name="txtReturnPrice" id="sold_returnPrice"></li>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="soldconsignmentID" value="">
                                        <input class="btn btn-info" type="submit" name="btnAction" value="Trả tiền">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- SOLD MODAL END-->
                    <!-- ORDERED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="orderedModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4>Thông tin đặt hàng</h4>        
                                </div>
                                <div class="modal-body" id="ordered_bodymodal">
                                    <div class="col-sm-6" id="OrderList">
                                    </div>
                                    <div class="col-sm-6" id="ProductInfor">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form action="OrderProduct" method="POST">
                                        <input class="btn btn-info confirmOrderedModal" type="button" data-togle="modal" value="Đồng ý bán" onclick="return checkCustomer();">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ORDERED MODAL END-->
                    <!-- CONFIRM ORDERED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmOrderedModal">
                        <div class="modal-dialog modal-lg">
                            <form action="OrderProduct" method="POST">
                                <div class="modal-content modal-manage">
                                    <div class="modal-header">
                                        <h4>Thông tin giá bán</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <label class="control-label">Giá bán :</label><input type="text" name="txtSellingPrice" value ="" style="width: 300px;"> VND
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtOrderID" id="order_OrderID">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="order">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM ORDERED MODAL END-->
                    <!-- CANCEL MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="cancelModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content modal-manage">
                                <div class="modal-header">
                                    <h4>Thông tin hủy kí gửi</h4>        
                                </div>
                                <div class="modal-body">
                                    <div class="col-sm-6">
                                        <h5>Thông tin người kí gửi</h5>
                                        <li>Họ tên : <label id="cancel_fullName"></label></li>
                                        <li>Địa chỉ : <label id="cancel_address"></label></li>
                                        <li>Số điện thoại : <label id="cancel_phone"></label></li>
                                        <li>Email : <label id="cancel_email"></label></li>
                                    </div>
                                    <div class="col-sm-6">
                                        <h5>Thông tin hàng kí gửi</h5>
                                        <li>Tên sản phẩm : <label id="cancel_productName"></label></li>
                                        <li>Mã hàng kí gửi : <label id="cancel_consignmentID"></label></li>
                                        <li>Giá kí gửi : <label id="cancel_minPrice"></label> &nbsp; ~ &nbsp; <label id="cancel_maxPrice"></label></li>
                                        <li>Ngày kí gửi : <label id="cancel_consignedDate"></label></li>
                                        <li>Ngày hủy kí gửi : <label id="cancel_canceledDate"></label></li>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form action="CancelProduct" method="POST">
                                        <input type="hidden" name="txtConsignmentID" id="cancel_ID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="cancel">Đồng ý hủy</button>
                                        <button class="btn btn-warning" name="btnAction" type="submit" value="notCancel">Không đồng ý hủy</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- CANCEL MODAL END-->
                    <!-- AVAILABLE MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="availableModal">
                        <form action="PublishProduct" method="POST" enctype="multipart/form-data">
                            <input type="hidden" id="avai_ProductID" value="" name="txtProductID">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content modal-manage">
                                    <div class="modal-header">
                                        <h4>Thông tin sản phẩm</h4>        
                                    </div>
                                    <div class="modal-body">
                                        <div class="tab-content">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label for="txtProductName" class="col-sm-4 control-label">Tên sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_ProductName" type="text" class="form-control" maxlength="50" name="txtProductName"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txtSerial" class="col-sm-4 control-label">Số seri </label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_SerialNumber" type="text" class="form-control" name="txtSerialNumber"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Ngày mua hàng</label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group date date-picker">
                                                                    <input id="avai_BoughtDate" type="text" class="form-control" name="txtDate" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Loại sản phẩm</label>
                                                            <div class="col-sm-8">
                                                                <c:set var="parentCat" value="${requestScope.parentCat}"/>
                                                                <c:set var="allCat" value="${requestScope.allCat}"/>
                                                                <select id="avai_Category" name="txtCategory"style="width: 120px">
                                                                    <c:forEach var="parent" items="${parentCat}">
                                                                        <optgroup label="${parent.categoryName}">
                                                                            <c:forEach var="item" items="${allCat}">
                                                                                <c:if test="${item.parentId == parent.categoryId}">
                                                                                    <option id="${item.categoryId}" value="${item.categoryId}">${item.categoryName}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </optgroup>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Hãng</label>
                                                            <div class="col-sm-8">
                                                                <input id="avai_Brand" type="text" class="form-control" maxlength="26" name="txtBrand"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mùa </label>
                                                            <div class="col-sm-8">
                                                                <c:forEach var="item" items="${requestScope.season}">
                                                                    <input style="width: 8%" type="checkbox" name="chkSeason" value="${item.seasonID}"/><label style="width: 40%">${item.seasonName}</label>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label">Mô tả </label>
                                                            <div class="col-sm-8">
                                                                <textarea id="avai_Description" class="form-control" maxlength="225" rows="6" placeholder="" name="txtDescription"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-4 col-sm-4">Ảnh sản phẩm</label>
                                                            <div class="col-md-8 col-sm-8" align="center">
                                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                    <div class="fileinput-new thumbnail">
                                                                        <img src="" id="avai_Image"/>
                                                                    </div>
                                                                    <div >
                                                                        <span class="btn btn-info btn-file" style="width: 100%">
                                                                            <input type="file" name="txtImage" onchange="readURL(this);" style="max-width: "/>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-info" type="submit">Duyệt</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- AVAILABLE MODAL END-->
                    <!-- EXPIRED MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="expiredModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content modal-manage">
                                <div class="modal-header">
                                    <h4>Thông tin sản phẩm</h4>        
                                </div>
                                <div class="modal-body">
                                    <div class="col-sm-6">
                                        <h5>Thông tin người kí gửi</h5>
                                        <li>Họ tên : <label id="expired_fullName"></label></li>
                                        <li>Địa chỉ : <label id="expired_address"></label></li>
                                        <li>Số điện thoại : <label id="expired_phone"></label></li>
                                        <li>Email : <label id="expired_email"></label></li>
                                    </div>
                                    <div class="col-sm-6">
                                        <h5>Thông tin hàng kí gửi</h5>
                                        <li>Tên sản phẩm : <label id="expired_productName"></label></li>
                                        <li>Mã hàng kí gửi : <label id="expired_consignmentID"></label></li>
                                        <li>Ngày kí gửi : <label id="expired_consignedDate"></label></li>
                                        <li>Thời gian kí gửi : <label id="expired_period"></label></li>
                                        <li>Số ngày quá hạn: <label id="expired_days"></label></li>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <form>
                                        <input class="btn btn-info confirmExtendModal" type="button" data-togle="modal" value="Gia hạn">
                                        <input class="btn btn-info confirmReceiveModal" type="button" data-togle="modal" value="Nhận hàng">
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- EXPIRED MODAL END-->
                    <!-- CONFIRM EXTEND MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmExtendModal">
                        <div class="modal-dialog modal-lg">
                            <form action="ExtendProduct" method="POST">
                                <div class="modal-content modal-manage">
                                    <div class="modal-header">
                                        <h4>Thời hạn kí gửi</h4>
                                    </div>
                                    <div class="modal-body">
                                        <label class="control-label">Số ngày :</label><input type="text" name="txtPeriod" value ="" style="width: 300px;"> ngày
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="expired_extendConsignmentID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="extend">Gia hạn</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM EXTEND MODAL END-->
                    <!-- CONFIRM RECEIVE MODAL BEGIN-->
                    <div class="modal fade bs-example-modal-lg" id="confirmReceiveModal">
                        <div class="modal-dialog modal-lg">
                            <form action="ExtendProduct" method="POST">
                                <div class="modal-content modal-manage">
                                    <div class="modal-header">
                                        <h4>Thông tin tiền phạt</h4>
                                    </div>
                                    <div class="modal-body">
                                        <label class="control-label">Tiền phạt :</label><input type="text" id="expired_fee" value="" name="txtExpiredFee"> VND
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="txtConsignmentID" id="expired_receiveConsignmentID" value="">
                                        <button class="btn btn-info" name="btnAction" type="submit" value="receive">Đồng ý</button>
                                        <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- CONFIRM RECEIVE MODAL END-->
                </div>
            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </jsp:body>
</template:shopbasic>
<script>
    //script switch tab
    $(document).ready(function () {
        $('.tabs .nav-justified a').on('click', function (e) {
            var currentAttrValue = $(this).attr('href');
            $('.tabs ' + currentAttrValue).fadeIn(400).siblings().hide();
            $(this).parent('li').parent('ul').siblings().children('li').removeClass('active');
            $(this).parent('li').addClass('active').siblings().removeClass('active');
            $('.search-box').val('');
            window.location.hash = $(this).attr('href');
            $('html,body').scrollTop(0);
            e.preventDefault();
        });
    });
    $(document).ready(function () {
        var currentTab = window.location.hash.substring(1);
        if (currentTab == "") {
            currentTab = $('#currentTab').val();
        }
        var currentLi = currentTab + 'Tab';
        $('div#' + currentTab).fadeIn(400).siblings().hide();
        $('li#' + currentLi).parent('ul').siblings().children('li').removeClass('active');
        $('li#' + currentLi).addClass('active').siblings().removeClass('active');
        $('html,body').scrollTop(0);
    });
    //start cancel modal
    $(document).on("click", ".cancelModal", function () {
        var consignmentID = $(this).data('id');
        $.get('LoadCancelProduct', {consignmentID: consignmentID}, function (response) {
            var product = response.product;
            $("#cancel_fullName").text(response.name);
            $("#cancel_address").text(response.address);
            $("#cancel_phone").text(response.phone);
            $("#cancel_email").text(response.email);
            $("#cancel_productName").text(product.name);
            $("#cancel_consignmentID").text(product.consignmentID);
            $("#cancel_minPrice").text(product.minPrice);
            $("#cancel_maxPrice").text(product.maxPrice);
            $("#cancel_consignedDate").text(product.receivedDate);
            $("#cancel_canceledDate").text(product.cancelDate);
            $("#cancel_ID").val(product.consignmentID);
        });
        $('#cancelModal').modal('show');
    });
    //end cancel modal
    //start available modal
    $(document).on("click", ".availableModal", function () {
        var productID = $(this).data('id');
        $.get('LoadAvailableProduct', {productID: productID}, function (response) {
            $("#avai_ProductName").val(response.name);
            $("#avai_ProductID").val(response.productID);
            $("#avai_SerialNumber").val(response.serialNumber);
            $("#avai_BoughtDate").val(response.purchasedDate);
            $("#avai_Brand").val(response.brand);
            $("#avai_Description").val(response.description);
            $("#avai_Image").attr("src", response.image);
            var option = "option#" + response.categoryID;
            $(option).attr("selected", "selected");
        });
        $('#availableModal').modal('show');
    });
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#avai_Image').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    ;
    //end available modal
    //start ordered modal
    $(document).on("click", ".orderedModal", function () {
        var productID = $(this).data('id');
        var bodyDiv = $('#ordered_bodymodal');
        bodyDiv.html('');
        $.get('LoadOrderedProduct', {productID: productID}, function (response) {
            var listOrder = response.orderList;
            bodyDiv.append('<div class="col-sm-6" id="OrderList">\n\
                            <h5>Thông tin người đặt hàng</h5>');
            var orderList = $('#OrderList');
            for (var i = 0; i < listOrder.length; i++) {
                orderList.append('<div class="form-group" id="OrderInfor' + i + '">');
                var orderInfor = $('#OrderInfor' + i + '');
                orderInfor.append('<input type="radio" value="' + listOrder[i].orderID + '"class="rbnCustomer">');
                orderInfor.append('<li>Họ tên : ' + listOrder[i].fullName + '</li>');
                orderInfor.append('<li>Địa chỉ : ' + listOrder[i].address + '</li>');
                orderInfor.append('<li>Số điện thoại : ' + listOrder[i].phone + '</li>');
                orderInfor.append('<li>Email : ' + listOrder[i].email + '</li>');
            }
            bodyDiv.append('<div class="col-sm-6" id="ProductInfor">');
            var productInfor = $('#ProductInfor');
            productInfor.append('<h5>Thông tin sản phẩm</h5>')
            productInfor.append('<div class="form-group" id="ProductInfo">');
            var productInfo = $('#ProductInfo');
            productInfo.append('<li> Tên sản phẩm : ' + response.name + '</li>');
            productInfo.append('<li> Mã hàng kí gửi : ' + response.consignmentID + '</li>');
            productInfo.append('<li>Giá sản phẩm : ' + response.minPrice + '&nbsp; ~ &nbsp;' + response.maxPrice + '</li>');
        });
        $('#orderedModal').modal('show');
    });
    //end ordered modal
    //start sold modal
    $(document).on("click", ".soldModal", function () {
        var productID = $(this).data('id');
        $.get('LoadSoldProduct', {productID: productID}, function (response) {
            var product = response.product;
            var price;
            var minPrice = response.minPrice;
            var maxPrice = response.maxPrice;
            var sellingPrice = response.returnPrice;
            if ((sellingPrice / maxPrice) > 1.2) {
                price = maxPrice.toFixed(0);
            } else {
                price = minPrice.toFixed(0);
            };
            $("#sold_fullName").text(response.name);
            $("#sold_address").text(response.address);
            $("#sold_phone").text(response.phone);
            $("#sold_email").text(response.email);
            $("#sold_productName").text(product.name);
            $("#sold_consignmentID").text(response.consigmentID);
            $("#sold_minPrice").text(response.minPrice);
            $("#sold_maxPrice").text(response.maxPrice);
            $("#sold_sellingPrice").text(response.returnPrice);
            $("#sold_receivedDate").text(response.receivedDate);
            $("#sold_paypalAccount").text(response.paypalAccount);
            $("#soldconsignmentID").val(response.consigmentID);
            $("#sold_returnPrice").val(price);
            $("#sold_name").val(product.name);
        });
        $('#soldModal').modal('show');
    });
    //end sold modal
    //start expired modal
    $(document).on("click", ".expiredModal", function () {
        var consignmentID = $(this).data('id');
        $.get('LoadExpiredProduct', {consignmentID: consignmentID}, function (response) {
            $("#expired_fullName").text(response.name);
            $("#expired_address").text(response.address);
            $("#expired_phone").text(response.phone);
            $("#expired_email").text(response.email);
            $("#expired_productName").text(response.product.name);
            $("#expired_consignmentID").text(consignmentID);
            $("#expired_consignedDate").text(response.receivedDate);
            $("#expired_period").text(response.period);
            $("#expired_days").text(response.expiredDays);
            $("#expired_fee").val(response.expiredFee);
        });
        $('#expiredModal').modal('show');
    });
    $(document).on("click", ".confirmExtendModal", function () {
        $('#confirmExtendModal').modal('show');
    });
    $(document).on("click", ".confirmReceiveModal", function () {
        $('#confirmReceiveModal').modal('show');
    });
    //end expired modal
    // validation check customer
    function checkCustomer()
    {
        var ratioButton = document.getElementsByClassName('rbnCustomer');
        var ischecked_method = false;
        for (var i = 0; i < ratioButton.length; i++) {
            if (ratioButton[i].checked) {
                ischecked_method = true;
                console.log(ratioButton[i].value);
                $('#order_OrderID').val(ratioButton[i].value);
                break;
            }
        }
        if (ischecked_method) {
            $('#confirmOrderedModal').modal('show');
        } else {
            alert("Vui lòng chọn một khách hàng");
            return false;
        }
    };
</script>