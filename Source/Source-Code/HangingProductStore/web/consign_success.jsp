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
                                                        1 </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin sản phẩm </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step" >
                                                    <span class="number">
                                                        2 </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Kiểm tra sản phẩm </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step">
                                                    <span class="number">
                                                        3 </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i> Chọn cửa hàng </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a class="step">
                                                    <span class="number">
                                                        4 </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin chi tiết </span>
                                                </a>
                                            </li>

                                        </ul>
                                        <!-- <div id="bar" class="progress progress-striped" role="progressbar">
                                                <div class="progress-bar progress-bar-success">
                                                </div>
                                        </div> -->

                                        <div class="tab-content" style="text-align: justify" >
                                            <h3 class="alert alert-success" align="center" style="color: green"><b>GỬI YÊU CẦU KÝ GỬI THÀNH CÔNG</b></h3>
                                            <h3 style="padding-left: 20%"><b>Sản phẩm:</b> ${CONSIGNMENT.product.name}</h3>
                                                <h3 style="padding-left: 20%"><b>Giá mong muốn:</b> <fmt:formatNumber 
                                                        value="${CONSIGNMENT.desirePrice}" 
                                                        maxFractionDigits="0" /> đồng.</h3>
                                                <h3 style="padding-left: 20%"><b>Mã ký gửi:</b> <b>[<a href="TrackProductStatus?searchValue=${CONSIGNMENT.consigmentID}&btnAction=search"><font color="blue">${CONSIGNMENT.consigmentID}</font></a>]</b>.</h3>
                                                <h3 style="padding-left: 20%"><b>Cửa hàng ký gửi:</b> ${STOREOWNER.fullName}.</h3>
                                            <h3 align="center">Cửa hàng sẽ xem xét yêu cầu của bạn và định giá sản phẩm chính xác khi nhận hàng.</h3>

                                            

<!--                                            <h3>Nhấn vào <b><a href="TrackProductStatus?searchValue=${CONSIGNMENT.consigmentID}&btnAction=search"><font color="blue">đây </font></a></b> để kiểm tra.</h3>-->
                                            <h3 align="center">Nhấn vào <b><a href="ConsignServlet"><font color="blue">đây </font></a></b>để ký gửi món khác.</h3>
                                            </div>
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

