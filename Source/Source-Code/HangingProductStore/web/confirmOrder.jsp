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
                <li><a href="ViewCartServlet">Giỏ Hàng</a></li>  
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
            <li><a href="ViewCartServlet">Giỏ Hàng</a></li>  
            <li><a href="ConsignServlet">Kí Gửi</a></li>
            </c:if>
    </jsp:attribute>
    <jsp:body> 
        <div class="row margin-bottom-40">
            <h4>Bạn đã đặt các món hàng:</h4>
            <div class="content-form-page">                  
                <div class="table-wrapper-responsive ">
                    <div class="goods-data clearfix ">
                        <c:set var="items" value="${requestScope.DATA}"/>
                        <c:if test="${not empty items}">
                            <div class="table-wrapper-responsive">
                                <table>
                                    <tr>
                                        <th>Sồ thứ tự</th>
                                        <th>Tên</th>
                                        <th>Nhãn hiệu</th>                               
                                        <th>Số Serial</th>
                                    </tr>
                                    <c:forEach var="item" items="${items}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${item.name}</td>
                                            <td><h3>${item.brand}</h3></td>
                                            <td>${item.serialNumber}</td>
                                        </tr>
                                    </c:forEach>                                   
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
                        <c:if test="${not empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="first-name">Email <span class="require">*</span></label>
                                <div class="col-lg-4">
                                    <input value="${acc.email}" name="email" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="first-name">Sồ điện thoại <span class="require">*</span></label>
                                <div class="col-lg-4">
                                    <input value="${acc.phone}" name="phone" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="first-name">Email <span class="require">*</span></label>
                                <div class="col-lg-4">
                                    <input name="email" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="first-name">Sồ điện thoại <span class="require">*</span></label>
                                <div class="col-lg-4">
                                    <input name="phone" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                        </c:if>                      
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-2 padding-left-0 padding-top-20">
                                <button class="btn btn-primary" type="submit">Xác Nhận</button>
                            </div>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </jsp:body>
</template:shopbasic>
