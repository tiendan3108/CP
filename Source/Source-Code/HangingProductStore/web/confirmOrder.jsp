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
    </jsp:attribute>
    <jsp:body> 
        <div id="wrapper">
            <div class="row margin-bottom-40">
                <c:set var="mess" value="${requestScope.MESS}"/>
                <c:if test="${not empty mess}">
                    <div class="alert alert-warning" style="text-align: left;font-weight: bold;font-size: 14px">
                        <strong>${mess}</strong>
                    </div>                  
                </c:if>               
                <h4>Bạn đã đặt món hàng:</h4>
                <div class="">                  
                    <div class="table-wrapper-responsive ">
                        <div class="goods-data clearfix ">
                            <c:set var="item" value="${requestScope.DATA}"/>
                            <c:if test="${not empty item}">
                                <div class="table-wrapper-responsive">
                                    <table>
                                        <tr style="font-weight: bold">
                                            <th>Nhãn hiệu</th>
                                            <th>Tên</th>                                                                         
                                            <th>chủ cửa hàng</th>
                                            <th>Địa chỉ</th>
                                            <th>Email</th>
                                            <th>Điện thoại</th>
                                        </tr>
                                        <tr style="font-weight: 500">
                                            <td>${item.brand}</td>
                                            <td>${item.productName}</td>
                                            <td>${item.address}</td>
                                            <td>${item.fullName}</td>
                                            <td>${item.phone}</td>
                                            <td>${item.email}</td>
                                        </tr>                                
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
                        <input name="productID" value="${item.productID}" hidden="true">
                        <c:if test="${not empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Tên<span class="require">*</span></label>
                                <div class="col-lg-3 col-md-4">
                                    <input min="4" required="true" value="${acc.fullName}" name="name" type="text" id="first-name" class="form-control">
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Email</label>
                                <div class="col-md-4 col-lg-4">
                                    <input value="${acc.email}" name="email" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Địa chỉ</label>
                                <div class="col-lg-3 col-md-4">
                                    <textarea  rows="3" name="address" type="text" class="form-control">${acc.address}</textarea>
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Sồ điện thoại <span class="require">*</span></label>
                                <div class="col-md-3">
                                    <input value="${acc.phone}" name="phone" required="true" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty acc}">
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Tên<span class="require">*</span></label>
                                <div class="col-lg-3 col-md-4">
                                    <input min="4" required="true" name="name" type="text" id="first-name" class="form-control">
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Email </span></label>
                                <div class="col-lg-4 col-md-4">
                                    <input name="email" type="text" id="first-name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label col-md-2">Địa chỉ</label>
                                <div class="col-lg-3 col-md-4">
                                    <textarea id="addressInput" rows="3" name="address" type="text" class="form-control"></textarea>
                                </div>
                                <label class="col-lg-2 control-label col-md-2" for="first-name">Số điện thoại <span class="require">*</span></label>
                                <div class="col-lg-4 col-md-4">
                                    <input maxlength="11" name="phone" required="true" type="number" class="form-control">
                                </div>
                            </div>
                        </c:if>                      
                        <div class="row">
                            <div class="col-lg-offset-10 col-md-offset-10 padding-left-0 padding-top-20">
                                <button class="btn btn-primary" type="submit">Xác Nhận</button>
                            </div>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </div>
</jsp:body>
</template:shopbasic>

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
