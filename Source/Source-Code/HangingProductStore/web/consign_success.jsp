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


                <!-- BEGIN DIV STEP2 -->

                <div id="divStep2" class="row" >

                    <div class="portlet box " id="form_wizard_1">

                        <div class="portlet-body form">
                            <div  class="form-horizontal" id="submit_form">
                                <div class="form-wizard">
                                    <div class="form-body">
                                        <ul class="nav nav-pills nav-justified steps">
                                            <li class="done">
                                                <a id="ltap1" class="step" >
                                                    <span class="number">
                                                        1 </span>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Kiểm tra sản phẩm </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a id="ltap2" class="step">
                                                    <span class="number">
                                                        2 </span>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i> Chọn cửa hàng </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a id="ltap3" class="step">
                                                    <span class="number">
                                                        3 </span>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin chi tiết </span>
                                                </a>
                                            </li>

                                        </ul>
                                        <!-- <div id="bar" class="progress progress-striped" role="progressbar">
                                                <div class="progress-bar progress-bar-success">
                                                </div>
                                        </div> -->

                                        <div class="tab-content" style="text-align: center" >
                                            <h3>Yêu cầu ký gửi của bạn đã được gửi!</h3>
                                            <h3><b>${sessionScope.storeName}</b> sẽ liên lạc với bạn ngay khi có thể.</h3>
                                            <c:if test="${empty sessionScope.MEMBER}">
                                                <h3>Mã ký gửi của bạn là <b>[${sessionScope.trackId}]</b>. Bạn có thể dùng mã này để kiểm tra trạng thái hàng ký gửi.</h3>
                                            </c:if>
                                            <h3>Nhấn vào <a href="TrackProductStatus">đây</a> để kiểm tra.</h3>

                                        </div>
                                    </div>
                                    <div class="form-action" style="
                                         padding-top: 5px;
                                         padding-bottom: 5px;
                                         padding-right: 5px;
                                         padding-left: 5px;
                                         ">
                                        <div class="row">
                                            <div class="col-sm-4"> 

                                            </div>
                                            <div class="col-sm-4"> </div>
                                            <div class="col-sm-4">

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

