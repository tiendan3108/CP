<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Consignment Request" bodyTitle="">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
        <!-- BEGIN SIDEBAR -->
        <div class="sidebar col-md-3 col-sm-4">
            <ul class="list-group margin-bottom-25 sidebar-menu">
                <li class="list-group-item clearfix">
                    <a href="./consignment?search"><i class="fa fa-angle-right"></i> Search</a>
                </li>
                <li class="list-group-item clearfix active">
                    <a href="./consignment?request"><i class="fa fa-angle-right"></i> Request List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?action=manage"><i class="fa fa-angle-right"></i> Product List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?sold"><i class="fa fa-angle-right"></i> Sold List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <h1>Danh Sách Chờ Ký Gửi</h1>
            <form class="form-horizontal" role="form" action="consignment">
                <div class="form-body">
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="input-group">
                                <input id="newpassword" class="form-control" type="text" name="searchValue" value="${param.searchValue}">
                                <span class="input-group-btn">
                                    <button class="btn btn-success" type="submit" name="search">Search</button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                <thead>
                    <tr role="row" class="heading">
                        <th>
                            Stt.
                        </th>
                        <th>
                            Tên Sản Phẩm
                        </th>
                        <th>
                            Ngày Gửi
                        </th>
                        <th>
                            Giá
                        </th>
                        <th>
                            Ngày Giao
                        </th>
                        <th>
                            Chi Tiết
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty consignments}">

                        <tr>
                            <c:if test="${empty param.searchValue}">
                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý.</td>
                            </c:if>
                            <c:if test="${not empty param.searchValue}">
                                <td colspan="6">Không có yêu cầu nào đang chờ xử lý với tên sản phẩm tương tự "${param.searchValue}".</td>
                            </c:if>
                        </tr>
                    </c:if>
                    <c:forEach var="c" items="${consignments}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>
                                ${c.product.name}
                            </td>
                            <td>
                                ${c.createdDate}
                                <%--<fmt:formatDate type="date" dateStyle="long" value="${c.requestDate}"/>--%>
                            </td>
                            <td>
                                <fmt:formatNumber type="currency" currencySymbol="$" value="${c.maxPrice}" />
                            </td>
                            <td>
                                ${c.fromDate} - ${c.toDate}
                            </td>
                            <td>
                                <c:url var="detailUrl" value="consignment">
                                    <c:param name="id" value="${c.consigmentID}"/>
                                </c:url>
                                <a href="${detailUrl}" 
                                   class="btn btn-primary">Xem</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:shopbasic>