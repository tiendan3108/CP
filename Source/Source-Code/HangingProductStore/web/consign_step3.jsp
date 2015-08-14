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
                    <!--                    <form id="form3"  action="ConsignServlet" method="POST" onsubmit="return validation();">-->
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
                                            <li class="done">
                                                <a class="step">
                                                    <span class="number">
                                                        <b>2</b> </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i> Kiểm tra sản phẩm</span>
                                                </a>
                                            </li>
                                            <li class="active">
                                                <a id="ltap3" class="step">
                                                    <span class="number">
                                                        <b>3</b> </span>
                                                    <br/>
                                                    <span class="desc" >
                                                        <i class="fa fa-check"></i><b> Chọn cửa hàng</b></span>
                                                </a>
                                            </li>
                                            <li >
                                                <a id="ltap4" class="step">
                                                    <span class="number">
                                                        <b>4</b> </span>
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
                                            <c:if test="${not empty data}">
                                                <c:if test="${basicPrice <= 0}">
                                                    <div class="alert alert-danger" style="text-align: center">
                                                        <i class="fa-lg fa fa-warning"></i><strong>Chúng tôi không xác định sản phẩm của bạn. Cửa hàng sẽ lưu lại yêu cầu ký gửi này và định giá chính xác tùy theo tình trạng sản phẩm khi nhận hàng.</strong>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${basicPrice > 0}">
                                                    <div class="alert alert-warning" style="text-align: center">
                                                        <strong>Giá đề nghị là dành cho sản phẩm mới. Cửa hàng sẽ kiểm tra và định giá chính xác tùy theo tình trạng của sản phẩm khi nhận hàng.</strong>
                                                    </div>    
                                                </c:if>
                                            </c:if>
                                            <div>



                                                <c:if test="${not empty data}">

                                                    <!--                                                    <form id="form3"  action="ConsignServlet" method="POST">-->
                                                    <table class="table table-hover" style="font-size: 110%">
                                                        <thead style="border-bottom-style: solid">
                                                            <tr>
                                                                <th>STT</th>
                                                                <th>
                                                                    Tên cửa hàng
                                                                </th>
                                                                <th>Điện thoại</th>
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
                                                                    <td>${item.phone}</td>
                                                                    <td>
                                                                        ${item.address}
                                                                    </td>

                                                                    <!--                                                                <td>
                                                                                                                                        
                                                                                                                                    </td>-->
                                                                    <td>
                                                                        <c:if test="${basicPrice > 0}">


                                                                            <fmt:formatNumber type="number"
                                                                                              value="${item.minPrice}" 
                                                                                              maxFractionDigits="0" /> &nbsp; ~ &nbsp; <fmt:formatNumber 
                                                                                              value="${item.maxPrice}" 
                                                                                              maxFractionDigits="0" /> &nbsp; 

                                                                        </c:if>
                                                                        <c:if test="${basicPrice <= 0}">
                                                                            <font color="red">Thương lượng </font>
                                                                        </c:if>
                                                                    </td>
                                                                    <td align="center">
                                                                        <c:if test="${not empty store}">
                                                                            <c:choose>
                                                                                <c:when test="${store == item.roleID}">
                                                                                    <input checked="checked"  name="rdStore" value="${item.roleID}" type="radio"/>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input  name="rdStore" value="${item.roleID}" type="radio"/>    
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                                        </c:if>
                                                                        <c:if test="${empty store}">
                                                                            <c:choose>
                                                                                <c:when test="${count.count == 1}">
                                                                                    <input  name="rdStore" value="${item.roleID}" type="radio" checked/>        
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input  name="rdStore" value="${item.roleID}" type="radio"/>        
                                                                                </c:otherwise>
                                                                            </c:choose>

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
                                                    <h3 align="center">Hiện không có cửa hàng nào nhận ký gửi loại sản phẩm này.</h3>
                                                    <h3 align="center">Chúng tôi rất tiếc vì điều này.</h3>
                                                    <h3 align="center"> Xin nhấn vào <a href="ConsignServlet"><font color="blue">đây</font></a> để ký gửi sản phẩm khác.</h3>
                                                        </c:if>

                                            </div>

                                        </div>
                                    </div>


                                    <div class="row">

                                        <div class="col-md-4 col-sm-4"> 
                                            <form id="form3"  action="ConsignServlet" method="POST">
                                                <button id="btnBack"  name="btnAction" type="submit" value="backstep2" class="btn-block btn-lg btn btn-warning"><i class="m-icon-big-swapleft m-icon-white"></i>  QUAY LẠI</button> <!--<i class="m-icon-big-swapleft m-icon-white"></i> -->
                                            </form>
                                        </div>
                                        <c:if test="${not empty sessionScope.STORELIST}">
                                            <div class="col-md-4 col-sm-4"> </div>
                                            <div class="col-md-4 col-sm-4">
                                                <button id="btnNext" class="btn-block btn-lg btn btn-info" >BƯỚC KẾ <i class="m-icon-big-swapright m-icon-white"></i> </button>
                                            </div>
                                        </c:if>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                    <!--                    </form>-->
                </div>


                <div id="modalConfirm" data-backdrop="static" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="modal-title" style="font-weight: bold">LƯU Ý</h3>
                            </div>
                            <div class="modal-body">
                                <div class="form-horizontal" style="font-size: 120%">
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Yêu cầu ký gửi này sẽ được gửi đến chủ cửa hàng.</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Chủ cửa hàng có thể <b>đồng ý</b> hoặc <b>từ chối</b> yêu cầu của bạn.</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Nếu đồng ý, sản phẩm sẽ được chủ cửa hàng định giá khi nhận hàng.</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Khi đã nhận hàng, nếu món hàng chưa được đặt, bạn có thể yêu cầu hủy ký gửi nhưng phải <b>trả phí lưu kho</b> do chủ cửa hàng quy định.</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Khi món hàng hết hạn, cửa hàng sẽ thông báo cho bạn. Bạn có thể nhận lại hàng trong <b>3 ngày</b>. Sau <b>3 ngày</b>, cửa hàng sẽ tính phí lưu kho. Bạn cũng có thể yêu cầu gia hạn ký gửi.</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 col-sm-1 col-md-offset-1 col-sm-offset-1"><i class="fa fa-asterisk"></i></div>
                                        <div class="col-md-9 col-sm-9">Nếu món hàng bị hư hỏng sau khi cửa hàng đã nhận hàng, cửa hàng sẽ đền bù cho bạn bằng với số tiền đã thỏa thuận.</div>
                                    </div>


                                </div>
                            </div>
                            <div class="modal-footer">
                                <button id="btnConfirmRule" class="btn btn-info">Đồng ý</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button> 

                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal --> 
                <!-- END DIV STEP2 -->

                <!--BEGIN MODAL-->

                <div id="modalDesirePrice" data-backdrop="static" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" style="font-weight: bold">NHẬP GIÁ MONG MUỐN</h4>
                            </div>
                            <div class="modal-body" style="height:100px">
                                <form id="formDesirePrice">
                                    <div class="form-horizontal">

                                        <div class="form-group">
                                            <label class="col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1 control-label">Giá mong muốn <font color="red"> </font></label>
                                            <div class="col-md-5 col-sm-5">
                                                <input id="inputDesirePrice" name="txtDesirePrice" type="text" class="form-control" value="${DESIREPRICE}"/>
                                                <p class="help-block" id="erDesirePrice">
                                                </p>
                                            </div>
                                            <div class="col-md-3 col-sm-3" style="padding-top: 8px; font-size: 110%">
                                                Ngàn đồng
                                            </div>
                                            <div class="col-md-3 col-sm-3" style="padding-top: 8px; font-size: 110%">

                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" id="txtStore" name="txtStore" value="${STORE}"/>
                                    <input type="hidden" name="btnAction" value="tostep4" />
                                </form>
                            </div>

                            <div class="modal-footer">
                                <input id="maxPrice" type="hidden"/>
                                <button id="btnConfirm" class="btn btn-info">Xác nhận</button>
                                <button  data-dismiss="modal" class="btn btn-default">Đóng</button> 
                            </div>

                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->

                <!--END MODAL-->



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

        if (!$("input:radio[name='rdStore']").is(":checked")) {
            alert("Xin chọn cửa hàng");
            return false;
        }

        return true;
    }
    $('#btnNext').click(function () {

        if ($("input:radio[name='rdStore']").is(":checked")) {
            $("#txtStore").val($('input:radio[name="rdStore"]:checked').val());
            $("#erDesirePrice").html("");
            var price = $('input:radio[name="rdStore"]:checked').parent().prev().text().trim();
            if (price.indexOf("~") >= 0) {
                $("#maxPrice").val(price.split("~").pop().trim().replace(",", ""));
            } else {
                $("#maxPrice").val("");
            }

            //$("#modalDesirePrice").modal("show");
            $("#modalConfirm").modal("show");   

        } else {
            alert("Xin chọn cửa hàng");
        }
    });

    $('#btnConfirm').click(function () {
        var desirePrice = $("#inputDesirePrice").val();
        var maxPrice = $("#maxPrice").val();
        if ($("#inputDesirePrice").val().length == 0) {
            $("#erDesirePrice").html("<font color='red'>Xin nhập giá mong muốn</font");
        } else {

            if (isNaN(desirePrice)) {
                $("#erDesirePrice").html("<font color='red'>Xin nhập đúng số</font");
            } else {
                var desireNum = parseFloat(desirePrice);
                if (desireNum > 0) {
                    if (maxPrice.length > 0 && !isNaN(maxPrice)) {
                        var maxNum = parseFloat(maxPrice);
                        if (desireNum > maxNum) {
                            $("#erDesirePrice").html("<font color='red'>Giá bạn chọn phải nhỏ hơn hoặc bằng giá tối đa tìm được</font");
                        } else {
                            $("#erDesirePrice").html("");
                            $("#formDesirePrice").submit();
                            //$("#modalConfirm").modal("show");
                        }
                    } else {
                        $("#erDesirePrice").html("");
                        $("#formDesirePrice").submit();
                        //$("#modalConfirm").modal("show");
                    }
                } else {
                    $("#erDesirePrice").html("<font color='red'>Giá phải lớn hơn 0</font");
                }
            }
        }
    });
    
    $("#btnConfirmRule").click(function () {
        //$("#formDesirePrice").submit();
            $("#modalDesirePrice").modal("show");
    });
//    $('input[type=radio][name="rdStore"]').click(function () {
//        $(this).closest("form").submit();
//    });
    $("table tr").click(function () {
        $(this).children("td:last").children("input").attr("checked", true);
    });

</script>

