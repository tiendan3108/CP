<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý hàng kí gửi" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!--BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-4">
                <ul class="list-group sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a href="ConsignmentRequestReceive"><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                    </li>
                    <li class="list-group-item clearfix dropdown active">
                        <a href="ManageProduct"><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a href="#"><i class="fa fa-angle-right"></i>Thống kê</a>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN RIGHT CONTENT -->
            <div class="col-md-9 col-sm-8">
                <!-- BEGIN TAB -->
                <div class="tabs row">
                    <!-- BEGIN TAB LINK -->
                    <ul class=" nav nav-tabs nav-justified" id="myTab">
                        <li id="availableTab" class="active"><a href="#available">Sản phẩm chờ duyệt</a></li>
                        <li id="onWebTab"><a href="#onWeb">Sản phẩm đang trên web</a></li>
                        <li id="orderedTab"><a href="#ordered">Sản phẩm đã được đặt mua</a></li>
                        <li id="soldTab"><a href="#sold">Sản phẩm đã được bán</a></li>
                        <li id="canceledTab"><a href="#canceled">Sản phẩm đăng kí hủy kỉ gửi</a></li>
                        <li id="completedTab"><a href="#completed">Sản phẩm đã hoàn tất thanh toán</a></li>
                    </ul>             
                    <!-- END TAB LINK -->
                    <!-- BEGIN TAB CONTENT -->
                    <div class="tab-content col-md-12">
                        <!-- BEGIN AVAILABLE TAB -->
                        <div id="available" class="tab active">
                            <c:set var="available" value="${requestScope.available}"></c:set>
                            <c:choose>
                                <c:when test="${available!=null}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Tên khách hàng</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Giá kí gửi</th>
                                                <th>Chi Tiết<th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${available}" varStatus="counter">
                                                <tr>
                                                    <td style="text-align: center"><font  >${counter.count}</font></td>
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  >${item.name}</font></td>
                                                    <td><font  >${item.receivedDate}</font></td>
                                                    <td><font  >${item.consigmentID}</font></td>
                                                    <td><font  >${item.minPrice}</font>~<font  >${item.maxPrice}</font></td>
                                                    <td  ><button class="btn btn-info availableModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
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
                        <div id="onWeb" class="tab col-md-12">
                            <c:set var="onWeb" value="${requestScope.onWeb}"></c:set>
                            <c:choose>
                                <c:when test="${onWeb!=null}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày đăng lên web</th>
                                                <th>Thời gian kí gửi</th>
                                                <th>Mã kí gửi</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${onWeb}" varStatus="counter">
                                                <tr>
                                                    <td style="text-align: center"><font  >${counter.count}</font></td>
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  >${item.raiseWebDate}</font></td>
                                                    <td><font  >${item.period}</font></td>
                                                    <td><font  >${item.consigmentID}</font></td>
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
                        <div id="ordered" class="tab col-md-12">
                            <c:set var="ordered" value="${requestScope.ordered}"></c:set>
                            <c:choose>
                                <c:when test="${ordered!=null}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày đặt hàng</th>
                                                <th>Mã đặt hàng</th>
                                                <th>SĐT liên hệ</th>
                                                <th>Chi Tiết<th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${ordered}" varStatus="counter">
                                                <tr>
                                                    <td style="text-align: center"><font  >${counter.count}</font></td>
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  >${item.product.orderDate}</font></td>
                                                    <td><font  >${item.product.orderID}</font></td>
                                                    <td><font  >${item.product.customerPhone}</font></td>
                                                    <td  ><button class="btn btn-info orderedModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
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
                        <div id="sold" class="tab col-md-12">
                            <c:set var="sold" value="${requestScope.sold}"></c:set>
                            <c:choose>
                                <c:when test="${sold!=null}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày nhận</th>
                                                <th>Mã kí gửi</th>
                                                <th>Giá bán</th>
                                                <th>Chi Tiết<th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${sold}" varStatus="counter">
                                                <tr>
                                                    <td style="text-align: center"><font  >${counter.count}</font></td>
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  >${item.receivedDate}</font></td>
                                                    <td><font  >${item.consigmentID}</font></td>
                                                    <td><font  >${item.product.sellingPrice}</font></td>
                                                    <td  ><button class="btn btn-info soldModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.productID}">Xem</button></td>
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
                        <div id="completed" class="tab col-md-12">
                            <c:set var="completed" value="${requestScope.completed}"></c:set>
                            <c:choose>
                                <c:when test="${completed!=null}">
                                    <table class="table table-striped table-bordered table-hover">
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
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  >${item.receivedDate}</font></td>
                                                    <td><font  >${item.consigmentID}</font></td>
                                                    <td><font  >${item.returnPrice}</font></td>
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
                        <div id="canceled" class="tab col-md-12">
                            <c:set var="canceled" value="${requestScope.canceled}"></c:set>
                            <c:choose>
                                <c:when test="${canceled!=null}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Ngày hủy</th>
                                                <th>Ngày kí gửi</th>
                                                <th>Mã kí gửi</th>
                                                <th>TT liên lạc</th>
                                                <th>Chi Tiết<th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${canceled}" varStatus="counter">
                                                <tr>
                                                    <td style="text-align: center"><font  >${counter.count}</font></td>
                                                    <td><font  >${item.product.name}</font></td>
                                                    <td><font  ></font></td>
                                                    <td><font  >${item.receivedDate}</font></td>
                                                    <td><font  >${item.consigmentID}</font></td>
                                                    <td><font  >
                                                        <c:if test="${item.phone!=null}">
                                                            ${item.phone}
                                                        </c:if>
                                                        <c:if test="${item.phone==null && item.email!=null}">
                                                            ${item.email}
                                                        </c:if></font></td>
                                                    <td  ><button class="btn btn-info cancelModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button></td>
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
                                        </br>
                                        <li>Họ tên : <label id="sold_fullName"></label></li>
                                        <li>Địa chỉ : <label id="sold_address"></label></li>
                                        <li>Số điện thoại : <label id="sold_phone"></label></li>
                                        <li>Email : <label id="sold_email"></label></li>
                                        <li>Tài khoản Paypal : <label id="sold_paypalAccount"></label></li>
                                    </div>
                                    <div class="col-sm-6">
                                        <h5>Thông tin sản phẩm</h5>
                                        </br>
                                        <li>Tên sản phẩm : <label id="sold_productName"></label></li>
                                        <li>Mã kí gửi : <label id="sold_consignmentID"></label></li>
                                        <li>Giá sản phẩm : <label id="sold_minPrice"></label> ~ <label id="sold_maxPrice"></label></li>
                                        <li>Giá bán: <label id="sold_sellingPrice"></label></li>
                                        <li>Ngày kí gửi : <label id="sold_receivedDate"></label></li>
                                        <li>Tiền trả khách hàng: <input type="text" name="txtReturnPrice"></li>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    </br></br>
                                    <input type="hidden" name="txtConsignmentID" id="soldconsignmentID" value="">
                                    <input class="btn default" type="submit" name="btnAction" value="Trả tiền">
                                    <input class="btn default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
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
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <h5>Thông tin người đặt</h5>
                                        </br>
                                        <li>Họ tên : <label id="ordered_fullName"></label></li>
                                        <li>Địa chỉ : <label id="ordered_address"></label></li>
                                        <li>Số điện thoại : <label id="ordered_phone"></label></li>
                                        <li>Email : <label id="ordered_email"></label></li>
                                    </div>
                                    <div class="col-sm-6">
                                        <h5>Thông tin sản phẩm</h5>
                                        </br>
                                        <li>Tên sản phẩm : <label id="ordered_productName"></label></li>
                                        <li>Mã đơn hàng : <label id="ordered_orderID"></label></li>
                                        <li>Giá sản phẩm : <label id="ordered_minPrice"></label> ~ <label id="ordered_maxPrice"></label></li>
                                        <li>Ngày đặt mua : <label id="ordered_orderDate"></label></li>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <form action="OrderProduct" method="POST">
                                    </br></br>
                                    <input type="hidden" name="txtOrderID" id="ordered_orderID" value="">
                                    <input type="hidden" name="txtProductID" id="order_ID" value="">
                                    <input class="btn default confirmOrderedModal" type="button" data-togle="modal" value="Đồng ý bán">
                                    <button class="btn default" name="btnAction" type="submit" value="notOrder">Không đồng ý bán</button>
                                    <input class="btn default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
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
                                    <h4>Vui lòng nhập giá</h4>        
                                </div>
                                <div class="modal-body">
                                    <label class="control-label">Giá bán :</label><input type="text" name="txtSellingPrice" value ="" style="width: 300px;"> VND
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="txtProductID" id="order_ProductID" value="">
                                    <input type="hidden" name="txtConsignmentID" id="order_ConsignmentID" value="">
                                    <button class="btn default" name="btnAction" type="submit" value="order">Đồng ý</button>
                                    <input class="btn default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
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
                                    </br>
                                    <li>Họ tên : <label id="cancel_fullName"></label></li>
                                    <li>Địa chỉ : <label id="cancel_address"></label></li>
                                    <li>Số điện thoại : <label id="cancel_phone"></label></li>
                                    <li>Email : <label id="cancel_email"></label></li>
                                </div>
                                <div class="col-sm-6">
                                    <h5>Thông tin hàng kí gửi</h5>
                                    </br>
                                    <li>Tên sản phẩm : <label id="cancel_productName"></label></li>
                                    <li>Mã hàng kí gửi : <label id="cancel_consignmentID"></label></li>
                                    <li>Giá kí gửi : <label id="cancel_minPrice"></label> ~ <label id="cancel_maxPrice"></label></li>
                                    <li>Ngày kí gửi : <label id="cancel_consignedDate"></label></li>
                                    <li>Ngày hủy kí gửi : <label id="cancel_canceledDate"></label></li>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <form action="CancelProduct" method="POST">
                                    </br></br>
                                    <input type="hidden" name="txtConsignmentID" id="cancel_ID" value="">
                                    <button class="btn default" name="btnAction" type="submit" value="cancel">Đồng ý hủy</button>
                                    <button class="btn default" name="btnAction" type="submit" value="notCancel">Không đồng ý hủy</button>
                                    <input class="btn default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- CANCEL MODAL END-->
                <!-- AVAILABLE MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="availableModal">
                    <form action="PublishProduct" method="POST" enctype="multipart/form-data">
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
                                    <input type="hidden" id="avai_ProductID" value="" name="txtProductID">
                                    <button class="btn default" type="submit">Duyệt</button>
                                    <input class="btn default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- AVAILABLE MODAL END-->
            </div>
        </div>
        <input type="hidden" id="currentTab" value="${requestScope.currentTab}">
        <!-- END SIDEBAR & CONTENT -->
    </jsp:body>
