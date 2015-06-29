<%-- 
    Document   : consign_step3
    Created on : May 30, 2015, 9:32:08 PM
    Author     : Robingios
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %> 
<template:consign htmlTitle="Consign" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->



    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->

    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <li id="nofi">
                <a href="#">
                    <i class="icon-bell"></i>
                    <span class="badge badge-default">3</span>           
                </a>
                <ul class="fallback">
                    <li style="margin-left: -40px"><a href="#">notification 1</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                    <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                </ul>
            </li>
        </c:if>
    </jsp:attribute>
    <jsp:body>
        <div id="wrapper">
            <div class="row margin-bottom-40">

                <!-- BEGIN PAGE CONTENT-->


                <!-- BEGIN DIV STEP3 -->

                <div id="divStep3" class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="portlet box " id="form_wizard_1">

                            <div class="portlet-body form">
                                <div class="form-horizontal" id="submit_form">
                                    <div class="form-wizard">
                                        <div class="form-body">
                                            <ul class="nav nav-pills nav-justified steps" >

                                                <li class="done">
                                                    <a id="ltap1" class="step">
                                                        <span class="number">
                                                            1 </span>
                                                        <span class="desc">
                                                            <i class="fa fa-check"></i> Kiểm tra sản phẩm</span>
                                                    </a>
                                                </li>
                                                <li class="done">
                                                    <a id="ltap2" class="step">
                                                        <span class="number">
                                                            2 </span>
                                                        <span class="desc">
                                                            <i class="fa fa-check"></i> Chọn cửa hàng</span>
                                                    </a>
                                                </li>
                                                <li class="active">
                                                    <a id="ltap3"  class="step active">
                                                        <span class="number">
                                                            3 </span>
                                                        <span class="desc" >
                                                            <i class="fa fa-check"></i><b> Thông tin chi tiết</b></span>
                                                    </a>
                                                </li>

                                            </ul>

                                            <form id='form3' action="ConsignCompleteServlet" method="POST" onsubmit="return validation()" enctype="multipart/form-data">
                                                <c:set var="member" value="${sessionScope.ACCOUNT}"/>
                                                <div class="tab-content">

                                                    <div>
                                                        <div class="row">
                                                            <div class="col-md-6 col-sm-6">
                                                                <div class="form-horizontal">

                                                                    <div class="form-group">
                                                                        <label for="txtFullName" class="col-md-4 col-sm-4 control-label">Họ tên <font color="red">*</font></label>
                                                                        <div class="col-md-8 col-sm-8">
                                                                            <input type="text" id="txtFullName" name="txtFullName"  class="form-control" maxlength="50"  placeholder="" value="${member.fullName}">

                                                                            <p class="help-block" id="erFullName"> </p>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group" id="locationField">
                                                                        <label for="txtAddress" class="col-md-4 col-sm-4 control-label">Địa chỉ</label>
                                                                        <div  class="col-md-8 col-sm-8">
                                                                            <textarea id="addressInput" name="txtAddress" class="form-control" maxlength="225" rows="3"  placeholder="" >${member.address}</textarea>
                                                                            <span class="help-block" id="erAddress">
                                                                            </span>
                                                                        </div>
                                                                    </div>


                                                                    <div class="form-group" id="divPhone">
                                                                        <label for="txtPhone" class="col-md-4 col-sm-4 control-label"> Điện thoại <font color="red">*</font> </label>
                                                                        <div class="col-md-4 col-sm-6">
                                                                            <input type="text" id="txtPhone" name="txtPhone" class="form-control"   placeholder="" value="${member.phone}" />
                                                                            <p class="help-block" id="erPhone"></p>

                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group" id="divEmail">
                                                                        <label for="txtEmail" class="col-md-4 col-sm-4 control-label">Email </label>
                                                                        <div class="col-md-8 col-sm-8">
                                                                            <input type="text" id="txtEmail" name="txtEmail" class="form-control"  placeholder="example@abc.com" value="${member.email}">
                                                                            <p class="help-block" id="erEmail"></p>
                                                                        </div>
                                                                    </div>


                                                                    <div class="form-group">
                                                                        <label for="" class="col-md-4 col-sm-4 control-label"> Cách thanh toán </label>

                                                                        <div class="radio-list col-md-8 col-sm-8">
                                                                            <c:if test="${empty member}">
                                                                                <label class="radio-inline">
                                                                                    <input type="radio" name="rdPayment" id="optionsRadios7" value="direct" checked> Tiền mặt </label>
                                                                                <label class="radio-inline">
                                                                                    <input type="radio" name="rdPayment" id="optionsRadios8" value="cc"> Tài khoản paypal </label>
                                                                                </c:if>
                                                                                <c:if test="${not empty member}">
                                                                                    <c:if test="${not empty member.paypalAccount}">
                                                                                    <label class="radio-inline">
                                                                                        <input type="radio" name="rdPayment" id="optionsRadios7" value="direct"> Tiền mặt </label>
                                                                                    <label class="radio-inline">
                                                                                        <input type="radio" name="rdPayment" id="optionsRadios8" value="cc" checked> Tài khoản paypal </label>

                                                                                </c:if>
                                                                                <c:if test="${empty member.paypalAccount}">
                                                                                    <label class="radio-inline">
                                                                                        <input type="radio" name="rdPayment" id="optionsRadios7" value="direct" checked> Tiền mặt </label>
                                                                                    <label class="radio-inline">
                                                                                        <input type="radio" name="rdPayment" id="optionsRadios8" value="cc"> Tài khoản paypal </label>
                                                                                    </c:if>
                                                                                </c:if>

                                                                        </div>

                                                                    </div>
                                                                    <c:if test="${empty member}">
                                                                        <div id="divCCNumber" class="form-group" style="display: none" >
                                                                            <label for="txtPaypalAccount" class="col-md-4 col-sm-4 control-label">Mã tài khoản <font color="red">*</font></label>
                                                                            <div class="col-md-8 col-sm-8">
                                                                                <input type="text" id="txtPaypalAccount" name="txtPaypalAccount" class="form-control"   placeholder="" value="${member.paypalAccount}"/>

                                                                                <p class="help-block" id="erPaypalAccount"></p>
                                                                            </div>
                                                                        </div>    
                                                                    </c:if>
                                                                    <c:if test="${not empty member}">
                                                                        <c:if test="${empty member.paypalAccount}">
                                                                            <div id="divCCNumber" class="form-group" style="display: none" >
                                                                                <label for="txtPaypalAccount" class="col-md-4 col-sm-4 control-label">Mã tài khoản <font color="red">*</font></label>
                                                                                <div class="col-md-8 col-sm-8">
                                                                                    <input type="text" id="txtPaypalAccount" name="txtPaypalAccount" class="form-control"   placeholder="" value="${member.paypalAccount}"/>

                                                                                    <p class="help-block" id="erPaypalAccount"></p>
                                                                                </div>
                                                                            </div>    
                                                                        </c:if>
                                                                        <c:if test="${not empty member.paypalAccount}">
                                                                            <div id="divCCNumber" class="form-group">
                                                                                <label for="txtPaypalAccount" class="col-md-4 col-sm-4 control-label">Mã tài khoản <font color="red">*</font></label>
                                                                                <div class="col-md-8 col-sm-8">
                                                                                    <input type="text" id="txtPaypalAccount" name="txtPaypalAccount" class="form-control"   placeholder="" value="${member.paypalAccount}"/>

                                                                                    <p class="help-block" id="erPaypalAccount"></p>
                                                                                </div>
                                                                            </div>    
                                                                        </c:if>
                                                                    </c:if>


                                                                </div>
                                                            </div>

                                                            <div class="col-md-6 col-sm-6">
                                                                <div class="form-horizontal">

                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-4 col-sm-4">Hình ảnh <font color="red">*</font></label>
                                                                        <div class="col-md-8 col-sm-8" align="center">
                                                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                                <div class="fileinput-new thumbnail" style="width: 250px; height: 200px;">
                                                                                    <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDI0MiAyMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjkzIiB5PSIxMDAiIHN0eWxlPSJmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MTFwdDtkb21pbmFudC1iYXNlbGluZTpjZW50cmFsIj4yNDJ4MjAwPC90ZXh0PjwvZz48L3N2Zz4=" alt=""/>
                                                                                </div>
                                                                                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 200px;">
                                                                                </div>
                                                                                <div >
                                                                                    <span class="btn btn-info btn-file">
                                                                                        <span class="fileinput-new btn " >
                                                                                            CHỌN ẢNH </span>
                                                                                        <span class="fileinput-exists btn">
                                                                                            THAY ẢNH </span>
                                                                                        <input  type="file" id="txtImage" name="txtImage" id="txtImage" />
                                                                                    </span>
                                                                                    <a href="#" class="btn btn-lg btn-warning fileinput-exists" data-dismiss="fileinput">
                                                                                        XÓA </a>
                                                                                </div>
                                                                            </div>
                                                                            <span class="help-block" id="erImage">

                                                                            </span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-4 col-sm-4">Ngày giao hàng <font color="red">*</font></label>
                                                                        <div class="col-md-8 col-sm-8">
                                                                            <div  class="input-group  date-picker input-daterange" data-date-format="mm/dd/yyyy" data-date-start-date="0d" >
                                                                                <input type="text" id="txtFromDate" name="txtFromDate"  class="form-control" >
                                                                                <span class="input-group-addon">
                                                                                    đến </span>
                                                                                <input type="text" id="txtToDate" name="txtToDate" class="form-control" >
                                                                            </div>

                                                                            <span class="help-block" id="erDate">
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div id="map-canvas"></div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>													

                                                    </div>

                                                </div>

                                            </form>                              

                                        </div>
                                        <div class="form-actions" style="
                                             padding-top: 30px;
                                             padding-bottom: 5px;
                                             padding-right: 5px;
                                             padding-left: 5px;
                                             ">
                                            <div class="row">
                                                <form action="ConsignServlet" method="POST">
                                                    <div class="col-md-4 col-sm-4"> 
                                                        <button  name="btnAction" value="backstep2" class=" btn-block btn-lg btn btn-warning"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span> TRỞ VỀ</button>
                                                    </div>
                                                </form>
                                                <div class="col-md-4 col-sm-4"> </div>
                                                <div class="col-md-4 col-sm-4">
                                                    <button id="btnComplete" name="btnAction" value="complete" type="submit" class="btn-block btn-lg btn btn-info" >KÝ GỬI <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span></button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END DIV STEP3 -->


            </div>
        </div>
    </jsp:body>
