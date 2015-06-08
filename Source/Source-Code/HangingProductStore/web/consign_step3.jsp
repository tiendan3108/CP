<%-- 
    Document   : consign_step3
    Created on : May 30, 2015, 9:32:08 PM
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


        <!-- BEGIN DIV STEP3 -->
        <form action="ConsignServlet" method="POST">
            <div id="divStep3" class="row">
                <div class="col-md-12">
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
                                                    <span class="desc" style="font-size:125%">
                                                        <i class="fa fa-check"></i> Product's info </span>
                                                </a>
                                            </li>
                                            <li class="done">
                                                <a id="ltap2" class="step">
                                                    <span class="number">
                                                        2 </span>
                                                    <span class="desc" style="font-size:125%">
                                                        <i class="fa fa-check"></i> Choose store </span>
                                                </a>
                                            </li>
                                            <li class="active">
                                                <a id="ltap3"  class="step active">
                                                    <span class="number">
                                                        3 </span>
                                                    <span class="desc" style="font-size:125%">
                                                        <i class="fa fa-check"></i> <b>Personal info</b>  </span>
                                                </a>
                                            </li>

                                        </ul>
                                        
                                        <hr/>
                                        <c:set var="member" value="${sessionScope.MEMBER}"/>
                                        <div class="tab-content">

                                            <div>
                                                <div class="row">

                                                    <div class="col-sm-6">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label for="txtFullName" class="col-sm-4 control-label">Full name<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" class="form-control" maxlength="50" name="txtFullName" placeholder="" value="${member.name}">

                                                                    <p class="help-block" id="erFullName"> </p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-sm-4">Delivery date<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-group  date-picker input-daterange" data-date="10/11/2012" data-date-format="dd/mm/yyyy" data-date-start-date="0d">
                                                                        <input type="text" class="form-control" name="txtFromDate">
                                                                        <span class="input-group-addon">
                                                                            to </span>
                                                                        <input type="text" class="form-control" name="txtToDate">
                                                                    </div>
                                                                    
                                                                    <span class="help-block" id="erDate">
                                                                         </span>
                                                                </div>
                                                            </div>


                                                            <div class="form-group">
                                                                <label for="txtAddress" class="col-sm-4 control-label"> Address </label>
                                                                <div class="col-sm-8">
                                                                    <textarea name="txtAddress" class="form-control" maxlength="225" rows="6" placeholder="" value="${member.address}"></textarea>
                                                                     <span class="help-block" id="erAddress">
                                                                         </span>
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>

                                                    <div class="col-sm-6">
                                                        <div class="form-horizontal">

                                                            <div class="form-group">
                                                                <label for="" class="col-sm-4 control-label"> Contact by </label>

                                                                <div class="radio-list col-sm-8">
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdContact" id="optionsRadios4" value="Phone" checked> Phone </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdContact" id="optionsRadios5" value="Email"> Email </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdContact" id="optionsRadios6" value="Both"> Both </label>
                                                                </div>

                                                            </div>


                                                            <div class="form-group" id="divPhone">
                                                                <label for="txtPhone" class="col-sm-4 control-label"> Phone<span class="required">*</span> </label>
                                                                <div class="col-sm-8">
                                                                    <input name="txtPhone" class="form-control"  type="text" placeholder="" value="${member.phone}" />
                                                                    <p class="help-block"></p>

                                                                </div>
                                                            </div>

                                                            <div class="form-group" id="divEmail" style="display: none;">
                                                                <label for="txtEmail" class="col-sm-4 control-label">Email<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" class="form-control" name="txtEmail" placeholder="example@abc.com" value="${member.email}">
                                                                    <p class="help-block"></p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="" class="col-sm-4 control-label"> Payment method </label>

                                                                <div class="radio-list col-sm-8">
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdPayment" id="optionsRadios7" value="Phone" checked> Direct </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdPayment" id="optionsRadios8" value="CC"> Credit card </label>
                                                                </div>

                                                            </div>

                                                            <div id="divCCNumber" class="form-group" style="display: none" >
                                                                <label for="txtCardNumber" class="col-sm-4 control-label"> Card number<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input name="txtCardNumber" class="form-control"  type="text" placeholder="" value="${member.cardNumber}"/>


                                                                    <p class="help-block"></p>
                                                                </div>
                                                            </div>

                                                            <div id="divCCOwner" class="form-group" style="display: none">
                                                                <label for="txtCardOwner" class="col-sm-4 control-label">Card owner<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input name="txtCardOwner" type="text" class="form-control" id="txtCreaditCardOwner" placeholder="" value="${member.cardOwner}">
                                                                    <p class="help-block"></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>													

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
                                                <button  name="btnAction" type="submit" value="backstep2" class=" btn-block btn-lg btn btn-primary"><i class="m-icon-big-swapleft m-icon-white"></i>BACK</button>
                                            </div>
                                            <div class="col-sm-4"> </div>
                                            <div class="col-sm-4">
                                                <button name="btnAction" value="complete" type="submit" class="btn-block btn-lg btn btn blue" >CONSIGN <i class="m-icon-big-swapup m-icon-white"></i></button>
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
        </form>

       
                    



                    </jsp:body>
                </template:consignbasic>
                <script type="text/javascript">
                    var RecaptchaOptions = {
                        theme: 'custom',
                        custom_theme_widget: 'recaptcha_widget'
                    };



                    $('input:radio[name="rdContact"]').change(function () {
                        if ($(this).val() == "Phone") {
                            $("#divPhone").show();
                            $("#divEmail").hide();
                            $("#divEmail").val() == "";
                        }
                        else if ($(this).val() == "Email") {
                            $("#divPhone").hide();
                            $("#divPhone").val() == "";
                            $("#divEmail").show();
                        }
                        else if ($(this).val() == "Both") {
                            $("#divPhone").show();
                            $("#divEmail").show();
                        }


                    });


                    $('input:radio[name="rdPayment"]').change(function () {
                        if ($(this).val() == "CC") {
                            $("#divCCNumber").show();
                            $("#divCCOwner").show();
                        }
                        else {
                            $("#divCCNumber").hide();
                            $("#divCCOwner").hide();

                        }
                    });

                </script>
