<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý hàng kí gửi" bodyTitle="">
    <jsp:attribute name="extraBottomContent">
        <link href="assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
        <link href="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.css" rel="stylesheet">
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <div class="sidebar col-md-3 col-sm-5">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="./consignment?advand-search"><i class="fa fa-angle-right"></i> Tìm kiếm</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="./consignment?accepted"><i class="fa fa-angle-right"></i> Yêu cầu đã duyệt</a>
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item clearfix dropdown active open">
                        <a><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix active">
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
            <!-- BEGIN CONTENT -->
            <c:set var="customer" value="${requestScope.customer}"></c:set>
            <c:set var="product" value="${requestScope.product}"></c:set>
                <div class="col-md-9">
                    <h4>Thông tin đăng kí đặt hàng</h4>
                    </br></br>
                    <div class="col-sm-6">
                        <h5>Thông tin người đặt hàng</h5>
                        </br>
                        <li>Họ tên : ${customer.fullName}</li>
                    <li>Địa chỉ : ${customer.address}</li>
                    <li>Số điện thoại : ${customer.phone}</li>
                    <li>Email : ${customer.email}</li>
                </div>
                <div class="col-sm-6">
                    <h5>Thông tin sản phẩm</h5>
                    </br>
                    <li>Tên sản phẩm : ${product.name}</li>
                    <li>Mã hàng kí gửi : ${requestScope.consignmentID}</li>
                    <li>Giá kí gửi : ${customer.consignedPrice}</li>
                    <li>Giá bán : ${customer.sellingPrice}</li>
                    <li>Ngày đặt hàng : ${customer.orderedDate}</li>
                </div>
            </div>
            <div class="col-md-8" style="height: 100px"></div>
            <div class="col-md-11" id="divPaymentForm">
                <form action="LoadCompleteOrder" method="POST">
                    <div class="col-sm-4">
                        <button class="btn btn-info" name="btnAction" value="cancel" type="submit" style="width: 205px">Quay lại</button>
                    </div>
                </form>
                <form action="LoadCompleteOrder" method="POST" onsubmit="return getPrice();">
                    <div class="col-sm-4">
                        <input type="hidden" name="consignmentID" value="${requestScope.consignmentID}">
                        <input id="txtSellingPrice"type="hidden" name="sellingPrice" value="">
                        <button class="btn btn-warning" name="btnAction" value="complete" type="submit" style="width: 205px">Điền giá bán</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</jsp:body>
</template:shopbasic>
<script>
    function getPrice(form) {
        var price = prompt("Vui lòng nhập giá đã bán của sản phẩm :");
        if (price < 0) {
            alert("Giá bán phải lớn hơn 0!");
            return false;
        } else if (isNaN(price)) {
            alert("Phải là số!")
            return false;
        } else {
            document.getElementById("txtSellingPrice").value = price;
            return true;
        }
    }
</script>