</template:consign>
<script type="text/javascript">
    var RecaptchaOptions = {
        theme: 'custom',
        custom_theme_widget: 'recaptcha_widget'
    };

    $(function () {
//        $('#txtFromDate').datepicker();
//        $('#txtToDate').datepicker();
        if ($('#txtPhone').val().contains("+84")) {
            var phone = $('#txtPhone').val();
            phone = "0" + phone.substring(3);
            $('#txtPhone').val(phone);
        }
    });

    $("#btnComplete").click(function () {
        $("#form3").submit();
    });

//    $('input:radio[name="rdContact"]').change(function () {
//        if ($(this).val() == "phone") {
//            $("#divPhone").show();
//            $("#divEmail").hide();
//            $("#divEmail").val() == "";
//        }
//        else if ($(this).val() == "email") {
//            $("#divPhone").hide();
//            $("#divPhone").val() == "";
//            $("#divEmail").show();
//        }
//        else {
//            $("#divPhone").show();
//            $("#divEmail").show();
//        }
//
//    });

    $('input:radio[name="rdPayment"]').change(function () {
        if ($(this).val() == "cc") {
            $("#divCCNumber").show();
        }
        else {
            $("#divCCNumber").hide();

        }
    });

    function validation() {
        if (jQuery("#form3").context.activeElement.value == 'backstep2') {
            return true;
        }
        var check = true;
        var dateError = "";

        if ($('#txtFullName').val().trim().length < 5 || $('#txtFullName').val().trim().length > 50) {
            $('#erFullName').html("<font color='red'>Yêu cầu 5-50 ký tự</font>");
            check = false;
        }
        else {
            $('#erFullName').html("");
        }

        var fromDate = $('#txtFromDate').val().trim();
        var toDate = $('#txtToDate').val().trim();
        if (fromDate.length == 0) {
            dateError += '<font color="red">Xin chọn "từ ngày"</font> ';
        }
        if (toDate.length == 0) {
            if (dateError.length > 0) {
                dateError += '<font color="red">và "ngày cuối"</font>';
            } else {
                dateError += '<font color="red">Xin chọn "đến ngày"</font>';
            }
        }
        if (dateError.length > 0) {
            $('#erDate').html(dateError);
            check = false;
        } else {
            $('#erDate').html("");
        }

        if ($('#txtPhone').val().trim().length < 10) {
            $('#erPhone').html("<font color='red'>Xin nhập số điện thoại ít nhất 10 chữ số</font>");
            check = false;
        }
        else {
            $('#erPhone').html("");
        }

        var payment = $('input:radio[name="rdPayment"]:checked').val();
        if (payment == "cc") {
            if ($('#txtPaypalAccount').val().trim().length == 0) {
                $('#erPaypalAccount').html("<font color='red'>Xin nhập tài khoản</font>");
                check = false;
            }
            else {
                $('#erPaypalAccount').html("");
            }
        }

        if ($('#txtImage').val() == "") {
            $('#erImage').html("<font color='red'>Xin đăng ảnh thật của sản phẩm</font>");
            check = false;
        } else {
            $('#erImage').html("");
        }
        return check;
    }


    // This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.

