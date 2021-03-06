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
    </jsp:attribute>
    <jsp:body>      
        <div id="wrapper" style="width: 90%">
            <c:set var="categories" value="${requestScope.CATEGORY}"/>
            <div class="row margin-bottom-40" style="z-index: 5">          
                <div class="sidebar col-md-3 col-sm-5">  
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

                <div class="col-md-9 col-sm-7">
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
                                        <input required="true" name="key" type="text" placeholder="Tìm Kiếm" class="form-control">
                                        <span class="input-group-btn">
                                            <button  class="btn btn-primary" type="submit">Tìm Kiếm</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="row product-list">
                        <c:set var="data" value="${requestScope.DATA}"/>
                        <c:if test="${empty data}">
                            <h2>Không tìm thấy sản phẩm nào phù hợp</h2>
                        </c:if>
                        <c:if test="${not empty data}">
                            <c:forEach var="item" items="${data}">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="product-item" style="height:370px">
                                        <div class="pi-img-wrapper">
                                            <img src="${item.image}" class="imgCrop2">
                                        </div>
                                            <h3 style="height:73px">${item.name}</h3>
                                        <a href="ViewProductDetailServlet?productID=${item.productID}" class="btn btn-default add2cart">Xem Chi tiết</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <!-- PRODUCT ITEM START -->                  
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-4 items-info"></div>
                        <div class="col-md-8 col-sm-8">
                            <ul class="pagination pull-right">
                                <c:set var="end" value="${requestScope.NUMPAGE}"/>
                                <c:set var="pageNUm" value="${requestScope.PAGE}"/>
                                <c:if test="${not empty end and not empty pageNUm}">
                                    <c:forEach var="i" begin="1" end ="${end}">                                 
                                        <c:if test="${i == pageNUm}">
                                            <li><span>${i}</span></li>
                                                </c:if>
                                                <c:if test="${i != pageNUm}">
                                            <li>
                                                <a onclick="location.href = URL_add_parameter(location.href, 'page', '${i}');" href="#">${i}</a>
                                            </li>   
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                            </ul>
                        </div>                   
                    </div>
                </div>

            </div>
        </jsp:body>
    </template:shopbasic>