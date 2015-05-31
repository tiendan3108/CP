<template:storebasic htmlTitle="${consignment.product.name}"
                     bodyTitle="${consignment.product.name}">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
        <!-- BEGIN SIDEBAR -->
        <div class="sidebar col-md-3 col-sm-4">
            <ul class="list-group margin-bottom-25 sidebar-menu">
                <li class="list-group-item clearfix">
                    <a href="./consignment?search"><i class="fa fa-angle-right"></i> Search</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?request"><i class="fa fa-angle-right"></i> Request List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?imported"><i class="fa fa-angle-right"></i> Imported List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment?sold"><i class="fa fa-angle-right"></i> Sold List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <div class="page-content">
                <!-- BEGIN PAGE CONTENT-->
                <div class="row">
                    <div class="col-md-12 col-md-12">
                        <c:if test="${not empty alert}">
                            <div class="alert alert-${alert.type.name} alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                                <strong>${alert.title}</strong> ${alert.body}
                            </div>
                        </c:if>
                        <h1>
                            ${consignment.product.name} <small>from</small>
                            <a data-toggle="modal" href="#contactModal">${consignment.customerName}</a>

                            <c:choose>
                                <c:when test="${not empty consignment.importDate}">
                                    <span class="label label-primary">imported</span>
                                </c:when>
                                <c:when test="${not empty consignment.acceptDate}">
                                    <span class="label label-primary">accepted</span>
                                </c:when>
                                <c:when test="${not empty consignment.refuseDate}">
                                    <span class="label label-danger">refused</span>
                                </c:when>
                            </c:choose>
                        </h1>
                        <div class="content-page">
                            <div class="row margin-bottom-30">
                                <!-- BEGIN CAROUSEL -->
                                <div class="col-lg-4 col-md-12 front-carousel">

                                    <div class="carousel slide" id="myCarousel">
                                        <!-- Carousel items -->
                                        <div class="carousel-inner">
                                            <div class="item active">
                                                <img alt="" src="./assets/product/1.jpg">
                                                <div class="carousel-caption">
                                                    <p>Excepturi sint occaecati cupiditate non provident</p>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Carousel nav -->
                                        <a data-slide="prev" href="#myCarousel" class="carousel-control left">
                                            <i class="fa fa-angle-left"></i>
                                        </a>
                                        <a data-slide="next" href="#myCarousel" class="carousel-control right">
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>

                                </div>
                                <!-- END CAROUSEL -->

                                <!-- BEGIN PRODUCT DESCRIPTION -->
                                <div class="col-lg-8 col-md-12">
                                    <div class="note note-info">
                                        <h3 class="text-danger">
                                            <fmt:formatNumber type="currency" currencySymbol="$" value="${consignment.consignPrice}"/>
                                        </h3>
                                    </div>
                                    <p>${consignment.product.description}</p>

                                    <div class="btn-group btn-group-justified">
                                        <c:choose>
                                            <c:when test="${empty consignment.acceptDate and empty consignment.refuseDate}">
                                                <a class="btn btn-primary"
                                                   data-toggle="modal"
                                                   href="#acceptingModal">Accept</a>
                                                <a class="btn btn-link"
                                                   data-toggle="modal"
                                                   href="#refusingModal">Refuse</a>
                                            </c:when>
                                            <c:when test="${not empty consignment.importDate}">
                                                <a class="btn btn-primary"
                                                   data-toggle="modal"
                                                   href="#raisingModal">Raise on Web</a>
                                                <a class="btn btn-link"
                                                   data-toggle="modal"
                                                   href="#cancelingModal">Cancel</a>
                                            </c:when>
                                            <c:when test="${not empty consignment.acceptDate}">
                                                <a class="btn btn-primary"
                                                   data-toggle="modal"
                                                   href="#importingModal">Import</a>
                                                <a class="btn btn-link"
                                                   data-toggle="modal"
                                                   href="#cancelingModal">Cancel Accept</a>
                                            </c:when>
                                            <c:when test="${not empty consignment.refuseDate}">
                                                <a class="btn"></a>
                                                <a class="btn btn-link"
                                                   data-toggle="modal"
                                                   href="#cancelingModal">Cancel Refuse</a>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <!-- END PRODUCT DESCRIPTION -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BEGIN AMAZON INFORMATION -->
                <div class="row">
                    <div class="col-md-12">
                        <h2>Amazon Information</h2>
                        <div class="content-page">
                            <div class="row">
                                <!-- BEGIN PRODUCT SPECIFICATION -->
                                <div class="col-md-6">
                                    <table class="table table-hover">
                                        <caption>Watch Information</caption>
                                        <tbody>
                                            <tr>
                                                <td>Band Colour</td>
                                                <td>Black</td>
                                            </tr>
                                            <tr>
                                                <td>Band Material</td>
                                                <td>Resin</td>
                                            </tr>
                                            <tr>
                                                <td>Band Width</td>
                                                <td>18 Millimeters</td>
                                            </tr>
                                            <tr>
                                                <td>Bezel Material</td>
                                                <td>Resin</td>
                                            </tr>
                                            <tr>
                                                <td>Brand</td>
                                                <td>Casio</td>
                                            </tr>
                                            <tr>
                                                <td>Case Diameter</td>
                                                <td>43</td>
                                            </tr>
                                            <tr>
                                                <td>Case Material</td>
                                                <td>Resin</td>
                                            </tr>
                                            <tr>
                                                <td>Case Thickness</td>
                                                <td>13 Millimeters</td>
                                            </tr>
                                            <tr>
                                                <td>Collection</td>
                                                <td>Youth-Digital</td>
                                            </tr>
                                            <tr>
                                                <td>Dial Colour</td>
                                                <td>Grey</td>
                                            </tr>
                                            <tr>
                                                <td>Display Type</td>
                                                <td>Digital</td>
                                            </tr>
                                            <tr>
                                                <td>Case Shape</td>
                                                <td>Rectangular</td>
                                            </tr>
                                            <tr>
                                                <td>Item Weight</td>
                                                <td>32 Grams</td>
                                            </tr>
                                            <tr>
                                                <td>Model Number</td>
                                                <td>AE-1200WH-1A</td>
                                            </tr>
                                            <tr>
                                                <td>Model Year</td>
                                                <td>2013</td>
                                            </tr>
                                            <tr>
                                                <td>Part Number</td>
                                                <td>AE-1200WH-1A</td>
                                            </tr>
                                            <tr>
                                                <td>Warranty Type</td>
                                                <td>Manufacturer Warranty</td>
                                            </tr>
                                            <tr>
                                                <td>Movement</td>
                                                <td>Quartz</td>
                                            </tr>
                                            <tr>
                                                <td>Water Resistance Depth</td>
                                                <td>200 Meters</td>
                                            </tr>
                                            <tr>
                                                <td>Warranty Description</td>
                                                <td>2 Years</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- END PRODUCT SPECIFICATION -->
                                <!-- BEGIN PRODUCT DESCRIPTION -->
                                <div class="col-md-6">
                                </div>
                                <!-- END PRODUCT DESCRIPTION -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END AMAZON INFORMATION -->
            </div>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->

    <!-- Accepting Modal BEGIN -->
    <div class="modal face" id="acceptingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4>Consignment Accepting</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Consign Price</label>
                                <div class="col-md-9">
                                    <input class="form-control" type="number" value="${consignment.consignPrice}"
                                           <c:if test="${not empty consignment.consignPrice}">disabled=""</c:if>>
                                    </div>
                                </div>
                            </div>
                            <div class="form-action right">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.id}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="accept">Accept</button>
                        <button type="button" class="btn default" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Accepting Modal END -->

    <!-- Refusing Modal BEGIN -->
    <div class="modal face" id="refusingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Consignment Refusing</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to refuse this consignment?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.id}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="refuse">Refuse</button>
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Refusing Modal END -->

    <!-- Importing Modal BEGIN -->
    <div class="modal face" id="importingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Product Importing</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to import this product?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.id}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="import">Import</button>
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Importing Modal END -->

    <!-- Deleting Modal BEGIN -->
    <div class="modal face" id="deletingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Deleting</h4>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete?
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.id}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="delete">Delete</button>
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Deleting Modal END -->

    <!-- Contact Modal BEGIN -->
    <div class="modal face" id="contactModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"></button>
                    <h4>Contact</h4>
                </div>
                <div class="modal-body">
                    <h3 class="form-section">${consignment.customerName}</h3>
                    <div class="well">
                        <h4>Address</h4>
                        <address>
                            <strong>${consignment.customerAddress}</strong><br>
                            <abbr title="Phone">P:</abbr> ${consignment.customerPhone}</address>
                        <address>
                            <strong>Email</strong><br>
                            <a href="mailto:#">${consignment.customerEmail}</a>
                        </address>
                    </div>
                    <div class="modal-footer">
                        <button class="btn default" type="button" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact Modal END -->
    </template:storebasic>