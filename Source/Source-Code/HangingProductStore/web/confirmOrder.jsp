<%-- 
    Document   : completeOrder
    Created on : Jun 11, 2015, 2:56:43 PM
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
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <c:if test="${acc.role == 'member'}">
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
        </jsp:attribute>
        <jsp:body> 
        <div id="wrapper">
            <div class="row margin-bottom-40">
                <h4>Bạn đã đặt món hàng:</h4>
                <div class="content-form-page">                  
                    <div class="table-wrapper-responsive ">
                        <div class="goods-data clearfix ">
                            <c:set var="item" value="${requestScope.DATA}"/>
                            <c:if test="${not empty item}">
                                <div class="table-wrapper-responsive">
                                    <table summary="Shopping cart">
                                        <tr>
                                            <th>Tên</th>
                                            <th>Nhãn hiệu</th>                               
                                            <th>Số Serial</th>
                                        </tr>
                                        <tr>
                                            <td>${item.name}</td>
                                            <td><h3>${item.brand}</h3></td>
                                            <td>${item.serialNumber}</td>
                                        </tr>                                
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>  
                <h4 style="margin-top: 20px">Vui lòng nhập thông tin để chúng tôi liên lạc với bạn:</h4>
                <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
                <div class="col-md-12">
                    <form class="form-horizontal form-without-legend" action="CompleteOrderServlet">
                        <input name="productID" value="${item.productID}" hidden="true">
                        <c:if test="${not empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Tên</span></label>
                                <div class="col-lg-3 col-md-4">
                                    <input value="${acc.fullName}" name="name" type="text" id="first-name" class="form-control">
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Email <span class="require">*</span></label>
                                <div class="col-md-4 col-lg-4">
                                    <input value="${acc.email}" name="email" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Địa chỉ</label>
                                <div class="col-lg-3 col-md-4">
                                    <textarea  rows="3" name="address" type="text" class="form-control">${acc.address}</textarea>
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Sồ điện thoại <span class="require">*</span></label>
                                <div class="col-md-3">
                                    <input value="${acc.phone}" name="phone" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Tên</span></label>
                                <div class="col-lg-3 col-md-4">
                                    <input name="name" type="text" id="first-name" class="form-control">
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Email </span></label>
                                <div class="col-lg-4 col-md-4">
                                    <input name="email" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Địa chỉ</label>
                                <div class="col-lg-3 col-md-4">
                                    <textarea rows="3" name="address" type="text" class="form-control"></textarea>
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Số điện thoại <span class="require">*</span></label>
                                <div class="col-lg-3 col-md-3">
                                    <input name="phone" required="true" type="number" class="form-control">
                                </div>
                            </div>

                        </c:if>                      
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-8 padding-left-0 padding-top-20">
                                <button class="btn btn-primary" type="submit">Xác Nhận</button>
                            </div>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </div>
</jsp:body>
</template:shopbasic>
