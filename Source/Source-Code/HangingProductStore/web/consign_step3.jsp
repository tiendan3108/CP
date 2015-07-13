<%-- 
    Document   : consign_step3
    Created on : May 30, 2015, 9:32:08 PM
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

    </jsp:attribute>

    <jsp:body>

        <div id="wrapper">
            <div class="row margin-bottom-40">

                <!-- BEGIN PAGE CONTENT-->


                <!-- BEGIN DIV STEP2 -->

                <div id="divStep2" class="row" >
                    <form id="form3"  action="ConsignServlet" method="POST" onsubmit="return validation();">
                        <div class="portlet box" id="form_wizard_1">

                            <div class="portlet-body form">
                                <div  class="form-horizontal" id="submit_form">
                                    <div class="form-wizard">
                                        <div class="form-body">
                                            <ul class="nav nav-pills nav-justified steps">
                                                <li class="done">
                                                    <a id="ltap1"  class="step" >
                                                        <span class="number">
                                                            1 </span>
                                                        <br/>
                                                        <span class="desc">
                                                            <i class="fa fa-check"></i> Thông tin sản phẩm</span>
                                                    </a>
                                                </li>
                                                <li class="done">
                                                    <a class="step">
                                                        <span class="number">
                                                            2 </span>
                                                        <br/>
                                                        <span class="desc" >
                                                            <i class="fa fa-check"></i> Kiểm tra sản phẩm</span>
                                                    </a>
                                                </li>
                                                <li class="active">
                                                    <a id="ltap3" class="step">
                                                        <span class="number">
                                                            3 </span>
                                                        <br/>
                                                        <span class="desc" >
                                                            <i class="fa fa-check"></i><b> Chọn cửa hàng</b></span>
                                                    </a>
                                                </li>
                                                <li >
                                                    <a id="ltap4" class="step">
                                                        <span class="number">
                                                            4 </span>
                                                        <br/>
                                                        <span class="desc">
                                                            <i class="fa fa-check"></i> Thông tin chi tiết</span>
                                                    </a>
                                                </li>

                                            </ul>

                                            <c:set var="data" value="${sessionScope.STORELIST}"/>
                                            <c:set var="basicPrice" value="${sessionScope.BASICPRICE}"/>
                                            <c:set var="store" value="${sessionScope.STORE}"/>
                                            <div class="tab-content ">
                                                <c:if test="${basicPrice <= 0}">
                                                    <div class="alert alert-danger" style="text-align: center">
                                                        <strong>Chúng tôi không thể tìm thấy sản phẩm của bạn. Cửa hàng sẽ lưu lại yêu cầu ký gửi này và định giá sản phẩm của bạn khi đến nhận hàng.</strong>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${basicPrice > 0}">
                                                    <div class="alert alert-warning" style="text-align: center">
                                                        <strong>Giá cửa hàng đề nghị có thể không chính xác. Cửa hàng sẽ kiểm tra và định giá chính xác khi đến nhận hàng</strong>
                                                    </div>    
                                                </c:if>

                                                <div>



                                                    <c:if test="${not empty data}">

                                                        <!--                                                    <form id="form3"  action="ConsignServlet" method="POST">-->
                                                        <table class="table table-striped table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>STT</th>
                                                                    <th>
                                                                        Tên cửa hàng
                                                                    </th>
                                                                    <th>
                                                                        Địa chỉ
                                                                    </th>
                                                                    <!--                                                            <th>
                                                                                                                                    Reliability
                                                                                                                                </th>-->
                                                                    <th>
                                                                        Giá (Ngàn đồng)
                                                                    </th>

                                                                    <th style="text-align:center">

                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>                                                                 


                                                                <c:forEach var="item" items="${data}" varStatus="count">
                                                                    <!--                                                    <form id="form2"  action="ConsignServlet" method="POST" onsubmit="return validation(this)">-->

                                                                    <tr>
                                                                        <td><c:out value="${count.count}" /></td>
                                                                        <td>
                                                                            ${item.fullName}
                                                                        </td>
                                                                        <td>
                                                                            ${item.address}
                                                                        </td>

                                                                        <!--                                                                <td>
                                                                                                                                            
                                                                                                                                        </td>-->
                                                                        <td>
                                                                            <c:if test="${basicPrice > 0}">

                                                                                <fmt:parseNumber var="minPrice" type="number" integerOnly="true" value="${(basicPrice * 60/100) * ( 1 - item.formula/100) / 1000}" />
                                                                                <fmt:parseNumber var="maxPrice" type="number" integerOnly="true" value="${(basicPrice * 60/100) * ( 1 + item.formula/100) / 1000}" />
                                                                                <fmt:formatNumber type="number"
                                                                                                  value="${minPrice}" 
                                                                                                  maxFractionDigits="0" /> &nbsp; ~ &nbsp; <fmt:formatNumber 
                                                                                                  value="${maxPrice}" 
                                                                                                  maxFractionDigits="0" /> &nbsp; 

                                                                            </c:if>
                                                                            <c:if test="${basicPrice <= 0}">
                                                                                <font color="red">Thương lượng </font>
                                                                            </c:if>
                                                                        </td>
                                                                        <td align="center">
                                                                            <c:if test="${not empty store}">
                                                                                <c:if test="${store == item.roleID}">
                                                                                    <input checked="checked"  name="rdStore" value="${item.roleID}" type="radio"/>
                                                                                </c:if>
                                                                                <c:if test="${store != item.roleID}">
                                                                                    <input  name="rdStore" value="${item.roleID}" type="radio"/>
                                                                                </c:if>
                                                                            </c:if>
                                                                            <c:if test="${empty store}">
                                                                                <input  name="rdStore" value="${item.roleID}" type="radio"/>
                                                                            </c:if>

                                                                        </td>
                                                                    </tr>

                                                                </c:forEach>
                                                                <!--                                                            <input type="hidden" name="btnAction" value="tostep3"/>-->
                                                            </tbody>
                                                        </table>
                                                        <!--                                                    </form>-->
                                                    </c:if>
                                                    <c:if test="${empty data}">
                                                        <h2 align="center">Không có cửa hàng nào nhận ký gửi loại sản phẩm này.</h2>
                                                    </c:if>

                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-actions" style="
                                             padding-top: 5px;
                                             padding-bottom: 5px;
                                             padding-right: 5px;
                                             padding-left: 5px;
                                             ">
                                            <!--                                        <form id="form3"  action="ConsignServlet" method="POST">-->
                                            <div class="row">
                                                <div class="col-md-4 col-sm-4"> 
                                                    <button id="btnBack"  name="btnAction" type="submit" value="backstep2" class="btn-block btn-lg btn btn-warning"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span> QUAY LẠI</button> <!--<i class="m-icon-big-swapleft m-icon-white"></i> -->
                                                </div>
                                                <c:if test="${not empty sessionScope.STORELIST}">
                                                    <div class="col-md-4 col-sm-4"> </div>
                                                    <div class="col-md-4 col-sm-4">
                                                        <button id="btnNext"  name="btnAction" value="tostep4" type="submit" class="btn-block btn-lg btn btn-info" >NEXT   <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span></button> <i class="m-icon-big-swapright m-icon-white"></i> 
                                                    </div>
                                                </c:if>
                                            </div>
                                            <!--                                        </form>-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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
    function validation() {
        if (jQuery("#form3").context.activeElement.value == 'tostep4') {
            if (!$("input:radio[name='rdStore']").is(":checked")) {
                alert("Xin chọn cửa hàng");
                return false;
            }
        }
    }
//    $('input[type=radio][name="rdStore"]').click(function () {
//        $(this).closest("form").submit();
//    });


</script>