</script>
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->
<script>
    // This example displays an address form, using the autocomplete feature
    // of the Google Places API to help users fill in the information.

    var placeSearch, autocomplete;
    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
    };

    function initialize_googleMap() {
        // Create the autocomplete object, restricting the search
        // to geographical location types.
        autocomplete = new google.maps.places.Autocomplete(
                /** @type {HTMLInputElement} */(document.getElementById('addressInput')),
                {types: ['geocode']});
        // When the user selects an address from the dropdown,
        // populate the address fields in the form.
//        google.maps.event.addListener(autocomplete, 'place_changed', function () {
//            fillInAddress();
//        });
    }

    // [START region_fillform]
    function fillInAddress() {
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();

        for (var component in componentForm) {
            document.getElementById(component).value = '';
            document.getElementById(component).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
            var addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
                var val = place.address_components[i][componentForm[addressType]];
                document.getElementById(addressType).value = val;
            }
        }
    }
    // [END region_fillform]

    // [START region_geolocation]
    // Bias the autocomplete object to the user's geographical location,
    // as supplied by the browser's 'navigator.geolocation' object.
    function geolocate() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var geolocation = new google.maps.LatLng(
                        position.coords.latitude, position.coords.longitude);
                var circle = new google.maps.Circle({
                    center: geolocation,
                    radius: position.coords.accuracy
                });
                autocomplete.setBounds(circle.getBounds());
            });
        }
    }
    // [END region_geolocation]

</script>
