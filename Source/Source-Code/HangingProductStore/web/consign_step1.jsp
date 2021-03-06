<%-- 
    Document   : consign_step1
    Created on : May 30, 2015, 9:34:04 PM
    Author     : Robingios
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %> 
<template:consign htmlTitle="Consign" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
        <link rel="stylesheet" href="js/jquery-ui.css">
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
        <div id="wrapper">
            <div class="row margin-bottom-40">

                <!-- BEGIN PAGE CONTENT-->
                <!-- BEGIN DIV STEP1 -->
                <form  action="ConsignServlet" method="POST" onsubmit="return validation()" >
                    <div class="form-wizard">                        
                        <ul class="nav nav-pills nav-justified steps">
                            <li class="active">
                                <a  class="step">
                                    <span class="number">
                                        <b>1</b> </span>
                                    <br/>
                                    <span class="desc" >
                                        <i class="fa fa-check"></i><b>Thông tin sản phẩm </b></span>
                                </a>
                            </li>
                            <li>
                                <a class="step">
                                    <span class="number">
                                        <b>2</b> </span>
                                    <br/>
                                    <span class="desc">
                                        <i class="fa fa-check"></i>Kiểm tra sản phẩm</span>
                                </a>
                            </li>
                            <li>
                                <a class="step">
                                    <span class="number">
                                        <b>3</b> </span>
                                    <br/>
                                    <span class="desc">
                                        <i class="fa fa-check"></i>Chọn cửa hàng</span>
                                </a>
                            </li>
                            <li>
                                <a class="step">
                                    <span class="number">
                                        <b>4</b> </span>
                                    <br/>
                                    <span class="desc">
                                        <i class="fa fa-check"></i>Thông tin chi tiết</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div id="divheader" class="row"> 
                        <div class="col-md-4 col-sm-4" style="font-size: 120%; font-weight: bold; text-align: right; margin-top: 10px">Chọn cách ký gửi</div>
                        <div class="col-md-3 col-sm-3">
                            <button name="btnChange" value="name" type="button" class="btn btn-lg btn-block btn-circle btn-default">Tên sản phẩm</button>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <button name="btnChange" value="serial" type="button" class="btn btn-lg btn-block btn-circle btn-default">Mã sản phẩm</button>
                        </div>
                        <input type="hidden" name="txtSearchMethod" id="searchMethod"/>
                    </div>
                    <c:set var="product" value="${sessionScope.PRODUCT}" />
                    <br/> <br/>
                    <div id="divbody">
                        <div class="row">
                            <div class="tab-content">
                                <c:if test="${requestScope.UPCERROR != null}">
                                    <div class="alert alert-danger" style="text-align: center">
                                        <i class="fa-lg fa fa-warning"></i><strong>${requestScope.UPCERROR}</strong>
                                    </div>    
                                </c:if>

                                <div class="row">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="form-horizontal">
                                            <div id="div_txtProductName" class="form-group">
                                                <label for="txtProductName" class="col-md-4 col-sm-4 control-label">Tên sản phẩm <font id="reProductName" color="red">*</font></label> <!--  -->
                                                <div class="col-md-8 col-sm-8">
                                                    <input id="txtProductName"  name="txtProductName" type="text" class="form-control" maxlength="100" value="${product.name}"/>
                                                    <p class="help-block" id="erProductName"></p>
                                                </div>
                                            </div>

                                            <div class="form-group" id="div_txtSerialNumber" style="display: none">
                                                <label for="txtSerialNumber" class="col-md-4 col-sm-4 control-label">Mã số <font id="reProductName" color="red">*</font></label> <!--<font id="reSerialNumber" color="red">*</font>-->
                                                <div class="col-md-6 col-sm-6">
                                                    <input id="txtSerialNumber" type="text" class="form-control" name="txtSerialNumber" value="${product.serialNumber}"/>
                                                    <p class="help-block" id="erSerialNumber"> </p>
                                                </div>
                                            </div>


                                            <c:set var="fCate" value="${FCATE}" />
                                            <c:set var="category" value="${CATEGORY}" />

                                            <div class="form-group">
                                                <label class="control-label col-md-4 col-sm-4">Loại <font color="red">*</font></label>
                                                <div class="col-md-6 col-sm-6">
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

                                            <div class="form-group" id="div_txtBrand">
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
                                                <label class="control-label col-md-4 col-sm-4">Độ mới <font color="red">*</font></label>
                                                <div class="col-md-4 col-sm-4">
                                                    <c:choose>
                                                        <c:when test="${product.newStatus > 0}">
                                                            <div class="input-group">
                                                                <input id="txtNewStatus" name="txtNewStatus" maxlength="100" value="${product.newStatus}" type="text" class="form-control"/> <span class="input-group-addon"><b>%</b>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="input-group">
                                                                <input id="txtNewStatus" name="txtNewStatus" maxlength="100" value="80" type="text" class="form-control"/> <span class="input-group-addon"><b>%</b>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>
                                                <div class="col-md-4 col-sm-4">
                                                    <span class="help-block" id="erNewStatus"> </span>
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


                    <div class="row">
                        <div class="col-md-8 col-sm-8"> 

                        </div>

                        <div class="col-md-4 col-sm-4">
                            <button  name="btnAction" value="tostep2" type="submit" class="btn btn-block btn-lg blue" >BƯỚC KẾ <i class="m-icon-big-swapright m-icon-white"></i></button> <!-- <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>-->
                        </div>

                    </div>

                </form>
                <!-- END DIV STEP1 -->


            </div>
        </div>
    </jsp:body>
