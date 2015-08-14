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

    </jsp:attribute>

    <jsp:body>

        <div id="wrapper">
            <div class="row margin-bottom-40">

                <!-- BEGIN PAGE CONTENT-->


                <!-- BEGIN DIV STEP2 -->

                <div id="divStep2" class="row">
                    <!--                    <form id="form2"  action="ConsignServlet" method="POST" onsubmit="return validation();">-->
                    <div class="portlet box" id="form_wizard_1">

                        <div class="portlet-body form">
                            <div  class="form-horizontal" id="submit_form">
                                <div class="form-wizard">
                                    <div class="form-body">
                                        <ul class="nav nav-pills nav-justified steps">
                                            <li class="done">
                                                <a id="ltap1"  class="step" >
                                                    <span class="number">
                                                        <b>1</b> </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin sản phẩm</span>
                                                </a>
                                            </li>
                                            <li class="active">
                                                <a id="ltap2" class="step">
                                                    <span class="number">
                                                        <b>2</b> </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i><b> Kiểm tra sản phẩm</b></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="step">
                                                    <span class="number">
                                                        <b>3</b> </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i> Chọn cửa hàng</span>
                                                </a>
                                            </li>
                                            <li >
                                                <a class="step">
                                                    <span class="number">
                                                        <b>4</b> </span>
                                                    <br/>
                                                    <span class="desc">
                                                        <i class="fa fa-check"></i> Thông tin chi tiết</span>
                                                </a>
                                            </li>

                                        </ul>

                                        <c:set var="data" value="${AMAZONLIST}"/>

                                        <div class="tab-content ">
                                            <div class="alert alert-warning" style="text-align: center">
                                                <strong>Nếu không tìm thấy sản phẩm của bạn, có thể bạn đã nhập sai tên. Vui lòng nhấn quay lại để sửa thông tin.</strong>
                                            </div> 
                                            <div>



                                                <c:if test="${not empty data}">

                                                    <!--                                                    <form id="form2"  action="ConsignServlet" method="POST">-->
                                                    <table class="table table-hover" style="font-size: 110%">
                                                        <thead style="border-bottom-style: solid">
                                                            <tr>
                                                                <th style="width: 10px">STT</th>
                                                                <th align="center" style="width: 200px">
                                                                    Hình ảnh
                                                                </th>
                                                                <th >
                                                                    Tên sản phẩm
                                                                </th>

                                                                <th style="text-align:center">

                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>                                                                 


                                                            <c:forEach var="item" items="${data}" varStatus="count">
                                                                <!--                                                    <form id="form2"  action="ConsignServlet" method="POST" onsubmit="return validation(this)">-->

                                                                <tr>
                                                                    <td style="font-weight: bold"><c:out value="${count.count}" /></td>

                                                                    <td>
<!--                                                                        <a name="amazonImage" style="color:blue" data-id="${item.image}" data-toggle="modal" data-target="#amazonModal">Xem ảnh</a>-->
                                                                        <img name="amazonImage"  src="${item.image}" alt="64x64" data-src="${item.image}" style="width: 64px; height: 64px;">
                                                                    </td>
                                                                    <td>
                                                                        ${item.name}
                                                                    </td>

                                                                    <td align="center">

                                                                        <c:if test="${not empty ASIN}">
                                                                            <c:choose>
                                                                                <c:when test="${ASIN == item.ASIN}">
                                                                                    <input checked="checked"  name="rdAmazon" value="${item.ASIN}" type="radio"/>    
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input  name="rdAmazon" value="${item.ASIN}" type="radio"/>    
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                                        </c:if>
                                                                        <c:if test="${empty ASIN}">
                                                                            <c:choose>
                                                                                <c:when test="${count.count == 1}">
                                                                                    <input  name="rdAmazon" value="${item.ASIN}" type="radio" checked="checked"/>        
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input  name="rdAmazon" value="${item.ASIN}" type="radio"/>
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                                        </c:if>

                                                                    </td>
                                                                </tr>

                                                            </c:forEach>
                                                            <!--                                                            <input type="hidden" name="btnAction" value="tostep3"/>-->

                                                            <tr>
                                                        <form action="ConsignServlet" method="POST">
                                                            <td colspan="4"><button name="btnAction" value="tostep3" class="btn btn-block blue-dark">Không phải sản phẩm của bạn?</button></td>
                                                        </form> 
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                    <!--                                                    </form>-->


                                                    <div id="amazonModal" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header" style="background-color: ivory">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                    <h3 class="modal-title"><b>Ảnh sản phẩm</b></h3>
                                                                </div>
                                                                <div class="modal-body" align="center">
                                                                    <img id="modalImage" style="max-height: 400px"/>
                                                                </div>
                                                                <div class="modal-footer" style="background-color: ivory">
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>

                                                                </div>
                                                            </div><!-- /.modal-content -->
                                                        </div><!-- /.modal-dialog -->
                                                    </div><!-- /.modal -->

                                                </c:if>
                                                <c:if test="${empty data}">
                                                    <div class="alert alert-warning" style="text-align: center">
                                                        <strong>Chúng tôi không thể tìm thấy thông tin sản phẩm của bạn. Cửa hàng sẽ lưu lại yêu cầu ký gửi này và định giá sản phẩm của bạn khi đến nhận hàng.</strong>
                                                    </div>
                                                </c:if>

                                            </div>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <form id="form2"  action="ConsignServlet" method="POST" onsubmit="return validation()">

                                            <div class="col-sm-4"> 
                                                <button id="btnBack"  name="btnAction" type="submit" value="backstep1" class="btn-block btn-lg btn btn-warning">
                                                    <i class="m-icon-big-swapleft m-icon-white"></i> QUAY LẠI</button> 
                                            </div>
                                            <div class="col-sm-4"> </div>
                                            <div class="col-sm-4">
                                                <button id="btnNext"  name="btnAction" value="tostep3" type="submit" class="btn-block btn-lg btn btn-info" >BƯỚC KẾ <i class="m-icon-big-swapright m-icon-white"></i></button> 
                                            </div>
                                            <input type="hidden" id="txtAmazon" name="rdAmazon" value="${ASIN}"/>


                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--                    </form>-->
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
    $(document).ready(function () {
    });

    function validation() {
        $('#txtAmazon').val($('input:radio[name="rdAmazon"]:checked').val());
        if (jQuery("#form2").context.activeElement.value == 'tostep3') {
//            if (!$("input:radio[name='rdAmazon']").is(":checked")) {
//                alert("Xin chọn sản phẩm");
//                return false;
//                
//            }
            if ($('#txtAmazon').val() == "") {
                alert("Xin chọn sản phẩm");
                return false;
            }
        }
        return true;
    }
    $('input[type=radio][name="rdAmazon"]').click(function () {
        //$(this).closest("form").submit();
//        $('#txtAmazon').val($(this).val());
    });


    $('img[name="amazonImage"]').click(function () {
//        alert($(this).data('src'));
//        var link = $(this).data('src');
        $("#modalImage").attr("src", $(this).data('src'));
        $("#amazonModal").modal("show");
    });

    $("table tr").click(function () {
        $(this).children("td:last").children("input").attr("checked", true);
    });


</script>
