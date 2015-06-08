<%-- 
    Document   : consign_step2
    Created on : May 30, 2015, 9:31:33 PM
    Author     : Robingios
--%>

<template:consignbasic htmlTitle="Consign" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
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
    </jsp:attribute>
    <jsp:body>


        <!-- BEGIN PAGE CONTENT-->


        <!-- BEGIN DIV STEP2 -->
        <form action="ConsignServlet" method="POST" onsubmit="return validation()">
            <div id="divStep2" class="row" >

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
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i> Product's info </span>
                                            </a>
                                        </li>
                                        <li class="active">
                                            <a id="ltap2" class="step">
                                                <span class="number">
                                                    2 </span>
                                                <span class="desc" >
                                                    <i class="fa fa-check"></i> <b style="font-size:125%"> Choose store </b> </span>
                                            </a>
                                        </li>
                                        <li >
                                            <a id="ltap3" class="step">
                                                <span class="number">
                                                    3 </span>
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i> Personal info </span>
                                            </a>
                                        </li>

                                    </ul>

                                    <hr/>
                                    <c:set var="data" value="${sessionScope.STORELIST}"/>
                                    <c:set var="price" value="${sessionScope.PRICE}"/>
                                    <c:set var="store" value="${sessionScope.STORE}"/>
                                    <div class="tab-content ">
                                        <c:if test="${price == 0}">
                                            <div class="alert alert-warning" style="text-align: center">
                                                <strong>We could not find your product. Store owner will check and price your product later.</strong>
                                            </div>    
                                        </c:if>
                                        <div>



                                            <c:if test="${not empty data}">

                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr >
                                                            <th>
                                                                Store name
                                                            </th>
                                                            <th>
                                                                Address
                                                            </th>
<!--                                                            <th>
                                                                Reliability
                                                            </th>-->
                                                            <c:if test="${price != 0}">
                                                                <th>
                                                                    Price
                                                                </th>
                                                            </c:if>
                                                            <th style="text-align:center">

                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="item" items="${data}" varStatus="count">     
                                                            <tr>
                                                                <td>
                                                                    ${item.name}
                                                                </td>
                                                                <td>
                                                                    ${item.address}
                                                                </td>

<!--                                                                <td>
                                                                    
                                                                </td>-->
                                                                <c:if test="${price != 0}">
                                                                    <td>
                                                                        <fmt:formatNumber 
                                                                            value="${price - (item.formula/100) * price}" 
                                                                            maxFractionDigits="3"/> ~ <fmt:formatNumber 
                                                                            value="${price + (item.formula/100) * price }" 
                                                                            maxFractionDigits="3"/>

                                                                    </td>
                                                                </c:if>
                                                                <td align="center">
                                                                    <c:if test="${not empty store}">
                                                                        <c:if test="${store == item.storeOwnerID}">
                                                                            <input checked="checked"  name="rdStore" value="${item.storeOwnerID}" type="radio"/>
                                                                        </c:if>
                                                                        <c:if test="${store != item.storeOwnerID}">
                                                                            <input  name="rdStore" value="${item.storeOwnerID}" type="radio"/>
                                                                        </c:if>
                                                                    </c:if>
                                                                    <c:if test="${empty store}">
                                                                        <input  name="rdStore" value="${item.storeOwnerID}" type="radio"/>
                                                                    </c:if>

                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

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
                                    <div class="row">
                                        <div class="col-sm-4"> 
                                            <button name="btnAction" type="submit" value="backstep1"  class=" btn-block btn-lg btn btn-primary"><i class="m-icon-big-swapleft m-icon-white"></i>BACK</button>
                                        </div>
                                        <div class="col-sm-4"> </div>
                                        <div class="col-sm-4">
                                            <button  name="btnAction" value="tostep3" type="submit" class="btn-block btn-lg btn btn-primary" >NEXT <i class="m-icon-big-swapright m-icon-white"></i></button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </form>
        <!-- END DIV STEP2 -->



    </jsp:body>
</template:consignbasic>
<script type="text/javascript">
    var RecaptchaOptions = {
        theme: 'custom',
        custom_theme_widget: 'recaptcha_widget'
    };
    
    

    function validation() {
//        var val = $("input[type=submit][clicked=true]").val();
//        alert(val);
        if (!$("input:radio[name='rdStore']").is(":checked")) {
            alert("Please choose a store");
            return false;
        }
        

    }



</script>
