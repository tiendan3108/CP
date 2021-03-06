<%-- 
    Document   : trackProductStatus_Guest
    Created on : Jun 17, 2015, 4:06:37 AM
    Author     : Robingios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý ký gửi" bodyTitle="">
    <jsp:attribute name="extraHeadContent">

    </style>
</jsp:attribute>
<jsp:attribute name="extraNavigationContent">

</jsp:attribute>

<jsp:attribute name="extraBottomContent">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
</jsp:attribute>
<jsp:body>
    <div id="wrapper">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1">
                <div class="row">

                    <form class="form-horizontal" role="form" action="TrackProductStatus">
                        <div class="form-body">

                            <div class="form-group">
                                <div class="col-md-6 col-sm-8 col-md-offset-3 col-sm-offset-2">
                                    <div class="input-group">
                                        <input id="searchInput" class="form-control" type="text" name="searchValue" value="${param.searchValue}" placeholder="Điền CODE">
                                        <span class="input-group-btn">
                                            <button class="btn btn-info" type="submit" name="btnAction" value="search">Kiểm tra</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <br/><br/>
                    <c:if test="${empty CONSIGNMENT}">
                        <c:if test="${not empty param.searchValue}">
                            <h2 align="center">Sản phẩm với code này không tồn tại.</h2>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty CONSIGNMENT}">
                        <c:set var="c" value="${CONSIGNMENT}"/>

                        <!-- BEGIN PAGE CONTENT-->
                        <div class="row margin-bottom-25" style="background-color: white">
                            <!-- BEGIN CAROUSEL -->
                            <h2 class="modal-title"> <small> Từ khách hàng </small> ${c.name}</h2>
                            <div class="row">
                                <div class="col-lg-3 col-md-3"><b>ĐT: </b><span  id="r_phone">${c.phone}</span></div>
                                <div class="col-lg-6 col-md-6"><b>Email: </b><span  id="r_email">${c.email}</span></div>

                            </div>
                            <div class="row">
                                <div class="col-lg-12 col-md-12 "><b>Địa chỉ: </b><span id="r_address">${c.address}</span></div></div>

                            <br/>
                            <div class="col-lg-4 col-md-4 front-carousel">

                                <div class="carousel slide" id="myCarousel">
                                    <!-- Carousel items -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <img id="r_image" alt="${c.product.name}" src="${c.product.image}" style="max-height: 400px">
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
                                <table style="font-size: 110%; border: none" class="table table-hover">
                                    <tr>
                                        <th width="30%">Tên sản phẩm</th>
                                        <td id='r_productName'><b>${c.product.name}</b></td>
                                    </tr>
                                    <tr>
                                        <th width="30%">Độ mới</th>
                                        <td id='r_description'>${c.product.newStatus}%</td>
                                    </tr>
                                    <tr>
                                        <th>Cửa hàng ký gửi</th>
                                        <td id='r_createdDate'><b>${c.storeOwner.fullName}</b></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày ký gửi</th>
                                        <td id='r_createdDate'>${c.createdDate}</td>
                                    </tr>
                                    <tr>
                                        <c:choose>

                                            <c:when test="${c.negotiatedPrice > 0}">
                                                <th>Giá thỏa thuận</th>
                                                <td>
                                                    <fmt:formatNumber type="number"
                                                                      value="${c.negotiatedPrice}" 
                                                                      maxFractionDigits="0"/>&nbsp;(Ngàn đồng)
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <th>Giá mong muốn</th>
                                                <td>
                                                    <fmt:formatNumber type="number"
                                                                      value="${c.desirePrice}" 
                                                                      maxFractionDigits="0"/> (Ngàn đồng)
                                                </td> 
                                            </c:otherwise>




                                        </c:choose>
                                    </tr>
                                    <th>Trạng thái</th>
                                    <td id='r_status'> <b>

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
                                                    <font color="purple">ĐÃ HẾT HẠN</font>
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
                                                            <font color="orange">ĐĂNG KÝ HỦY</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 7}">
                                                            <font color="blue">ĐÃ HOÀN THÀNH</font>
                                                        </c:when>
                                                        <c:when test="${c.product.productStatusID == 8}">
                                                            <font color="purple">CHỜ TRẢ HÀNG</font>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>

                                        </b>
                                    </td>
                                    </tr>
                                    <c:if test="${c.consignmentStatusID == 2}">
                                        <tr>
                                            <th>Lí do</th>
                                            <td>
                                                ${c.reason}
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${c.product.productStatusID != 6}">
                                        <c:choose>
                                            <c:when test="${c.consignmentStatusID == 1 or c.consignmentStatusID == 3}">
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <button type="button" class="btn btn-warning btn-lg" data-toggle="modal" data-target="#modalCancel">
                                                            HỦY KÝ GỬI
                                                        </button> 
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:when test="${c.consignmentStatusID == 5}">

                                                <c:if test="${c.product.productStatusID == 2 or c.product.productStatusID == 3}">
                                                    <tr>
                                                        <td></td>
                                                        <td>
                                                            <button type="button" class="btn btn-warning btn-lg" data-toggle="modal" data-target="#modalCancel">
                                                                HỦY KÝ GỬI
                                                            </button> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>
                                                            
                                                        </td>
                                                    </tr>
                                                </c:if>

                                            </c:when>
                                            <c:when test="${c.consignmentStatusID == 6}">
                                                <!--                                                <tr>
                                                                                                    <td>
                                                                                                        <button type="button"  class="btn btn-info btn-lg" data-toggle="modal" data-target="#modalExtend">
                                                                                                            GIA HẠN
                                                                                                        </button> 
                                                                                                    </td>
                                                                                                </tr>-->
                                            </c:when>
                                        </c:choose>
                                    </c:if>

                                </table>

                            </div>
                            <!-- END PRODUCT DESCRIPTION -->
                        </div>


                        <!-- Begin Modal -->
                        <div id="modalCancel" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header" style="background-color: #dfba49">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Lưu ý</h4>
                                    </div>
                                    <div class="modal-body">
                                        <h2 id="r_message" align="center">Bạn có chắc chắn muốn hủy ký gửi này không?</h2>
                                        <c:if test="${c.consignmentStatusID == 5}">
                                            <c:if test="${c.product.productStatusID == 2 or c.product.productStatusID == 3}">
                                                <h2 id="ar_message" align="center">Bạn sẽ chịu một khoản tiền phạt cho việc này.</h2>
                                            </c:if>

                                        </c:if>
                                    </div>
                                    <div class="modal-footer">
                                        <form action="TrackProductStatus" method="POST">
                                            <button type="submit" name="btnAction" class="btn btn-warning" value="cancel">Đồng ý</button>
                                            <input type="hidden" name="consignmentID" value="${c.consigmentID}"/>
                                            <input type="hidden" name="searchValue" value="${param.searchValue}"/>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </form>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->
                        
                        <!-- Begin Modal -->
                        <div id="modalError" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header" style="background-color: #dfba49">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Thông báo</h4>
                                    </div>
                                    <div class="modal-body">
                                        <h2 id="errorMessage" align="center">${ERROR}</h2>
                                    </div>
                                    <div class="modal-footer">    
                                            <button type="button" class="btn btn-warning" data-dismiss="modal">Đóng</button>                                    
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->

                        <c:if test="${c.consignmentStatusID == 6}">
                            <!-- Begin Modal -->


                            <!--                            <div id="modalExtend" class="modal fade">
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                        <h4 class="modal-title">Gia hạn</h4>
                                                                    </div>
                                                                    <div class="modal-body" align="center">
                                                                        <h3>Bạn có chắc muốn gia hạn không?</h3>
                                                                        <h3>Bạn đã quá hạn <b>${requestScope.overDate}</b> ngày và phải chịu phạt <b>${requestScope.extraPayment} ngàn đồng.</b></h3>
                                                                        
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <form action="TrackProductStatus" method="POST">
                                                                            <button type="submit" name="btnAction" class="btn btn-info" value="extend">Đồng ý</button>
                                                                            <input type="hidden" name="consignmentID" value="${param.searchValue}"/>
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                                                        </form>
                                                                    </div>
                                                                </div> /.modal-content 
                                                            </div> /.modal-dialog 
                                                        </div> /.modal -->
                        </c:if>
                    </c:if>
                </div>


            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</jsp:body>
</template:shopbasic>

<script type="text/javascript">
$(document).ready(function () {
    if($("#errorMessage").text().length > 0){
        $("#modalError").modal("show");
    }
});
</script> 
