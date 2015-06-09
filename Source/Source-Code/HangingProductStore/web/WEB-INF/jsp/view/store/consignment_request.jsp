<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:storebasic htmlTitle="Consignment Request" bodyTitle="Consignment Request">
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
                    <a href="./consignment?action=manage"><i class="fa fa-angle-right"></i> Manage Status</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?sold"><i class="fa fa-angle-right"></i> Sold List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <h4>Request List</h4>
            <form class="form-horizontal" role="form">
                <div class="form-body">
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="input-group">
                                <input id="newpassword" class="form-control" type="text" name="searchValue">
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
                            No.
                        </th>
                        <th>
                            Product
                        </th>
                        <th>
                            Request Date
                        </th>
                        <th>
                            Price
                        </th>
                        <th>
                            Transfer Date
                        </th>
                        <th>
                            Actions
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty consignments}">
                        <tr>
                            <td colspan="6">There is no request.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="c" items="${consignments}">
                        <tr>
                            <td>${c.product.productID}</td>
                            <td>
                                ${c.product.name}
                            </td>
                            <td>
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
                                   class="btn btn-primary">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:storebasic>