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
        <form id='form3' action="ConsignServlet" method="POST" onsubmit="return validation()">
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
                                                                    <input type="text" id="txtFullName" name="txtFullName"  class="form-control" maxlength="50"  placeholder="" value="${member.name}">

                                                                    <p class="help-block" id="erFullName"> </p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-sm-4">Delivery date<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-group  date-picker input-daterange" data-date="10/11/2012" data-date-format="mm/dd/yyyy" data-date-start-date="0d">
                                                                        <input type="text" id="txtFromDate" name="txtFromDate"  class="form-control" >
                                                                        <span class="input-group-addon">
                                                                            to </span>
                                                                        <input type="text" id="txtToDate" name="txtToDate" class="form-control" >
                                                                    </div>

                                                                    <span class="help-block" id="erDate">
                                                                    </span>
                                                                </div>
                                                            </div>


                                                            <div class="form-group">
                                                                <label for="txtAddress" class="col-sm-4 control-label"> Address </label>
                                                                <div class="col-sm-8">
                                                                    <textarea id="txtAddress" name="txtAddress" class="form-control" maxlength="225" rows="6" placeholder="" >${member.address}</textarea>
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
                                                                        <input type="radio" name="rdContact" id="optionsRadios4" value="phone" checked> Phone </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdContact" id="optionsRadios5" value="email"> Email </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdContact" id="optionsRadios6" value="both"> Both </label>
                                                                </div>

                                                            </div>


                                                            <div class="form-group" id="divPhone">
                                                                <label for="txtPhone" class="col-sm-4 control-label"> Phone<span class="required">*</span> </label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" id="txtPhone" name="txtPhone" class="form-control"   placeholder="" value="${member.phone}" />
                                                                    <p class="help-block" id="erPhone"></p>

                                                                </div>
                                                            </div>

                                                            <div class="form-group" id="divEmail" style="display: none;">
                                                                <label for="txtEmail" class="col-sm-4 control-label">Email<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" id="txtEmail" name="txtEmail" class="form-control"  placeholder="example@abc.com" value="${member.email}">
                                                                    <p class="help-block" id="erEmail"></p>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="" class="col-sm-4 control-label"> Payment method </label>

                                                                <div class="radio-list col-sm-8">
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdPayment" id="optionsRadios7" value="direct" checked> Direct </label>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="rdPayment" id="optionsRadios8" value="cc"> Credit card </label>
                                                                </div>

                                                            </div>

                                                            <div id="divCCNumber" class="form-group" style="display: none" >
                                                                <label for="txtCardNumber" class="col-sm-4 control-label"> Card number<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" id="txtCardNumber" name="txtCardNumber" class="form-control"   placeholder="" value="${member.cardNumber}"/>

                                                                    <p class="help-block" id="erCardNumber"></p>
                                                                </div>
                                                            </div>

                                                            <div id="divCCOwner" class="form-group" style="display: none">
                                                                <label for="txtCardOwner" class="col-sm-4 control-label">Card owner<span class="required">*</span></label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" id="txtCardOwner" name="txtCardOwner"  class="form-control" id="txtCreaditCardOwner" placeholder="" value="${member.cardOwner}">
                                                                    <p class="help-block" id="erCardOwner"></p>
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
        if ($(this).val() == "cc") {
            $("#divCCNumber").show();
            $("#divCCOwner").show();
        }
        else {
            $("#divCCNumber").hide();
            $("#divCCOwner").hide();

        }
    });
    
    function validation(){
        if(jQuery("#form3").context.activeElement.value == 'backstep2'){
            return true;
        }
        var check = true;
        var dateError = "";
        
        if($('#txtFullName').val().trim().length < 5 || $('#txtFullName').val().trim().length > 50){
            $('#erFullName').html("<font color='red'>Required 5-50 characters</font>");
            check = false;
        }
        else{
            $('#erFullName').html("");
        }
        
        var fromDate = $('#txtFromDate').val().trim();
        var toDate = $('#txtToDate').val().trim();
        if(fromDate.length == 0 ){
            dateError += "<font color='red'>From date is required</font> ";
        }
        if(toDate.length == 0 ){
            if(dateError.length > 0){
                dateError += "<font color='red'>and To date is required</font>";
            }else{
                dateError += "<font color='red'>To date is required</font>";
            }   
        }
        if(dateError.length > 0){
            $('#erDate').html(dateError);
            check = false;
        }else{
            $('#erDate').html("");
        }
        
        var contact = $('input:radio[name="rdContact"]:checked').val();
        if(contact == "phone"){
            if($('#txtPhone').val().trim().length == 0){
                $('#erPhone').html("<font color='red'>Phone is required</font>");
                check = false;
            }
            else{
                $('#erPhone').html("");
            }
        }
        else if(contact == "email"){
            if($('#txtEmail').val().trim().length == 0){
                $('#erEmail').html("<font color='red'>Email is required</font>");
                check = false;
            }
            else{
                $('#erEmail').html("");
            }
        }
        else{
            if($('#txtPhone').val().trim().length == 0){
                $('#erPhone').html("<font color='red'>Phone is required</font>");
                check = false;
            }
            else{
                $('#erPhone').html("");
            }
            if($('#txtEmail').val().trim().length == 0){
                $('#erEmail').html("<font color='red'>Email is required</font>");
                check = false;
            }
            else{
                $('#erEmail').html("");
            }
        }
        
        var payment = $('input:radio[name="rdPayment"]:checked').val();
        if(payment == "cc"){
            if($('#txtCardNumber').val().trim().length == 0){
                $('#erCardNumber').html("<font color='red'>Card number is required</font>");
                check = false;
            }
            else{
                $('#erCardNumber').html("");
            }
            if($('#txtCardOwner').val().trim().length < 5 || $('#txtCardOwner').val().trim().length > 50){
                $('#erCardOwner').html("<font color='red'>Required 5-50 characters</font>");
                check = false;
            }
            else{
                $('#erCardOwner').html("");
            }
        }
        return check;
    }

</script>
