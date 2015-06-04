<%-- 
    Document   : product
    Created on : Jun 3, 2015, 3:36:03 PM
    Author     : HoangNHSE61007
--%>

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
                <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                <li style="margin-left: -40px"><a href="#">notification 4</a></li>
            </ul>
        </li>
    </jsp:attribute>
    <jsp:body>      
        <c:set var="categories" value="${requestScope.CATEGORY}"/>
        <div class="row margin-bottom-40" style="z-index: 5">          
            <div class="sidebar col-md-3 col-sm-5">  
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a href="#"><i class="fa fa-angle-right"></i>Men</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item dropdown clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Shoes</a>
                            </li>                                               
                        </ul>
                    </li>
                </ul>
                <div class="sidebar-products clearfix">
                    <h2>Bestsellers</h2>
                    <div class="item">
                        <a href="shop-item.html"><img src="assets/frontend/pages/img/products/k1.jpg" alt="Some Shoes in Animal with Cut Out"></a>
                        <h3><a href="shop-item.html">Some Shoes in Animal with Cut Out</a></h3>
                        <div class="price">$31.00</div>
                    </div>
                    <div class="item">
                        <a href="shop-item.html"><img src="assets/frontend/pages/img/products/k4.jpg" alt="Some Shoes in Animal with Cut Out"></a>
                        <h3><a href="shop-item.html">Some Shoes in Animal with Cut Out</a></h3>
                        <div class="price">$23.00</div>
                    </div>
                    <div class="item">
                        <a href="shop-item.html"><img src="assets/frontend/pages/img/products/k3.jpg" alt="Some Shoes in Animal with Cut Out"></a>
                        <h3><a href="shop-item.html">Some Shoes in Animal with Cut Out</a></h3>
                        <div class="price">$86.00</div>
                    </div>
                </div>
            </div>

            <div class="col-md-9 col-sm-7">
                <div class="content-search margin-bottom-20"> 
                    <form action="Test">
                        <div class="row">
                            <div class="col-md-4">
                                <select name="select" class="bs-select form-control input-small" data-style="blue">
                                    <option value="all">All</option>                    
                                    <c:forEach var="category" items="${categories}">
                                        <option value="123">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-8">

                                <div class="input-group">
                                    <input type="text" placeholder="Search" class="form-control">
                                    <span class="input-group-btn">
                                        <button name="action" value="123" class="btn btn-primary" type="submit">Search</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="row product-list">
                    <!-- PRODUCT ITEM START -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/nike_air_jordan_4_retro_2013110110_0.jpg" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Nike</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>
                    <!-- PRODUCT ITEM END -->
                    <!-- PRODUCT ITEM START -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Casio</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>
                    <!-- PRODUCT ITEM END -->
                    <!-- PRODUCT ITEM START -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Casio</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>              
                    <!-- PRODUCT ITEM END -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Casio</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>  
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Casio</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>  
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="product-item">
                            <div class="pi-img-wrapper">
                                <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop2">
                            </div>
                            <h3><a href="shop-item.html">Casio</a></h3>
                            <div class="pi-price">$29.00</div>
                            <a href="#" class="btn btn-default add2cart">View Details</a>
                        </div>
                    </div>  
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4 items-info"></div>
                    <div class="col-md-8 col-sm-8">
                        <ul class="pagination pull-right">
                            <li><a href="#">&laquo;</a></li>
                            <li><a href="product.jsp">1</a></li>
                            <li><span>2</span></li>
                            <li><a href="#">3</a></li>
                            <li><a href="product.jsp">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
            </div>


        </jsp:body>
    </template:shopbasic>