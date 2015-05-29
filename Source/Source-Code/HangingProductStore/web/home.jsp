<template:shopbasic htmlTitle="Home" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
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

        <div class="row margin-bottom-40" style="z-index: 5">
            <c:set var="data" value="${requestScope.DATA}"/>
            <!-- BEGIN SALE PRODUCT -->
            <c:if test="${not empty data}">
                <div class="col-md-12 sale-product">
                    <h2>New Arrivals</h2>
                    <div class="owl-carousel owl-carousel5">
                        <c:forEach var="item" items="${data}">     
                            <div>
                                <div class="product-item">
                                    <div class="pi-img-wrapper">
                                        <img src='${item.image}' class="imgCrop">
                                    </div>
                                    <h3>${item.name}</h3>
                                    <div class="pi-price">$ ${item.price}</div>
                                    <a href="productDetail.html" class="btn btn-default add2cart">View Detail</a>
                                    <div class="sticker sticker-new"></div>
                                </div>
                            </div>
                        </c:forEach>    
                    </div>
                </div>
            </c:if>
            <!-- END SALE PRODUCT -->        
        </div>
        <div class="content-search margin-bottom-20">
            <div class="row">
                <div class="col-md-3">
                    <select class="bs-select form-control input-small" data-style="blue">
                        <option>All</option>
                        <option>Ladies</option>
                        <option>Mens</option>
                        <option>Kids</option>
                        <option>Sports</option>
                        <option>Brand</option>
                    </select>
                </div>
                <div class="col-md-7">
                    <form action="#">
                        <div class="input-group">
                            <input type="text" placeholder="Search" class="form-control">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="submit">Search</button>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="row margin-bottom-40 ">
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
            <div class="col-md-9 col-sm-8">
                <h2>SAVE ITEMS</h2>
                <div class="owl-carousel owl-carousel3">
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k1.jpg" class="img-responsive" alt="Berry Lace Dress"> 
                            </div>
                            <h3><a href="shop-item.html">Berry Lace Dress</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                            <div class="sticker sticker-new"></div>
                        </div>
                    </div>
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k2.jpg" class="img-responsive" alt="Berry Lace Dress">
                            </div>
                            <h3>Berry Lace Dress2</h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                        </div>
                    </div>
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k3.jpg" class="img-responsive" alt="Berry Lace Dress">
                            </div>
                            <h3>Berry Lace Dress3</h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                        </div>
                    </div>
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k4.jpg" class="img-responsive" alt="Berry Lace Dress">
                            </div>
                            <h3>Berry Lace Dress4</h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                            <div class="sticker sticker-sale"></div>
                        </div>
                    </div>
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k1.jpg" class="img-responsive" alt="Berry Lace Dress">
                            </div>
                            <h3>Berry Lace Dress5</h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                        </div>
                    </div>
                    <div>
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/frontend/pages/img/products/k2.jpg" class="img-responsive" alt="Berry Lace Dress">
                            </div>
                            <h3>Berry Lace Dress6</h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Detail</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>       
    </jsp:body>
</template:shopbasic>