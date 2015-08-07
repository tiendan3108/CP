<template:shopbasic htmlTitle="Home" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
        <script type="text/javascript">
            jQuery(document).ready(function () {
                var modalObj = $('#messModal').modal(); // initialize
                modalObj.modal('show');
            });
        </script>
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
    </jsp:attribute>
    <jsp:body>
        <div id="wrapper" style="width: 90%">
            <c:set var="mess" value="${requestScope.ERROR}"/>
            <c:if test="${not empty mess}">
                <div class="modal face" id="messModal">   
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4>Message:</h4>
                            </div>
                            <div class="modal-body">
                                <h4>${mess}</h4>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="button" data-dismiss="modal">OK<i class="fa fa-check"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
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
                                        <option value="all">Tất cả</option>                    
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.categoryId}">${category.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <input required="true" name="key" type="text" placeholder="Tìm kiếm" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="submit">Tìm Kiếm</button>
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
                            <h2>Sản Phẩm Mới</h2>
                            <div class="owl-carousel owl-carousel4">
                                <c:forEach var="item" items="${data}">     
                                    <div>
                                        <div class="product-item" style="height: 350px">
                                            <div class="pi-img-wrapper">
                                                <img src='${item.image}' class="imgCrop">
                                            </div>
                                            <h3 style="color: black;height: 80px">${item.name}</h3>

                                            <c:url var="viewDetail" value = "ViewProductDetailServlet">
                                                <c:param name="productID" value="${item.productID}"/>
                                            </c:url>
                                            <a href="${viewDetail}" class="btn btn-default add2cart">Xem Chi tiết</a>
                                        </div>
                                    </div>
                                </c:forEach>    
                            </div>
                        </div>
                    </c:if>
                    <div class="row margin-bottom-40 " style="margin-top:50px">
                        <!-- BEGIN CONTENT -->
                        <h2>Sản Phẩm Nổi Bật</h2>
                        <div class="owl-carousel owl-carousel4">
                            <c:set var="seasonItems" value="${requestScope.SEASONDATA}"/>
                            <c:if test="${not empty seasonItems}">
                                <c:forEach items="${seasonItems}" var="seasonItem">
                                    <div class="product-item" style="height:350px">
                                        <div class="pi-img-wrapper">
                                            <img src="${seasonItem.image}" class="imgCrop">
                                        </div>
                                        <h3 style="color: black;height: 80px">${seasonItem.name}</h3>
                                        <c:url var="viewDetail2" value = "ViewProductDetailServlet">
                                            <c:param name="productID" value="${seasonItem.productID}"/>
                                        </c:url>
                                        <a href="${viewDetail2}" class="btn btn-default add2cart">Xem Chi tiết</a>
                                    </div>

                                </c:forEach>

                            </c:if>
                        </div>
                        <!-- END CONTENT -->
                    </div>

                </div>
                <!-- END SALE PRODUCT -->        
            </div>
        </div>

    </jsp:body>
</template:shopbasic>