</template:consign>

<script type="text/javascript">
    $(document).ready(function () {
        if ($("#txtSerialNumber").val().length == 0 && $("#txtProductName").val().length == 0) {
            $("#div_txtSerialNumber").hide();
            $("#div_txtProductName").show();
            $("#div_txtBrand").show();
            $("button[name='btnChange'][value='serial']").removeClass("green").addClass("btn-default");
            $("button[name='btnChange'][value='name']").removeClass("btn-default").addClass("green");
            $("#searchMethod").val("name");
        } else {


            if ($("#txtSerialNumber").val().length > 0) {
                $("#div_txtSerialNumber").show();
                $("#div_txtProductName").hide();
                $("#div_txtBrand").hide();

                $("button[name='btnChange'][value='name']").removeClass("green").addClass("btn-default");
                $("button[name='btnChange'][value='serial']").removeClass("btn-default").addClass("green");
                $("#searchMethod").val("serial");

            } else {
                $("#div_txtSerialNumber").hide();
                $("#div_txtProductName").show();
                $("#div_txtBrand").show();
                $("button[name='btnChange'][value='serial']").removeClass("green").addClass("btn-default");
                $("button[name='btnChange'][value='name']").removeClass("btn-default").addClass("green");
                $("#searchMethod").val("name");
            }
        }
//        else if ($("#txtSerialNumber").val().length > 0 && $("#txtProductName").val().length == 0) {
//            $("#txtProductName").prop("readonly", true);
//            $("#txtBrand").prop("readonly", true);
//            //$("#reProductName").hide();
//
//        }
//        else if ($("#txtSerialNumber").val().length == 0 && $("#txtProductName").val().length == 0) {
//            $("#txtSerialNumber").prop("readonly", false);
//            $("#txtProductName").prop("readonly", false);
//
//        } else if ($("#txtSerialNumber").val().length >= 0 && $("#txtProductName").val().length >= 0) {
//            $("#txtSerialNumber").prop("readonly", false);
//            $("#txtProductName").prop("readonly", true);
//            $("#txtBrand").prop("readonly", true);
//            //$("#reProductName").hide();

        //}
    });
    $(function () {
        $("#txtBrand").autocomplete({
            source: "BrandAutocomplete",
            minLength: 1,
            select: function (event, ui) {
            }
        });
    });

    $('#txtProductName').on('input', function (e) {
//        if ($(this).val().length > 0) {
//            $("#txtSerialNumber").prop("readonly", true);
//            $("#txtSerialNumber").val("");
//            //$("#reSerialNumber").hide();
//        } else {
//            $("#txtSerialNumber").prop("readonly", false);
//            //$("#reSerialNumber").show();
//        }
    });
    $('#txtSerialNumber').on('input', function (e) {
//        if ($(this).val().length > 0) {
//            $("#txtProductName").prop("readonly", true);
//            $("#txtBrand").prop("readonly", true);
//            $("#txtProductName").val("");
//            $("#txtBrand").val("");
//
//            //$("#reProductName").hide();
//        } else {
//            $("#txtProductName").prop("readonly", false);
//            $("#txtBrand").prop("readonly", false);
//            //$("#reProductName").show();
//        }
    });

    function validation() {
        var check = true;

        if ($("button[name='btnChange'][value='name']").attr("class").indexOf("green") > -1) {
            if ($('#txtProductName').val().trim().length < 5 || $('#txtProductName').val().trim().length > 100) {
                $('#erProductName').html("<font color='red'>Yệu cầu 5-100 ký tự</font>");
                check = false;
            }
            else {
                $('#erProductName').html("");
            }
        } else {
            if ($('#txtSerialNumber').val().trim().length == 0) {
                $('#erSerialNumber').html("<font color='red'>Xin nhập mã sản phẩm</font>");
                check = false;
            }
            else {
                $('#erSerialNumber').html("");
            }
        }
//        if ($('#txtProductName').val().length == 0 && $('#txtSerialNumber').val().length == 0) {
//
//            $('#erProductName').html("<font color='red'>Xin nhập tên hoặc mã số</font>");
//            check = false;
//        } else {
//            $('#erProductName').html("");
//        }
//        if ($('#txtProductName').prop('readonly') == false && $('#txtSerialNumber').prop('readonly') == true) {
//            if ($('#txtProductName').val().trim().length < 5 || $('#txtProductName').val().trim().length > 100) {
//                $('#erProductName').html("<font color='red'>Yệu cầu 5-100 ký tự</font>");
//                check = false;
//            }
//            else {
//                $('#erProductName').html("");
//            }
//        }

        if ($('#txtCategory').val() == null) {
            $('#erCategory').html("<font color='red'>Xin chọn loại hàng</font>");
            check = false;
        } else {
            $('#erCategory').html("");
        }


        var newStatus = $('#txtNewStatus').val();
        if (newStatus.length == 0) {
            $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-99</font>");
            check = false;
        } else {
            if (isNaN(newStatus)) {
                $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-99</font>");
                check = false;
            } else {
                if (newStatus.indexOf(".") > -1) {
                    $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-99</font>");
                    check = false;
                } else {
                    var numStatus = parseInt(newStatus);
                    if (numStatus > 99 || numStatus < 1) {
                        $('#erNewStatus').html("<font color='red'>Xin nhập số nguyên từ 1-99</font>");
                        check = false;
                    } else {
                        $('#erNewStatus').html("");
                    }
                }
            }
        }


        return check;
    }

    $("button[name='btnChange']").click(function () {
        var method = $(this).val();
        $("#erSerialNumber").html("");
        $("#erProductName").html("");
        $("#erCategory").html("");
        $("#erNewStatus").html("");
        //$("#txtSerialNumber").val("");
        //$("#txtProductName").val("");
        
        $("#searchMethod").val(method);
        if (method == "name") {
            $("#div_txtSerialNumber").hide();
            $("#div_txtProductName").show();
            $("#div_txtBrand").show();
            $("button[name='btnChange'][value='serial']").removeClass("green").addClass("btn-default");
            $(this).removeClass("btn-default").addClass("green");
        } else {
            $("#div_txtSerialNumber").show();
            $("#div_txtProductName").hide();
            $("#div_txtBrand").hide();
            $("button[name='btnChange'][value='name']").removeClass("green").addClass("btn-default");
            $(this).removeClass("btn-default").addClass("green");
        }
    });

</script>
