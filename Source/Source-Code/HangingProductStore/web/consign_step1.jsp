<%-- 
    Document   : consign_step1
    Created on : May 30, 2015, 9:34:04 PM
    Author     : Robingios
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %> 
<template:consign htmlTitle="Consign" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <style>
            .ui-autocomplete-loading {
                background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
            }
        </style>
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">

    </jsp:attribute>
    <jsp:body>
        <div class="row margin-bottom-40">

            <!-- BEGIN PAGE CONTENT-->
            <!-- BEGIN DIV STEP1 -->
            <form  action="ConsignServlet" method="POST" onsubmit="return validation()" >
                <div class="row">

                    <div class="portlet box" id="form_wizard_1">

                        <div class="portlet-body form">
                            <div class="form-horizontal" id="submit_form">
                                <div class="form-wizard">
                                    <div class="form-body">
                                        <ul class="nav nav-pills nav-justified steps">
                                            <li class="active">
                                                <a  class="step">
                                                    <span class="number">
                                                        1 </span>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i><b> Kiểm tra sản phẩm </b></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="step">
                                                    <span class="number">
                                                        2 </span>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Chọn cửa hàng </span>
                                                </a>
                                            </li>
                                            <li >
                                                <a class="step">
                                                    <span class="number">
                                                        3 </span>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin chi tiết </span>
                                                </a>
                                            </li>
                                        </ul>


                                        <c:set var="product" value="${sessionScope.PRODUCT}" />
                                        <div>
                                            <div class="tab-content">
                                                <div class="row">
                                                    <div class="col-md-6 col-sm-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="txtProductName" class="col-md-4 col-sm-4 control-label">Tên sản phẩm <font color="red">*</font></label> <!--<span class="required">*</span> -->
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input id="txtProductName"  name="txtProductName" type="text" class="form-control" maxlength="50" value="${product.name}"/>
                                                                    <p class="help-block" id="erProductName">  </p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="txtSerial" class="col-md-4 col-sm-4 control-label"> Mã số </label>
                                                                <div class="col-md-5 col-sm-6">
                                                                    <input id="txtSerialNumber" type="text" class="form-control" name="txtSerialNumber" value="${product.serialNumber}"/>
                                                                    <p class="help-block" id="erSerialNumber"> </p>
                                                                </div>
                                                            </div>


                                                            <c:set var="fCate" value="${sessionScope.FCATE}" />
                                                            <c:set var="category" value="${sessionScope.CATEGORY}" />

                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">Loại <font color="red">*</font></label>
                                                                <div class="col-md-5 col-sm-6">
                                                                    <select id="txtCategory" name="txtCategory"  class="form-control" >
                                                                        <option value='' disabled selected style='display:none;'>Chọn...</option>

                                                                        <c:forEach var="father" items="${fCate}">
                                                                            <optgroup label="${father.categoryName}">
                                                                                <c:forEach var="child" items="${category}">
                                                                                    <c:if test="${child.parentId == father.categoryId}">
                                                                                        <c:if test="${child.categoryId == product.categoryID}">
                                                                                            <option value="${child.categoryId}" selected>${child.categoryName}</option>
                                                                                        </c:if>
                                                                                        <c:if test="${child.categoryId != product.categoryID}">
                                                                                            <option value="${child.categoryId}">${child.categoryName}</option>
                                                                                        </c:if>



                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </optgroup>

                                                                        </c:forEach>

                                                                    </select>

                                                                    <span class="help-block" id="erCategory">
                                                                    </span>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">Hãng</label>
                                                                <div class="col-md-5 col-sm-6">
                                                                    <input id="txtBrand" name="txtBrand" type="text" class="form-control" maxlength="50" value="${product.brand}"/>

                                                                    <span class="help-block" id="erBrand">
                                                                    </span>
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>

                                                    <div class="col-md-6 col-sm-6">
                                                        <div class="form-horizontal">

                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">Ngày mua</label>
                                                                <div class="col-md-4 col-sm-5">
<!--                                                                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                                        <input  id="txtDate" type="text" class="form-control" name="txtDate" readonly value="${product.purchasedDate}">
                                                                        <span class="input-group-btn">
                                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                        </span>
                                                                    </div>-->
                                                                    <input id="txtDate" type="text" class="form-control" name="txtDate" value="${product.purchasedDate}">
                                                                    <span class="help-block" id="erDate"> </span>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label  class="col-md-4 col-sm-4 control-label"> Mô tả </label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <textarea id="txtDescription" name="txtDescription" class="form-control" maxlength="225" rows="6" placeholder="" value="${product.description}"/>${product.description}</textarea>
                                                                    <span class="help-block" id="erDescription">
                                                                    </span>
                                                                </div>
                                                            </div>

                                                        </div>

                                                    </div> 
                                                </div>


                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-actions" style="
                                         padding-top: 5px;
                                         padding-bottom: 5px;
                                         padding-right: 5px;
                                         padding-left: 5px;
                                         ">
                                        <div class="row">
                                            <div class="col-md-8 col-sm-8"> 

                                            </div>

                                            <div class="col-md-4 col-sm-4">
                                                <button  name="btnAction" value="tostep2" type="submit" class="btn-block btn-lg btn btn-info" >BƯỚC KẾ <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span></button> <!--<i class="m-icon-big-swapright m-icon-white"></i> -->
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
            <!-- END DIV STEP1 -->


        </div>
    </jsp:body>
</template:consign>

<script type="text/javascript">
    

    $(function () {
        $("#txtBrand").autocomplete({
            source: "ConsignServlet?btnAction=getBrand",
            minLength: 1,
            select: function (event, ui) {
            }
        });
        $('#txtDate').datepicker();

    });

    function validation() {
        var check = true;
        if ($('#txtProductName').val().trim().length < 5 || $('#txtProductName').val().trim().length > 50) {
            $('#erProductName').html("<font color='red'>Yệu cầu 5-50 ký tự</font>");
            check = false;
        }
        else {
            $('#erProductName').html("");
        }
        if ($('#txtCategory').val() == null) {
            $('#erCategory').html("<font color='red'>Xin chọn loại hàng</font>");
            check = false;
        } else {
            $('#erCategory').html("");
        }

        return check;
    }

</script>
