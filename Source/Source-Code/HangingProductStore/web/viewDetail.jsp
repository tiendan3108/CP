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
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
    </jsp:attribute>
    <jsp:body>  
        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
        <div id="wrapper" style="width: 90%">
            <!-- BEGIN SIDEBAR & CONTENT -->
            <div class="row margin-bottom-40">
                <!-- BEGIN SIDEBAR -->
                <div class="sidebar col-md-3 col-sm-4">
                    <c:if test="${empty account || account.role == 'member'}">
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
                    </c:if>
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
                                            <label style="font-size: 14px;" class="control-label">Tình trạng: mới ${item.newStatus}%</label>
                                        </div>
                                        <div class="pull-left">
                                            <label style="font-size: 14px;" class="control-label">Nhãn hiệu: ${item.brand}</label>
                                        </div>
                                        <c:if test="${not empty item.serialNumber}">
                                            <div class="pull-left">
                                                <label style="font-size: 14px;" class="control-label">Số Serial: ${item.serialNumber}</label>
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:set var="store" value="${requestScope.STOREINFO}"/>
                                    <c:if test="${not empty store}">
                                        <div class="description">
                                            <p><label style="font-size: 14px;" class="control-label">Thông tin liên hệ</label></p>
                                            <p>Tên chủ cửa hàng: ${store.fullName}</p>
                                            <p>Email: ${store.email}</p> 
                                            <p>Số điện thoại: ${store.phone}</p> 
                                            <p>Địa chỉ: ${store.address}</p> 
                                        </div>  
                                    </c:if>                                  
                                    <c:if test="${empty account || account.role == 'member'}">
                                        <div class="product-page-options">
                                            <div class="pull-left">
                                                <a class="btn btn-primary" href="ConfirmOrderServlet?productId=${item.productID}">Đặt hàng</a>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- END CONTENT -->
                </div>
                <!-- END SIDEBAR & CONTENT -->

                <!-- BEGIN SIMILAR PRODUCTS -->
                <c:if test="${empty account || account.role == 'member'}">
                    <c:set var="similarProducts" value="${requestScope.SIMILARPRODUCT}"/>
                    <div class="row margin-bottom-40" style="margin-top: 600px">
                        <div class="col-md-12 col-sm-12" style="margin-left: 20px">
                            <h2>Sản phẩm tương tự</h2>
                            <div class="owl-carousel owl-carousel4">
                                <c:if test="${not empty similarProducts}">
                                    <c:forEach var="productItem" items="${similarProducts}">
                                        <div>
                                            <div class="product-item">
                                                <div class="pi-img-wrapper">
                                                    <img src='${productItem.image}' class="imgCrop3">
                                                </div>
                                                <h3 style="color: black;height:90px">${productItem.name}</h3>

                                                <c:url var="viewDetail" value = "ViewProductDetailServlet">
                                                    <c:param name="productID" value="${productItem.productID}"/>
                                                </c:url>
                                                <a href="${viewDetail}" class="btn btn-default add2cart">Xem Chi Tiết</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>                   
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- END SIMILAR PRODUCTS -->
            </div>
        </div>
    </jsp:body>
</template:shopbasic>