</template:shopbasic>
<script>
    //script switch tab
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
        $.get('LoadOrderedProduct', {productID: productID}, function (response) {
            var product = response.product;
            $("#ordered_fullName").text(response.name);
            $("#ordered_address").text(response.address);
            $("#ordered_phone").text(response.phone);
            $("#ordered_email").text(response.email);
            $("#ordered_orderID").text(response.consigmentID);
            $("#ordered_minPrice").text(product.minPrice);
            $("#ordered_maxPrice").text(product.maxPrice);
            $("#ordered_productName").text(product.name);
            $("#ordered_orderDate").text(response.receivedDate);
            $("#order_ID").val(productID);
            $("#order_ProductID").val(productID);
            $("#ordered_orderID").val(productID);
            $("#order_ConsignmentID").val(response.consigmentID);
        });
        $('#orderedModal').modal('show');
    });
    $(document).on("click", ".confirmOrderedModal", function () {
        $('#confirmOrderedModal').modal('show');
    });
    //end ordered modal
    //start sold modal
    $(document).on("click", ".soldModal", function () {
        var productID = $(this).data('id');
        $.get('LoadSoldProduct', {productID: productID}, function (response) {
            var product = response.product;
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
            $("#sold_name").val(product.name);
        });
        $('#soldModal').modal('show');
    });
    //end sold modal
</script>