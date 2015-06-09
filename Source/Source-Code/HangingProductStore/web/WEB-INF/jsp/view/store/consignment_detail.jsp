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
            <c:if test="${not empty alert}">
                <div class="alert alert-${alert.type.name} alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                    <strong>${alert.title}</strong> ${alert.body}
                </div>
            </c:if>
            
            <!-- BEGIN PAGE CONTENT-->
            <div class="row margin-bottom-25">
                <!-- BEGIN CAROUSEL -->
                <div class="col-lg-4 col-md-4 front-carousel">

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
                <div class="col-lg-8 col-md-8">
                    <form class="form-horizontal" role="form">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Product No.</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">
                                        ${consignment.product.productID}
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Product Name</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">
                                        ${consignment.product.name}
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Description</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">
                                        ${consignment.product.description}
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Request Date</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">

                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Price</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">
                                        <fmt:formatNumber type="currency" currencySymbol="$" value="${consignment.maxPrice}" />
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Delivery Date</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">
                                        ${consignment.fromDate} - ${consignment.toDate}
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Appointment</label>
                                <div class="col-md-9">
                                    <input class="form-control" type="date" value="${consignment.receivedDate}" disabled="">
                                </div>
                            </div>
                        </div>
                        <div class="form-actions fluid">
                            <div class="col-md-12">
                                <a class="btn btn-primary"
                                   data-toggle="modal"
                                   href="#appointmentModal">Make Appointment</a>
                                <a class="btn btn-primary"
                                   data-toggle="modal"
                                   href="#acceptingModal">Accept</a>
                                <a class="btn btn-info"
                                   data-toggle="modal"
                                   href="#refusingModal">Refuse</a>
                            </div>
                        </div>
                    </form>

                    <div class="btn-group btn-group-justified">
                    </div>
                </div>
                <!-- END PRODUCT DESCRIPTION -->
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="well">
                        <h4 class="form-section">Contact: ${consignment.name}</h4>
                        <address>
                            <strong>${consignment.address}</strong><br>
                            <abbr title="Phone">P:</abbr> ${consignment.phone}</address>
                        <address>
                            <strong>Email</strong><br>
                            <a href="mailto:#">${consignment.email}</a>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->

    <!-- Appointment Modal BEGIN -->
    <div class="modal face" id="appointmentModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4>Consignment Appointment</h4>
                </div>
                <div class="modal-body">
                    <p>${consignment.name} is free from ${consignment.fromDate} to ${consignment.toDate}.</p>
                    <form class="form-horizontal">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Appointment Date</label>
                                <div class="col-md-9">
                                    <input class="form-control" type="date" value="">
                                </div>
                            </div>
                        </div>
                        <div class="form-action right">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
                    </c:url>
                    <form action="${current}" method="post">
                        <button class="btn btn-primary" type="submit" name="accept">Make</button>
                        <button type="button" class="btn default" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Appointment Modal END -->

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
                                    <input class="form-control" type="number" value="${consignment.maxPrice}"
                                           <c:if test="${not empty consignment.maxPrice}">disabled=""</c:if>>
                                    </div>
                                </div>
                            </div>
                            <div class="form-action right">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                    <c:url var="current" value="consignment">
                        <c:param name="id" value="${consignment.consigmentID}"/>
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
                        <c:param name="id" value="${consignment.consigmentID}"/>
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
                        <c:param name="id" value="${consignment.consigmentID}"/>
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
                        <c:param name="id" value="${consignment.consigmentID}"/>
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
                    <h3 class="form-section">${consignment.name}</h3>
                    <div class="well">
                        <h4>Address</h4>
                        <address>
                            <strong>${consignment.address}</strong><br>
                            <abbr title="Phone">P:</abbr> ${consignment.phone}</address>
                        <address>
                            <strong>Email</strong><br>
                            <a href="mailto:#">${consignment.email}</a>
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