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
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-4">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix"><a href="showProduct.html"><i class="fa fa-angle-right"></i> Ladies</a></li>
                    <li class="list-group-item clearfix dropdown">
                        <a href="#">
                            <i class="fa fa-angle-right"></i>
                            Mens               
                        </a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item dropdown clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i> Shoes </a>
                            </li>
                            <li><a href="shop-product-list.html"><i class="fa fa-angle-right"></i> Trainers</a></li>
                            <li><a href="shop-product-list.html"><i class="fa fa-angle-right"></i> Jeans</a></li>
                            <li><a href="shop-product-list.html"><i class="fa fa-angle-right"></i> Chinos</a></li>
                            <li><a href="shop-product-list.html"><i class="fa fa-angle-right"></i> T-Shirts</a></li>
                        </ul>
                    </li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i> Kids</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i> Sports</a></li>
                    <li class="list-group-item clearfix"><a href="#"><i class="fa fa-angle-right"></i> Brands</a></li>
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
                                <div class="price-availability-block clearfix">
                                    <div class="price">
                                        <strong><span>$</span>${item.price}</strong>
                                    </div>
                                </div>
                                <div class="description">
                                    <p>${item.description}</p>
                                </div>
                                <div class="product-page-options">
                                    <div class="pull-left">
                                        <label class="control-label">Size: L</label>
                                    </div>
                                    <div class="pull-left">
                                        <label class="control-label">Color: Red</label>
                                    </div>
                                </div>
                                <div class="product-page-cart">
                                    <div class="product-quantity">

                                    </div>
                                    <button class="btn btn-primary" type="submit">Add to cart</button>
                                </div>

                                <div class="sticker sticker-sale"></div>
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
                    <h2>Similar Products</h2>
                    <div class="owl-carousel owl-carousel4">
                        <c:if test="${not empty similarProducts}">
                            <c:forEach var="productItem" items="${similarProducts}">
                                <div>
                                    <div class="product-item">
                                        <div class="pi-img-wrapper">
                                            <img src='${productItem.image}' class="imgCrop3">
                                        </div>
                                        <h3>${productItem.name}</h3>
                                        <div class="pi-price">${productItem.price}</div>
                                        <c:url var="viewDetail" value = "ProcessServlet">
                                            <c:param name="action" value="viewDetail" />
                                            <c:param name="productID" value="${productItem.productID}"/>
                                        </c:url>
                                        <a href="${viewDetail}" class="btn btn-default add2cart">View Details</a>
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
