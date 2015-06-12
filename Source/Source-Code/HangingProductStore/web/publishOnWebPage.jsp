<%-- 
    Document   : publishOnWebPage
    Created on : Jun 10, 2015, 11:36:50 PM
    Author     : Tien Dan
--%>

<%--@elvariable id="c" type="hps.dtl.Consignment"--%>
<template:shopbasic htmlTitle="Quản lý hàng kí gửi" bodyTitle="">
    <jsp:attribute name="extraBottomContent">
        <link href="assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
        <link href="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.css" rel="stylesheet">
    </jsp:attribute>
    <jsp:body>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40 ">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-4">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown">
                        <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu kí gửi</a>
                        <ul class="list-group margin-bottom-25 dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="./consignment?search"><i class="fa fa-angle-right"></i> Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix active">
                                <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
                            </li>
                        </ul>
                        <a><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                        <ul class="list-group margin-bottom-25 dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="LoadManageProductPageServlet"><i class="fa fa-angle-right"></i>Hàng kí gửi</a>
                            </li>
                        </ul>
                        <a><i class="fa fa-angle-right"></i>Thống kê</a>
                        <ul class="list-group margin-bottom-25 dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Bán hàng</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Thanh toán</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="col-md-9">
                <div class="row">
                    <div class="portlet box" id="form_wizard_1">
                        <div class="portlet-body form">
                            <div class="form-horizontal" id="submit_form">
                                <div class="form-wizard">
                                    <div class="form-body">
                                        <c:set var="product" value="${requestScope.product}" />
                                        <div>
                                            <div class="tab-content">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="txtProductName" class="col-sm-4 control-label">Tên sản phẩm <span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input id="productNameField" type="text" class="form-control" maxlength="50" value="${product.name}"/>
                                                                    <p class="help-block" id="erProductName">  </p>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="txtSerial" class="col-sm-4 control-label"> Số seri </label>
                                                                <div class="col-sm-8">
                                                                    <input id="serialNumberField" type="text" class="form-control" value="${product.serialNumber}"/>
                                                                    <p class="help-block" id="erSerialNumber"> </p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-sm-4">Ngày mua hàng<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                                        <input id="txtDate" type="text" class="form-control" name="txtDate" readonly value="${product.purchasedDate}">
                                                                    </div>
                                                                    <span class="help-block" id="erDate"> </span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <c:set var="parentCat" value="${requestScope.parentCat}"></c:set>
                                                                <c:set var="sameLevelCat" value="${requestScope.sameLevelCat}"></c:set>
                                                                <c:set var="productCatName" value="${productCat}"></c:set>
                                                                    <label class="control-label col-sm-4">Loại sản phẩm<span class="required">*</span></label>
                                                                    <div class="col-sm-8">
                                                                        <select id="parentCategoryField" style="width: 120px">
                                                                        <c:forEach var="item" items="${parentCat}" varStatus="counter">
                                                                            <option <c:if test="${counter.count==product.parentCategoryID}">selected="selected"</c:if>>${item.categoryName}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                    <select id="childCategoryField" style="width: 120px">
                                                                        <c:forEach var="item" items="${sameLevelCat}" varStatus="counter">
                                                                            <option <c:if test="${productCatName==item.categoryName}">selected="selected"</c:if>>${item.categoryName}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-sm-4">Hãng</label>
                                                                <div class="col-sm-8">
                                                                    <input id="brandField" type="text" class="form-control" maxlength="50" value="${product.brand}"/>
                                                                    <span class="help-block" id="erBrand">
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label  class="col-sm-4 control-label">Mô tả </label>
                                                                <div class="col-sm-8">
                                                                    <textarea id="descriptionField" class="form-control" maxlength="225" rows="6" placeholder="">${product.description}</textarea>
                                                                    <span class="help-block" id="erDescription">
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">Hình ảnh <span class="required">* </span></label>
                                                                <div class="col-md-9">
                                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                        <div class="fileinput-new thumbnail" style="width: 250px; height: 200px;">
                                                                            <img name="productImage" id="productImg" src='${product.image}' style="width: 100%; height: 100%"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 200px;">
                                                                        <div>
                                                                            <form action="UploadImageServlet" method="POST"enctype="multipart/form-data">
                                                                                <input type="hidden" name="productID" value="${product.productID}"/>
                                                                                <input type="file" id="txtImage" name="txtImage" onchange="readURL(this);"/>
                                                                                <input type="submit" name="btnUpload" value="Upload" style="height: 21px; width: 85px"/>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <form action="PublishOnWebServlet" method="GET">
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-sm-5">
                                                    <input type="hidden" name="productID" value="${product.productID}"/>
                                                    <input id="txtProductName" type="hidden" name="productName" value="">
                                                    <input id="txtSerialNumber" type="hidden" name="serialNumber" value="">
                                                    <input id="txtParentCategory" type="hidden" name="parentCat" value="">
                                                    <input id="txtChildCategory" type="hidden" name="childCat" value="">
                                                    <input id="txtBrand" type="hidden" name="brand" value="">
                                                    <input id="txtDescription" type="hidden" name="description" value="">
                                                    <button  name="btnAction" value="cancel" type="submit" class="btn-block btn-lg btn btn-info" >Trở lại <i class="m-icon-big-swapleft m-icon-white"></i></button>
                                                </div>
                                                <div class="col-sm-5">
                                                    <button  name="btnAction" value="publish" type="submit" class="btn-block btn-lg btn btn-primary" onclick="loadData()">Duyệt <i class="m-icon-big-swapright m-icon-white"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </jsp:body>
</template:shopbasic>
<script>
    $(document).ready(function () {
        $('#parentCategoryField').change(function (event) {
            var parentCategory = $("select#parentCategoryField").val();
            $.get('GetChildCategoryServlet', {parentCategory: parentCategory}, function (response) {
                var select = $('#childCategoryField');
                select.find('option').remove();
                $.each(response, function (index, value) {
                    $('<option>').val(value).text(value).appendTo(select);
                });
            });
        });
    });
    function loadData()
    {
        document.getElementById("txtProductName").value = document.getElementById("productNameField").value;
        document.getElementById("txtSerialNumber").value = document.getElementById("serialNumberField").value;
        document.getElementById("txtParentCategory").value = document.getElementById("parentCategoryField").value;
        document.getElementById("txtChildCategory").value = document.getElementById("childCategoryField").value;
        document.getElementById("txtBrand").value = document.getElementById("brandField").value;
        document.getElementById("txtDescription").value = document.getElementById("descriptionField").value;
    };
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#productImg')
                        .attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    ;
</script>