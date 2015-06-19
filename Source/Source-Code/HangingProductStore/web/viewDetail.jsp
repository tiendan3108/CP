<%-- 
    Document   : viewDetail
    Created on : May 29, 2015, 3:18:21 PM
    Author     : HoangNHSE61007
--%>

<template:shopbasic htmlTitle="Home" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <script src='assets/global/plugins/zoom/jquery.zoom.min.js' type="text/javascript"></script>
        <script type="text/javascript">
            jQuery(document).ready(function () {
                Layout.initImageZoom();
            });
        </script>
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <c:if test="${acc.role == 'member'}">
                <li><a href="ConsignServlet">Kí Gửi</a></li>
                <li id="nofi">
                    <a href="#">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default">3</span>           
                    </a>
                    <ul class="fallback">
                        <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                    </ul>
                </li>
            </c:if>
        </c:if>
        <c:if test="${empty acc}">
            <li><a href="ConsignServlet">Kí Gửi</a></li>
            </c:if>
    </jsp:attribute>
    <jsp:body>             
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-4">
                <c:set var="categories" value="${requestScope.CATEGORY}"/>
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <c:forEach var="category" items="${categories}">
                        <li class="list-group-item clearfix dropdown">
                            <a><i class="fa fa-angle-right"></i>${category.categoryName}</a>
                            <ul class="dropdown-menu">                             
                                <c:set var="allCate" value="${requestScope.ALLCATE}"/>
                                <c:forEach var="childCate" items="${allCate}">
                                    <c:if test="${category.categoryId == childCate.parentId}">
                                        <li>
                                            <a href="ProductServlet?categoryId=${childCate.categoryId}"><i class="fa fa-angle-right"></i>${childCate.categoryName}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>       
                            </ul>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- END SIDEBAR -->

            <!-- BEGIN CONTENT -->
            <div class="col-md-9 col-sm-7">
                <c:set var="item" value="${requestScope.PRODUCT}"/>
                <c:if test="${not empty item}">
                    <div class="product-page">
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="product-main-image">
                                    <img src="${item.image}" class="img-responsive" data-BigImgsrc="${item.image}">
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <h1>${item.name}</h1>

                                <div class="description">
                                    <p>${item.description}</p>
                                </div>
                                <div class="product-page-options">
                                    <div class="pull-left">
                                        <label style="font-size: 20px;" class="control-label">Nhãn hiệu: ${item.brand}</label>
                                    </div>

                                </div>
                                <div class="product-page-options">
                                    <div class="pull-left">
                                        <label style="font-size: 20px;" class="control-label">Số Serial: ${item.serialNumber}</label>
                                    </div>
                                </div>                             
                                <div class="product-page-cart">
                                    <div class="product-quantity">

                                    </div>
                                    <a class="btn btn-primary" href="ConfirmOrderServlet?productId=${item.productID}">Đặt hàng</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- END CONTENT -->
            </div>
            <!-- END SIDEBAR & CONTENT -->

            <!-- BEGIN SIMILAR PRODUCTS -->
            <c:set var="similarProducts" value="${requestScope.SIMILARPRODUCT}"/>
            <div class="row margin-bottom-40" style="margin-top: 500px">
                <div class="col-md-12 col-sm-12">
                    <h2>Sản phẩm tương tự</h2>
                    <div class="owl-carousel owl-carousel4">
                        <c:if test="${not empty similarProducts}">
                            <c:forEach var="productItem" items="${similarProducts}">
                                <div>
                                    <div class="product-item">
                                        <div class="pi-img-wrapper">
                                            <img src='${productItem.image}' class="imgCrop3">
                                        </div>
                                        <h3>${productItem.name}</h3>

                                        <c:url var="viewDetail" value = "ViewProductDetailServlet">
                                            <c:param name="productID" value="${productItem.productID}"/>
                                        </c:url>
                                        <a href="${viewDetail}" class="btn btn-default add2cart">Xem Chi Tiết</a>
                                        <div class="sticker sticker-new"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>                   
                    </div>
                </div>
            </div>
            <!-- END SIMILAR PRODUCTS -->
        </div>
    </jsp:body>
</template:shopbasic>
