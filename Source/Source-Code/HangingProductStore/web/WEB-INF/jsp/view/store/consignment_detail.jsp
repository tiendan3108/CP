<template:shopbasic htmlTitle="${consignment.product.name}" bodyTitle="">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
        <!-- BEGIN SIDEBAR -->
        <div class="sidebar col-md-3 col-sm-4">
            <ul class="list-group margin-bottom-25 sidebar-menu">
                <li class="list-group-item clearfix">
                    <a href="./consignment?search"><i class="fa fa-angle-right"></i> Search</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?request"><i class="fa fa-angle-right"></i> Request List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?imported"><i class="fa fa-angle-right"></i> Imported List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?sold"><i class="fa fa-angle-right"></i> Sold List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <c:if test="${not empty alert}">
                <div class="alert alert-${alert.type.name} alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                    <strong>${alert.title}</strong> ${alert.body}
                </div>
            </c:if>

            <h1>${consignment.product.name}&nbsp;<small>từ khách hàng</small> ${consignment.name}</h1>

            <!-- BEGIN PAGE CONTENT-->
            <div class="row margin-bottom-25">
                <!-- BEGIN CAROUSEL -->
                <div class="col-lg-4 col-md-4 front-carousel">

                    <div class="carousel slide" id="myCarousel">
                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt="" src="./assets/product/1.jpg">
                                <div class="carousel-caption">
                                    <p>Mặt trước như mới</p>
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
                    <table class="table">
                        <tr>
                            <th width="120px">Tên Sản Phẩm</th>
                            <td>${consignment.product.name}</td>
                        </tr>
                        <tr>
                            <th>Mô Tả</th>
                            <td>${consignment.product.description}</td>
                        </tr>
                        <tr>
                            <th>Ngày Gửi</th>
                            <td>${consignment.createdDate}</td>
                        </tr>
                        <tr>
                            <th>Giá</th>
                            <td><fmt:formatNumber type="currency" currencySymbol="VNĐ" value="${consignment.maxPrice}" maxFractionDigits="0" /></td>
                        </tr>
                        <tr>
                            <th>Ngày Giao</th>
                            <td>${consignment.fromDate} - ${consignment.toDate}</td>
                        </tr>
                        <tr>
                            <th>Trạng Thái</th>
                            <td>
                                <c:choose>
                                    <c:when test="${consignment.consignmentStatusID == 1}">
                                        Chờ xử lý
                                    </c:when>
                                    <c:when test="${consignment.consignmentStatusID == 2}">
                                        Đã từ chối
                                    </c:when>
                                    <c:when test="${consignment.consignmentStatusID == 3}">
                                        Đã chấp nhận
                                    </c:when>
                                    <c:when test="${consignment.consignmentStatusID == 4}">
                                        Hoàng thành
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <a class="btn btn-primary"
                                   data-toggle="modal"
                                   href="#acceptingModal">Chấp Nhận</a>
                                <a class="btn btn-info"
                                   data-toggle="modal"
                                   href="#refusingModal">Từ Chối</a>
                            </td>
                        </tr>
                    </table>

                </div>
                <!-- END PRODUCT DESCRIPTION -->
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="well">
                        <h4 class="form-section">${consignment.name}</h4>
                        <address>
                            <strong>${consignment.address}</strong><br>
                            <abbr title="Phone">P:</abbr> ${consignment.phone}</address>
                        <address>
                            <strong>Email</strong><br>
                            <a href="mailto:${consignment.email}">${consignment.email}</a>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->

    <!-- Appointment Modal BEGIN -->
    <div class="modal face" id="appointmentModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4>Hẹn Ngày Lấy</h4>
                </div>
                <div class="modal-body">
                    <p>${consignment.name} có thể giao hàng từ
                        ${consignment.fromDate} đến ${consignment.toDate}.</p>
                    <form class="form-horizontal">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Ngày Lấy Hàng</label>
                                <div class="col-md-9">
                                    <input class="form-control" type="date" value="">
                                </div>
                            </div>
                        </div>
                        <div class="form-action right">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="accept">Đặt Lịch Hẹn</button>
                        <button type="button" class="btn default" data-dismiss="modal">Đóng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Appointment Modal END -->

    <!-- Accepting Modal BEGIN -->
    <div class="modal face" id="acceptingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4>Chấp Nhận Ký Gửi</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Giá</label>
                                <div class="col-md-9">
                                    <input class="form-control" type="number" value="${consignment.maxPrice}"
                                           <c:if test="${not empty consignment.maxPrice}">disabled=""</c:if>>
                                    </div>
                                </div>
                            </div>
                            <div class="form-action right">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="accept">Chấp Nhận</button>
                        <button type="button" class="btn default" data-dismiss="modal">Đóng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Accepting Modal END -->

    <!-- Refusing Modal BEGIN -->
    <div class="modal face" id="refusingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Từ Chối Ký Gửi</h4>
                </div>
                <div class="modal-body">
                    Bạn muốn từ chối ký gửi?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="refuse">Từ Chối</button>
                        <button class="btn default" type="button" data-dismiss="modal">Đóng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Refusing Modal END -->

    <!-- Importing Modal BEGIN -->
    <div class="modal face" id="importingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Product Importing</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to import this product?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="import">Import</button>
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Importing Modal END -->

    <!-- Deleting Modal BEGIN -->
    <div class="modal face" id="deletingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Deleting</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="delete">Delete</button>
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Deleting Modal END -->

    <!-- Contact Modal BEGIN -->
    <div class="modal face" id="contactModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Contact</h4>
                </div>
                <div class="modal-body">
                    <h3 class="form-section">${consignment.name}</h3>
                    <div class="well">
                        <h4>Address</h4>
                        <address>
                            <strong>${consignment.address}</strong><br>
                            <abbr title="Phone">P:</abbr> ${consignment.phone}</address>
                        <address>
                            <strong>Email</strong><br>
                            <a href="mailto:#">${consignment.email}</a>
                        </address>
                    </div>
                    <div class="modal-footer">
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact Modal END -->
    </template:shopbasic>