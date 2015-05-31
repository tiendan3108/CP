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
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i> Product's info </span>
                                            </a>
                                        </li>
                                        <li class="done">
                                            <a id="ltap2" class="step">
                                                <span class="number">
                                                    2 </span>
                                                <span class="desc" >
                                                    <i class="fa fa-check"></i> <b style="font-size:125%"> Choose store </b> </span>
                                            </a>
                                        </li>
                                        <li class="done">
                                            <a id="ltap3" class="step">
                                                <span class="number">
                                                    3 </span>
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i> Personal info </span>
                                            </a>
                                        </li>

                                    </ul>
                                    <!-- <div id="bar" class="progress progress-striped" role="progressbar">
                                            <div class="progress-bar progress-bar-success">
                                            </div>
                                    </div> -->
                                    <hr/>
                                    <div class="tab-content" style="text-align: center" >
                                        <h3>Your consign request has been sent!</h3>
                                        <h3><b>${requestScope.storeName}</b> will contact you later.</h3>
                                        <h3>Your product's code is <b>[${requestScope.trackId}]</b>. Use this to track your product's status.</h3>
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
        
</form>
        <!-- END DIV STEP2 -->



    </jsp:body>
</template:consignbasic>
<script type="text/javascript">
    var RecaptchaOptions = {
        theme: 'custom',
        custom_theme_widget: 'recaptcha_widget'
    };




</script>

