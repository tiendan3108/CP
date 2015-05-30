<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:storebasic htmlTitle="Consignment Request" bodyTitle="Consignment Request">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
        <!-- BEGIN SIDEBAR -->
        <div class="sidebar col-md-3 col-sm-4">
            <ul class="list-group margin-bottom-25 sidebar-menu">
                <li class="list-group-item clearfix">
                    <a href="./consignment?search"><i class="fa fa-angle-right"></i> Advance Search</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment"><i class="fa fa-angle-right"></i> Request List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignor"><i class="fa fa-angle-right"></i> Consignor List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <h4>Request List</h4>
            <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                <thead>
                    <tr role="row" class="heading">
                        <th width="20%">
                            Product
                        </th>
                        <th>
                            Request Date
                        </th>
                        <th>
                            Consign Price
                        </th>
                        <th>
                            Transfer Date
                        </th>
                        <th>
                            Actions
                        </th>
                    </tr>
                    <tr role="row" class="filter">
                        <td>
                            <input type="text" class="form-control form-filter input-sm">
                        </td>
                        <td>
                            <div class="input-group date date-picker margin-bottom-5" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_from" placeholder="From">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_to" placeholder="To">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </td>
                        <td>
                            <div class="margin-bottom-5">
                                <input type="text" class="form-control form-filter input-sm margin-bottom-5 clearfix" name="order_quantity_from" placeholder="From" />
                            </div>
                            <input type="text" class="form-control form-filter input-sm" name="order_quantity_to" placeholder="To" />
                        </td>
                        <td>
                            <div class="input-group date date-picker margin-bottom-5" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_from" placeholder="From">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_to" placeholder="To">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </td>
                        <td>
                            <div class="margin-bottom-5">
                                <button class="btn btn-sm yellow filter-submit margin-bottom"><i class="fa fa-search"></i> Search</button>
                            </div>
                            <button class="btn btn-sm red filter-cancel"><i class="fa fa-times"></i> Reset</button>
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${consignments}">
                        <tr>
                            <td>
                                ${c.product.name}
                                <c:choose>
                                    <c:when test="${not empty c.acceptDate}">
                                        <br/><span class="label label-primary">accepted</span>
                                    </c:when>
                                    <c:when test="${not empty c.refuseDate}">
                                        <br/><span class="label label-danger">refused</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate type="date" dateStyle="long" value="${c.requestDate}"/>
                            </td>
                            <td>
                                <fmt:formatNumber type="currency" currencySymbol="$" value="${c.consignPrice}" />
                            </td>
                            <td>
                                <fmt:formatDate type="date" dateStyle="long" value="${c.transferDate}"/>
                            </td>
                            <td>
                                <c:url var="detailUrl" value="consignment">
                                    <c:param name="id" value="${c.id}"/>
                                </c:url>
                                <a href="${detailUrl}" 
                                   class="btn
                                   <c:choose>
                                       <c:when test="${empty c.viewDate}">btn-primary</c:when>
                                       <c:otherwise>btn-default</c:otherwise>
                                   </c:choose>">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:storebasic>