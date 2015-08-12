<%-- 
    Document   : consign_success
    Created on : May 30, 2015, 9:32:27 PM
    Author     : Robingios
--%>

<%-- 
    Document   : consign_step2
    Created on : May 30, 2015, 9:31:33 PM
    Author     : Robingios
--%>

<template:consign htmlTitle="Consign" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>

    </jsp:attribute>
    <jsp:body>
        <div id="wrapper">
            <div class="row margin-bottom-40">

                <!-- BEGIN PAGE CONTENT-->


                <!-- BEGIN DIV STEP2 -->

                <div id="divStep2" class="row" >

                    <div class="portlet box " id="form_wizard_1">

                        <div class="portlet-body form">
                            <div  class="form-horizontal" id="submit_form">
                                <div class="form-wizard">
                                    <div class="form-body">
                                        <ul class="nav nav-pills nav-justified steps">
                                            <li class="done">
                                                <a class="step" >
                                                    <span class="number">
                                                        <b>1</b> </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin sản phẩm </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step" >
                                                    <span class="number">
                                                        <b>2</b> </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Kiểm tra sản phẩm </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step">
                                                    <span class="number">
                                                        <b>3</b> </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i> Chọn cửa hàng </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step">
                                                    <span class="number">
                                                        <b>4</b> </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin chi tiết </span>
                                                </a>
                                            </li>

                                        </ul>

                                        <div class="tab-content">
                                            <div class="form-horizontal" style="font-size: 120%">
                                                <h4 class="alert alert-success" style="text-align: center; font-weight: bold;width: 800px;margin:auto">ĐÃ GỬI YÊU CẦU THÀNH CÔNG.</h4>
                                                <div class="row">
                                                    <div class="col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1" style="text-align: right; font-weight: bold">Sản phẩm</div>
                                                    <div class="col-md-8 col-sm-8"><span style="font-weight: 600">${CONSIGNMENT.product.name}</span></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1" style="text-align: right; font-weight: bold">Giá mong muốn</div>
                                                    <div class="col-md-8 col-sm-8"><span style="font-weight: 600"><fmt:formatNumber 
                                                                value="${CONSIGNMENT.desirePrice}" 
                                                                maxFractionDigits="0" /> đồng</span></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1" style="text-align: right; font-weight: bold">Mã ký gửi</div>
                                                    <div class="col-md-8 col-sm-8"><span style="font-weight: 600">[<a href="TrackProductStatus?searchValue=${CONSIGNMENT.consigmentID}&btnAction=search"><font color="blue">${CONSIGNMENT.consigmentID}</font></a>]</span></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1" style="text-align: right; font-weight: bold">Cửa hàng ký gửi</div>
                                                    <div class="col-md-8 col-sm-8"><span style="font-weight: 600">${STOREOWNER.fullName}</span></div>
                                                </div>
                                                <h3 style="padding-left: 15%; font-weight: 500">Nhấn vào <b><a href="ConsignServlet"><font color="blue">đây </font></a></b>để ký gửi món khác.</h3>
                                            </div>
                                        </div>
                                        <!--                                        <div class="tab-content" style="text-align: justify" >
                                                                                    <h4 class="alert alert-success" style="text-align: center; font-weight: bold;width: 800px;margin:auto">ĐÃ GỬI YÊU CẦU THÀNH CÔNG.</h4>
                                                                                    <h4 style="padding-left: 15%"><b style="margin-right: 80px">Sản phẩm:</b> <span style="font-weight: 600">${CONSIGNMENT.product.name}</span></h4>
                                                                                    <h4 style="padding-left: 15%"><b style="margin-right: 25px">Giá mong muốn:</b> 
                                                                                            <span style="font-weight: 600"><fmt:formatNumber 
                                            value="${CONSIGNMENT.desirePrice}" 
                                            maxFractionDigits="0" /> đồng</span></h4>
                                        <h4 style="padding-left: 15%"><b style="margin-right: 81px">Mã ký gửi:</b> <span style="font-weight: 600">[<a href="TrackProductStatus?searchValue=${CONSIGNMENT.consigmentID}&btnAction=search"><font color="blue">${CONSIGNMENT.consigmentID}</font></a>]</span></h4>
                                        <h4 style="padding-left: 15%"><b style="margin-right: 24px">Cửa hàng ký gửi:</b> <span style="font-weight: 600">${STOREOWNER.fullName}</span></h4>

                       
                                <h3>Nhấn vào <b><a href="TrackProductStatus?searchValue=${CONSIGNMENT.consigmentID}&btnAction=search"><font color="blue">đây </font></a></b> để kiểm tra.</h3>
                                    <h3 style="padding-left: 15%; font-weight: 500">Nhấn vào <b><a href="ConsignServlet"><font color="blue">đây </font></a></b>để ký gửi món khác.</h3>
                                </div>-->
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- END DIV STEP2 -->


        </div>
    </div>
</jsp:body>
</template:consign>
<script type="text/javascript">
    var RecaptchaOptions = {
        theme: 'custom',
        custom_theme_widget: 'recaptcha_widget'
    };




</script>

