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
            <div class="sidebar col-md-3 col-sm-4">   
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

            <div class="col-md-9 col-sm-8 sale-product">
                <div class="content-search margin-bottom-20"> 
                    <form action="ProductServlet">
                        <div class="row">
                            <div class="col-md-4">
                                <select name="parentId" class="bs-select form-control input-small" data-style="blue">
                                    <option value="all">All</option>                    
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <input required="true" name="key" type="text" placeholder="Search" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <c:set var="data" value="${requestScope.DATA}"/>
                <!-- BEGIN SALE PRODUCT -->
                <c:if test="${not empty data}">
                    <div class="row">
                        <h2>New Arrivals</h2>
                        <div class="owl-carousel owl-carousel4">
                            <c:forEach var="item" items="${data}">     
                                <div>
                                    <div class="product-item">
                                        <div class="pi-img-wrapper">
                                            <img src='${item.image}' class="imgCrop">
                                        </div>
                                        <h3>${item.name}</h3>

                                        <c:url var="viewDetail" value = "ViewProductDetailServlet">
                                            <c:param name="productID" value="${item.productID}"/>
                                        </c:url>
                                        <a href="${viewDetail}" class="btn btn-default add2cart">View Detail</a>
                                        <div class="sticker sticker-new"></div>
                                    </div>
                                </div>
                            </c:forEach>    
                        </div>
                    </div>
                </c:if>
                <div class="row margin-bottom-40 " style="margin-top:50px">
                    <!-- BEGIN CONTENT -->
                    <h2>HOT ITEMS</h2>
                    <div class="owl-carousel owl-carousel3">
                        <div>
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop3">
                                </div>
                                <h3>Casio Gshock</h3>
                                <a href="#" class="btn btn-default add2cart">View Detail</a>
                            </div>
                        </div>
                        <div>
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop3">
                                </div>
                                <h3>Casio Gshock</h3>
                                <a href="#" class="btn btn-default add2cart">View Detail</a>
                            </div>
                        </div>
                        <div>
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop3">
                                </div>
                                <h3>Casio Gshock</h3>
                                <a href="#" class="btn btn-default add2cart">View Detail</a>
                            </div>
                        </div>
                        <div>
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop3">
                                </div>
                                <h3>Casio Gshock</h3>
                                <a href="#" class="btn btn-default add2cart">View Detail</a>
                            </div>
                        </div>
                        <div>
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <img src="assets/image/GA110AC-7A_xlarge.png" class="imgCrop3">
                                </div>
                                <h3>Casio Gshock</h3>
                                <a href="#" class="btn btn-default add2cart">View Detail</a>
                            </div>
                        </div>
                    </div>
                    <!-- END CONTENT -->
                </div>

            </div>
            <!-- END SALE PRODUCT -->        
        </div>


    </jsp:body>
</template:shopbasic>