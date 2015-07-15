<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Thống kê doanh số" bodyTitle="">
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
                    <ul class="list-group sidebar-menu">
                        <li class="list-group-item clearfix dropdown">
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
                <!-- BEGIN RIGHT CONTENT -->
                <div class="col-md-9 col-sm-8">
                    <!-- BEGIN TAB -->
                    <div class="tabs row">
                        <!-- BEGIN TAB LINK -->
                        <ul class=" nav nav-tabs nav-justified">
                            <li id="consignmentTab"><a href="#consignment">Yêu cầu kí gửi</a></li>
                            <li id="productTab"><a href="#product">Sản phẩm kí gửi</a></li>
                        </ul>
                        <!-- END TAB LINK -->
                        <!-- BEGIN TAB CONTENT -->
                        <div class="tab-content col-md-12">
                            <input type="hidden" id="currentTab" value="${requestScope.currentTab}"/>
                            <c:set var="result" value="${requestScope.result}">
                            </c:set>
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr role="row" class="heading">
                                        <th>STT</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Tên khách hàng</th>
                                        <th>Ngày nhận</th>
                                        <th>Giá thương lượng</th>
                                        <th>Giá bán</th>
                                        <th>Giá trả khách hàng</th>
                                        <th>Phí</th>
                                        <th>Lợi nhuận</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${result}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${item.productName}</td>
                                            <td>${item.consignorName}</td>
                                            <td>${item.receivedDate}</td>
                                            <td><fmt:formatNumber value="${item.consignPrice}" maxFractionDigits="1"/></td>
                                            <td><c:if test="${item.sellingPrice>0}"><fmt:formatNumber value="${item.sellingPrice}" maxFractionDigits="1"/></c:if></td>
                                            <td><c:if test="${item.returnPrice>0}"><fmt:formatNumber value="${item.returnPrice}" maxFractionDigits="1"/></c:if></td>
                                            <td><c:if test="${item.fee>0}"><fmt:formatNumber value="${item.fee}" maxFractionDigits="1"/></c:if></td>
                                            <td><fmt:formatNumber value="${item.revenue}" maxFractionDigits="1"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            Tổng lợi nhuận <label ><fmt:formatNumber value="${requestScope.totalPrice}" maxFractionDigits="1"/></label>
                        </div>
                        <!-- END TAB CONTENT -->
                    </div>
                    <!-- END TAB -->
                    <!-- END TAB CONTENT -->
                </div>
                <!-- END RIGHT CONTENT -->                                            
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
            e.preventDefault();
        });
    });
    $(document).ready(function () {
        var currentTab = $('#currentTab').val();
        var currentLi = currentTab + 'Tab';
        $('div#' + currentTab).fadeIn(400).siblings().hide();
        $('li#' + currentLi).parent('ul').siblings().children('li').removeClass('active');
        $('li#' + currentLi).addClass('active').siblings().removeClass('active');
    });
</script>